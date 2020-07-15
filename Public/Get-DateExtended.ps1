Function Get-DateExtended {
   <#
.SYNOPSIS
   Gets common extended date values that are not included by default with the Get-Date cmdlet

.DESCRIPTION
   This function includes added values for: 
    FirstDayOfYear : First day of the year
    LastDayOfYear  : Last day of the year
    StartOfWeek    : First day of the week
    EndOfWeek      : Last day of the week 
    StartOfMonth   : First day of the month
    EndOfMonth     : Last day of the month
    TimeZone       : Current machine timezone
    Quater         : The quarter of the year.

   All dates are based on the date passed. If no date is passed in the current date and time are used.

.PARAMETER Date
   The datetime value to return the information for

.EXAMPLE
   Get-DateExtended
   Gets extended date and time information based on the current time

.EXAMPLE
   Get-DateExtended "11/17/2017"
   Gets extended date and time information for a specific date

.OUTPUTS
   A PSObject containing extended values for the date. 
#> 
   [CmdletBinding()]
   [OutputType('DateTimeExtended')]
   param(
      [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [Alias("LastWriteTime")]
      [DateTime]$Date = [DateTime]::Now,
        
      [Parameter()]
      [switch] $FromUnixTime,

      [Parameter()]
      [ValidateRange(1, 9999)]
      [int] $Year,

      [Parameter()]
      [ValidateRange(1, 12)]
      [int] $Month,

      [Parameter()]
      [ValidateRange(1, 31)]
      [int] $Day,

      [Parameter()]
      [ValidateRange(0, 23)]
      [int] $Hour,

      [Parameter()]
      [ValidateRange(0, 59)]
      [int] $Minute,

      [Parameter()]
      [ValidateRange(0, 59)]
      [int] $Second,

      [Parameter()]
      [ValidateRange(0, 999)]
      [int] $Millisecond,

      [Parameter()]
      [ValidateSet('Date', 'Time', 'DateTime')]
      [string] $DisplayHint
   )
   
   
   [DateTimeExtended]::New((Get-Date @PSBoundParameters))

}
