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
   [CmdletBinding(DefaultParameterSetName = 'Default')]
   [OutputType('DateTimeExtended')]
   param(
      [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = "Default")]
      [Alias("LastWriteTime")]
      [DateTime]$Date = [DateTime]::Now,
        
      [Parameter(ParameterSetName = "Default")]
      [switch] $FromUnixTime,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(1, 9999)]
      [int] $Year,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(1, 12)]
      [int] $Month,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(1, 31)]
      [int] $Day,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(0, 23)]
      [int] $Hour,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(0, 59)]
      [int] $Minute,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(0, 59)]
      [int] $Second,

      [Parameter(ParameterSetName = "Default")]
      [ValidateRange(0, 999)]
      [int] $Millisecond,

      [Parameter(ParameterSetName = "Default")]
      [ValidateSet('Date', 'Time', 'DateTime')]
      [string] $DisplayHint,

      [Parameter(ParameterSetName = "UFormat")]
      [ValidateNotNullOrEmpty]
      [string] $UFormat,

      [Parameter(ParameterSetName = "net")]
      [ValidateSet("FileDate", "FileDateUniversal", "FileDateTime", "FileDateTimeUniversal")]
      [string] $Format,

      [Parameter(ParameterSetName = "net")]
      [switch] $AsUTC
   )
   
   
   [DateTimeExtended]::New((Get-Date @PSBoundParameters))

}
