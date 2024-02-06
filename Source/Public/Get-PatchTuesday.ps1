Function Get-PatchTuesday {
   <#
.SYNOPSIS
   Returns the second Tuesday of the month

.DESCRIPTION
   This function allow you to pass a date, or a month/year combination to find the second Tuesday (aka Patch Tuesday) of any month

.PARAMETER Date
   The datetime value to return the second Tuesday for the month

.PARAMETER Month
   The month to return the second Tuesday for. Enter a value from 1 to 12.

.PARAMETER Year
   The year to return the second Tuesday for. Enter a value from 1 to 9999

.EXAMPLE
   Get-PatchTuesday
   Returns the second Tuesday for the current month

.EXAMPLE
   Get-PatchTuesday -Date "11/17/2021"
   Returns the second Tuesday for November 2021

.EXAMPLE
   Get-PatchTuesday -Month 6 -Year 2020
   Returns the second Tuesday for June 2020

.EXAMPLE
   Get-PatchTuesday -Month 4
   Returns the second Tuesday for April of the current year

.OUTPUTS
   A datetime object of the second Tuesday.
#>
   [CmdletBinding(DefaultParameterSetName = 'Date')]
   [OutputType([datetime])]
   param(
      [Parameter(Mandatory = $false, ParameterSetName = "Date")]
      [datetime]$Date = $(Get-Date),
      [Parameter(Mandatory = $false, ParameterSetName = "MonthYear")]
      [ValidateRange(1, 12)]
      [int]$Month = $(Get-Date).Month,
      [Parameter(Mandatory = $false, ParameterSetName = "MonthYear")]
      [ValidateRange(1, 9999)]
      [int]$Year = $(Get-Date).Year
   )
   
   if ($PsCmdlet.ParameterSetName -eq "MonthYear") {
      $date = (Get-Date -Day 1 -Month $Month -Year $Year).Date
   }
   
   # Get the first day of the month
   $StartOfMonth = Get-Date $date.Date -Day 1

   # Get every Tuesday, and return the second one
   $ptdate = (0..30 | Foreach-Object { $StartOfMonth.adddays($_) } | Where-Object { $_.dayofweek.value__ -eq 2 })[1]
   $ptdate.Date
}
