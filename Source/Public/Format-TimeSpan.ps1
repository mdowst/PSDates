function Format-TimeSpan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [TimeSpan]$TimeSpan,

        # Include zero-valued trailing parts (e.g., "1 year, 0 months, 0 days, ...")
        [switch]$IncludeZeros
    )

    begin {
        function Add-Part([int]$n, [string]$label) {
            if ($n -gt 0 -or $IncludeZeros) {
                "$n $label" + ($(if ($n -eq 1) { '' } else { 's' }))
            }
        }
    }

    process {
        $sign = if ($TimeSpan.TotalSeconds -lt 0) { '-' } else { '' }
        $ts = $TimeSpan.Duration()

        # Use a fixed anchor so month/year math respects calendar lengths.
        $anchor = Get-Date '2000-01-01T00:00:00Z'
        $cursor = $anchor
        $end = $anchor + $ts

        # Years
        $years = ($end.Year - $cursor.Year)
        $cursor = $cursor.AddYears($years)
        if ($cursor -gt $end) { $years--; $cursor = $cursor.AddYears(-1) }

        # Months
        $months = 0
        while ($cursor.AddMonths(1) -le $end) {
            $months++
            $cursor = $cursor.AddMonths(1)
        }

        # Remaining as a TimeSpan
        $remaining = $end - $cursor
        $days = $remaining.Days
        $hours = $remaining.Hours
        $minutes = $remaining.Minutes
        $seconds = [int][math]::Round($remaining.Seconds + $remaining.Milliseconds / 1000, 0)

        # Carry rounding if seconds hit 60
        if ($seconds -ge 60) { $seconds -= 60; $minutes++ }
        if ($minutes -ge 60) { $minutes -= 60; $hours++ }
        if ($hours -ge 24) { $hours -= 24; $days++ }

        $parts = @()
        $parts += Add-Part $years   'year'
        $parts += Add-Part $months  'month'
        $parts += Add-Part $days    'day'
        $parts += Add-Part $hours   'hour'
        $parts += Add-Part $minutes 'minute'
        $parts += Add-Part $seconds 'second'

        if (-not $IncludeZeros) { $parts = $parts | Where-Object { $_ -and $_ -notmatch '^\s*0 ' } }
        if (-not $parts) { $parts = @('0 seconds') }

        ($sign + ($parts -join ', '))
    }
}
