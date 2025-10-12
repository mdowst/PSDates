function Get-DateSummary {
    <#
.SYNOPSIS
Summarizes a sequence of timestamps (earliest, latest, total span) and gap statistics.

.DESCRIPTION
Get-DateSummary takes a stream (or array) of timestamps and returns a single summary object
that includes:
- Count of non-null timestamps
- Earliest and latest timestamps
- Total span (Latest - Earliest)
- Gap statistics between consecutive timestamps (Average, Median, Min, Max)

Input can be DateTime values directly, strings that cast to DateTime, or arbitrary objects
when -TimeProperty is specified. Use -AsUtc to normalize all timestamps to UTC before analysis.

.PARAMETER InputObject
Objects flowing in the pipeline. These can be DateTime, string (parsable to DateTime),
or any object if -TimeProperty is used.

.PARAMETER TimeProperty
Name of the property on each input object that contains the timestamp.

.PARAMETER AsUtc
Normalize all timestamps to UTC prior to analysis (uses .ToUniversalTime()).

.PARAMETER RoundTo
Optionally round timestamps prior to analysis. Useful for noisy data.
Valid values: Second, Minute, Hour, Day.

.OUTPUTS
PSCustomObject (TypeName: PSDates.DateSummary)
Properties:
- Count, NullsSkipped, Earliest, Latest, Span
- AverageGap, MedianGap, MinGap, MaxGap
- UniqueDays

.EXAMPLE
# Direct DateTime input
1..5 | ForEach-Object { (Get-Date).AddMinutes($_ * 10) } | Get-DateSummary

.EXAMPLE
# Objects with a Time property
$events | Get-DateSummary -TimeProperty Time

.EXAMPLE
# Normalize to UTC and round to the nearest minute
$events | Get-DateSummary -TimeProperty Timestamp -AsUtc -RoundTo Minute

.NOTES
If fewer than 2 timestamps are provided, gap metrics are set to [TimeSpan]::Zero.
Null or unparsable values are skipped and counted in NullsSkipped.
#>
    [CmdletBinding()]
    [OutputType('PSDates.DateSummary')]
    param(
        [Parameter(ValueFromPipeline = $true)]
        $InputObject,

        [Parameter()]
        [string] $TimeProperty,

        [Parameter()]
        [switch] $AsUtc,

        [Parameter()]
        [ValidateSet('Second', 'Minute', 'Hour', 'Day')]
        [string] $RoundTo
    )

    begin {
        $times = New-Object System.Collections.Generic.List[datetime]
        $nulls = 0

        function _TryGetDate([object]$obj, [string]$prop) {
            if ($null -eq $obj) { return $null }
            $value =
            if ([string]::IsNullOrWhiteSpace($prop)) { $obj }
            else {
                if ($obj.PSObject.Properties.Match($prop).Count -gt 0) {
                    $obj.$prop
                }
                else {
                    $null
                }
            }

            if ($null -eq $value) { return $null }

            # Already DateTime?
            if ($value -is [datetime]) { return $value }

            # Try parse/cast from string or number
            try {
                # Allow unix epoch (seconds) as integer/long
                if ($value -is [int] -or $value -is [long]) {
                    return ([datetime]'1970-01-01Z').AddSeconds([double]$value)
                }
                # Fall back to DateTime cast
                return [datetime]$value
            }
            catch {
                return $null
            }
        }

        function _Round([datetime]$dt, [string]$unit) {
            if (-not $unit) { return $dt }
            switch ($unit) {
                'Second' { return Get-Date -Date $dt -Second $dt.Second -Millisecond 0 }
                'Minute' { return Get-Date -Date $dt -Minute $dt.Minute -Second 0 -Millisecond 0 }
                'Hour' { return Get-Date -Date $dt -Hour   $dt.Hour   -Minute 0 -Second 0 -Millisecond 0 }
                'Day' { return Get-Date -Date $dt.Date }
                default { return $dt }
            }
        }
    }

    process {
        $dt = _TryGetDate -obj $InputObject -prop $TimeProperty
        if ($null -ne $dt) {
            if ($AsUtc) { $dt = $dt.ToUniversalTime() }
            if ($RoundTo) { $dt = _Round -dt $dt -unit $RoundTo }
            [void]$times.Add($dt)
        }
        else {
            $nulls++
        }
    }

    end {
        if ($times.Count -eq 0) {
            return [DateSummary]::new()
        }

        $sorted = $times | Sort-Object
        $earliest = $sorted[0]
        $latest = $sorted[-1]
        $span = if ($sorted.Count -gt 1) { $latest - $earliest } else { [TimeSpan]::Zero }

        # Build consecutive gaps (Latest_i - Latest_{i-1})
        $gaps = New-Object System.Collections.Generic.List[TimeSpan]
        for ($i = 1; $i -lt $sorted.Count; $i++) {
            $gaps.Add($sorted[$i] - $sorted[$i - 1]) | Out-Null
        }

        if ($gaps.Count -gt 0) {
            $ticks = $gaps | ForEach-Object { $_.Ticks }

            $avgTicks = [long](([double]($ticks | Measure-Object -Average).Average))
            # Median
            $sortedTicks = $ticks | Sort-Object
            $mid = [int][math]::Floor($sortedTicks.Count / 2)
            if ($sortedTicks.Count % 2 -eq 0) {
                $medianTicks = [long]([math]::Round( ( ($sortedTicks[$mid - 1] + $sortedTicks[$mid]) / 2.0 ), 0))
            }
            else {
                $medianTicks = [long]$sortedTicks[$mid]
            }

            $minTicks = [long]($ticks | Measure-Object -Minimum).Minimum
            $maxTicks = [long]($ticks | Measure-Object -Maximum).Maximum

            $avgGap = [TimeSpan]::FromTicks($avgTicks)
            $medianGap = [TimeSpan]::FromTicks($medianTicks)
            $minGap = [TimeSpan]::FromTicks($minTicks)
            $maxGap = [TimeSpan]::FromTicks($maxTicks)
        }
        else {
            $avgGap = $medianGap = $minGap = $maxGap = [TimeSpan]::Zero
        }

        $uniqueDays = ($sorted | ForEach-Object { $_.ToString('yyyy-MM-dd') } | Select-Object -Unique).Count

        [DateSummary]::new(
            @{
                Count        = $sorted.Count
                NullsSkipped = $nulls
                Earliest     = $earliest
                Latest       = $latest
                Span         = $span
                AverageGap   = $avgGap
                MedianGap    = $medianGap
                MinGap       = $minGap
                MaxGap       = $maxGap
                UniqueDays   = $uniqueDays
            }
        )
    }
}
