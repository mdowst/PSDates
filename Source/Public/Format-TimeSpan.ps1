function Format-TimeSpan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [TimeSpan]$TimeSpan,

        [switch]$IncludeZeros,

        # Let callers override culture without changing session UI culture
        [System.Globalization.CultureInfo]$Culture
    )

    begin {
        function Get-Resource {
            param([string]$FileName = 'Format.TimeSpan.strings.psd1',
                [System.Globalization.CultureInfo]$Culture)
            $loc = $null
            if ($Culture) {
                Import-LocalizedData -BaseDirectory $PSScriptRoot -UICulture $Culture.Name -BindingVariable loc -FileName $FileName -ErrorAction SilentlyContinue
            }
            if (-not $loc) { $loc = $Localized } # fall back to module-level default
            return $loc
        }

        function Select-Form {
            param(
                [int]$n,
                [hashtable]$Forms
            )
            if ($Forms.ContainsKey('One') -and $n -eq 1) { $Forms.One } else { $Forms.Other }
        }

        function Part {
            param(
                [int]$n,
                [hashtable]$Forms
            )
            if ($n -lt 0) { return $null }
            $template = Select-Form -n $n -Forms $Forms
            return ($template -f $n)   # <- apply format operator to the *result*
        }
    }

    process {
        $L = Get-Resource -Culture $Culture

        $sign = if ($TimeSpan.TotalSeconds -lt 0) { $L.NegativeSign } else { '' }
        $ts = $TimeSpan.Duration()

        # --- calendar-aware breakdown (your existing logic) ---
        $anchor = Get-Date '2000-01-01T00:00:00Z'
        $cursor = $anchor
        $end = $anchor + $ts

        $years = ($end.Year - $cursor.Year); $cursor = $cursor.AddYears($years)
        if ($cursor -gt $end) { $years--; $cursor = $cursor.AddYears(-1) }

        $months = 0
        while ($cursor.AddMonths(1) -le $end) { $months++; $cursor = $cursor.AddMonths(1) }

        $remaining = $end - $cursor
        $days = $remaining.Days
        $hours = $remaining.Hours
        $minutes = $remaining.Minutes
        $seconds = [int][math]::Round($remaining.Seconds + $remaining.Milliseconds / 1000, 0)

        if ($seconds -ge 60) { $seconds -= 60; $minutes++ }
        if ($minutes -ge 60) { $minutes -= 60; $hours++ }
        if ($hours -ge 24) { $hours -= 24; $days++ }

        $parts = @()
        if ($IncludeZeros -or $years) { $parts += Part $years   $L.Year }
        if ($IncludeZeros -or $months) { $parts += Part $months  $L.Month }
        if ($IncludeZeros -or $days) { $parts += Part $days    $L.Day }
        if ($IncludeZeros -or $hours) { $parts += Part $hours   $L.Hour }
        if ($IncludeZeros -or $minutes) { $parts += Part $minutes $L.Min }
        if ($IncludeZeros -or $seconds) { $parts += Part $seconds $L.Sec }

        if (-not $parts -or ($parts -join '') -eq '') { return $L.ZeroFallback }

        $sign + (($parts | Where-Object { $_ }) -join $L.Separator)
    }
}