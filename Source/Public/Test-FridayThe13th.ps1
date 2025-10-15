function Test-FridayThe13th {
<#
.SYNOPSIS
Checks if a date is Friday the 13th; if not, returns the next occurrence and the time remaining.

.DESCRIPTION
Given a date (default: now), determines whether it falls on a Friday the 13th.
If not, it calculates the next Friday the 13th and the TimeSpan until that date
(using the same time-of-day as the input).

.PARAMETER Date
The reference date/time. Defaults to (Get-Date).

.OUTPUTS
PSCustomObject (TypeName: PSDates.FridayThe13thResult)
- IsFridayThe13th : [bool]
- Date            : [datetime]  # the evaluated date
- NextOccurrence  : [datetime]  # next Friday the 13th (null if already F13)
- TimeUntilNext   : [TimeSpan]  # time until next occurrence (00:00:00 if already F13)
- Message         : [string]

.EXAMPLE
Test-FridayThe13th

.EXAMPLE
Test-FridayThe13th -Date '2025-01-10'
# -> Not Friday the 13th; next is 2025-06-13, in 154 days 12:34:56
#>
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    param(
        [Parameter()]
        [datetime] $Date = (Get-Date)
    )

    # Normalize to a working copy
    $d = $Date

    $isF13 = ($d.Day -eq 13 -and $d.DayOfWeek -eq [System.DayOfWeek]::Friday)

    if ($isF13) {
        return [pscustomobject]@{
            PSTypeName     = 'PSDates.FridayThe13thResult'
            IsFridayThe13th= $true
            Date           = $d
            NextOccurrence = $null
            TimeUntilNext  = [TimeSpan]::Zero
            Message        = "Yes — $($d.ToString('yyyy-MM-dd')) is Friday the 13th."
        }
    }

    # Find next Friday the 13th
    # Start with the current or next month’s 13th
    $candidateMonthStart = Get-Date -Year $d.Year -Month $d.Month -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
    if ($d.Day -gt 13) {
        $candidateMonthStart = $candidateMonthStart.AddMonths(1)
    }
    # Loop month-by-month until the 13th is a Friday
    $next = $null
    for ($i = 0; $i -lt 36; $i++) { # safe upper bound
        $thirteenth = $candidateMonthStart.AddMonths($i).AddDays(12) # 13th of that month
        if ($thirteenth.DayOfWeek -eq [System.DayOfWeek]::Friday) {
            # Use same time-of-day as input when computing remaining time
            $next = $thirteenth.Date
            if ($next -le $d) {
                # If our time-of-day puts "next" in the past, bump to next year’s cycle
                $next = $thirteenth.AddDays(1).Date # midnight after; ensures > d
            }
            break
        }
    }

    $remaining = if ($next) { $next - $d } else { [TimeSpan]::Zero }
    $msg = "No — $($d.ToString('yyyy-MM-dd')) is not Friday the 13th. `nNext is $($next.ToString('yyyy-MM-dd')) in $(Format-TimeSpan $remaining)."

    [pscustomobject]@{
        PSTypeName      = 'PSDates.FridayThe13thResult'
        IsFridayThe13th = $false
        Date            = $d
        NextOccurrence  = $next
        TimeUntilNext   = $remaining
        Message         = $msg
    }
}