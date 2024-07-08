Function Get-AnnualHoliday {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $True)]
        [ValidateRange(1, 12)]
        [int]$Month,

        [Parameter(Mandatory = $True, 
            ParameterSetName = "Day")]
        [ValidateRange(1, 31)]
        [int]$Day,

        [Parameter(Mandatory = $True, 
            ParameterSetName = "Week")]
        [ValidateSet('1', '2', '3', '4', 'Last', 'LastFullWeek')]
        [string]$WeekOccurance,

        [Parameter(Mandatory = $True, 
            ParameterSetName = "Week")]
        [ValidateRange(0, 6)]
        [int]$DayOfWeek,

        [Parameter(Mandatory = $false)]
        [ValidateRange(0, 6)]
        [int]$OffsetDays,

        [Parameter(Mandatory = $false)]
        [int]$Year
    )
    
    # Build the date based on parameters
    $DateBuilder = @{
        Day   = 1
        Month = $Month
    }
    if ($PSBoundParameters['Day']) {
        $DateBuilder['Day'] = $Day
    }
    if ($PSBoundParameters['Year']) {
        $DateBuilder.Add('Year', $Year)
    }
    $Date = (Get-Date @DateBuilder).Date

    # Calculate Week Occurance
    if ($PSBoundParameters['WeekOccurance']) {
        $DayOfWeekOccurances = (0..31 | Foreach-Object { $Date.adddays($_) } | Where-Object { $_.Month -eq $Date.Month -and $_.dayofweek.value__ -eq $DayOfWeek })
        $Date = switch ($WeekOccurance) {
            '1' { $DayOfWeekOccurances[0] }
            '2' { $DayOfWeekOccurances[1] }
            '3' { $DayOfWeekOccurances[2] }
            '4' { $DayOfWeekOccurances[3] }
            'Last' { $DayOfWeekOccurances[-1] }
            'LastFullWeek' {
                $LastSaturday = (0..31 | Foreach-Object { $Date.adddays($_) } | Where-Object { $_.Month -eq $Date.Month -and $_.dayofweek.value__ -eq 6 })[-1]
                $Add = (6 - $DayOfWeek) * -1
                $LastSaturday.AddDays($Add)
            }
        }
    }

    # Add Offset Days
    if ($PSBoundParameters['OffsetDays']) {
        $Date = $Date.AddDays($OffsetDays)
    }
    $Date
}
