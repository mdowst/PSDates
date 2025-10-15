function Format-TimeSpan {
<#
.SYNOPSIS
Formats TimeSpan objects into human-readable, localized text

.DESCRIPTION
The `Format-TimeSpan` cmdlet formats a .NET `TimeSpan` object into a human-readable string representation. It allows you to customize the output based on culture settings, optionally include zero-value time components, and control progress reporting. This cmdlet is useful for displaying durations in scripts, logs, or user interfaces in a clear and localized format. You can specify the culture for formatting, choose whether to display components with zero values (such as hours or minutes), and adjust progress action preferences. The cmdlet accepts a `TimeSpan` object as input and outputs a formatted string suitable for display or further processing.

.PARAMETER TimeSpan
Specifies the TimeSpan object to be formatted. Provide the TimeSpan value that you want to convert to a formatted string.

.PARAMETER IncludeZeros
Specifies that zero values (such as zero days, hours, minutes, or seconds) are included in the formatted output.

.PARAMETER Culture
Specifies the culture to use for formatting the output. You can provide a `CultureInfo` object or a culture name string (such as `"en-US"`, `"fr-FR"`, or `"de-DE"`). This determines the language and formatting conventions used for the output. For example, to use French formatting, specify `-Culture "fr-FR"`. If not specified, the current culture is used.

.EXAMPLE
PS C:\> Format-TimeSpan -TimeSpan (New-TimeSpan -Hours 2 -Minutes 30 -Seconds 15) -IncludeZeros

2 hours, 30 minutes, 15 seconds

This example formats a TimeSpan of 2 hours, 30 minutes, and 15 seconds, including zero-value components in the output.


#>
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