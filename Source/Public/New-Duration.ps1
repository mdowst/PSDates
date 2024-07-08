Function New-Duration {
<#
.SYNOPSIS
    Calculates the time span between two dates and returns the duration in the ISO 8601 format

.DESCRIPTION
    Calculates the timespan between two dates and returns the duration in the ISO 8601 format

    https://en.wikipedia.org/wiki/ISO_8601#Durations

.PARAMETER Start
Specifies the start of a time span.

.PARAMETER End
Specifies the end of a time span. End date must be greater than the start date

.PARAMETER Years
Specifies the number for yearly interval

.PARAMETER Months
Specifies the number for monthly interval

.PARAMETER Days
Specifies the number for daily interval

.PARAMETER Hours
Specifies the number for hourly interval

.PARAMETER Minutes
Specifies the number for minute interval

.PARAMETER Seconds
Specifies the number for second interval

.PARAMETER Weeks
Specifies the number for weekly interval

.EXAMPLE
New-Duration -Start '2/3/2023' -End (Get-Date)

.EXAMPLE
New-Duration -Days 1 -Hours 4

.EXAMPLE
New-Duration -Weeks 3
#>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true,
            ParameterSetName = "datetime")]
        [datetime]$Start,

        [Parameter(Mandatory = $true,
            ParameterSetName = "datetime")]
        [datetime]$End,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Years = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Months = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Days = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Hours = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Minutes = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Seconds = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "week")]
        [int]$Weeks = 0
    )

    if ($Start -gt $End) {
        throw "Start date must be before the end date"
    }
    if ($PSCmdlet.ParameterSetName -eq 'datetime') {
        # If start date is later in the month offset by 1
        $daysOffset = if ($start.Day -gt $End.Day) { 1 }else { 0 }
        # Get the total months between dates
        $TotalMonths = ($End.Month - $start.Month - $daysOffset) + ($End.Year - $start.Year) * 12
        # Get the number of years
        $Years = [math]::floor($TotalMonths / 12)
        # Get the number of months less the years
        $Months = $TotalMonths % 12
        # Calculate the remaining timespan
        $TimeSpan = New-TimeSpan -Start $start.AddYears($Years).AddMonths($Months) -End $End

        # Set variables to build the string
        $Days = $TimeSpan.Days
        $Hours = $TimeSpan.Hours
        $Minutes = $TimeSpan.Minutes
        $Seconds = $TimeSpan.Seconds
    }

    $Duration = 'P'
    if ($Years -ne 0) { $Duration += "$($Years)Y" }
    if ($Weeks -ne 0) { $Duration += "$($Weeks)W" }
    if ($Months -ne 0) { $Duration += "$($Months)M" }
    if ($Days -ne 0) { $Duration += "$($Days)D" }
    if (($Hours + $Minutes + $Seconds) -ne 0) {
        $Duration += "T"
        if ($Hours -ne 0) { $Duration += "$($Hours)H" }
        if ($Minutes -ne 0) { $Duration += "$($Minutes)M" }
        if ($Seconds -ne 0) { $Duration += "$($Seconds)S" }
    }

    if($Duration -eq 'P'){
        $Duration = 'PT0S'
    }

    $Duration
}
