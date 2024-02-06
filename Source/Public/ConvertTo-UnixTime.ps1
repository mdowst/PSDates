Function ConvertTo-UnixTime {
   <#
.SYNOPSIS
   Converts a datetime value to Unix Time
.DESCRIPTION
   This function will return the unix time based on the unix epoch time. If no date is passed in the current date and time is used.
.PARAMETER Date
   The datetime value to return the unix time for
.EXAMPLE
   ConvertTo-UnixTime
   Gets unix time for the current time
.EXAMPLE
   ConvertTo-UnixTime -date "11/17/2017"
   Gets unix time for a specific date
.OUTPUTS
   The int32 value of the unix time
#>
   [CmdletBinding()]
   [OutputType([int32])]
   param(
      [Parameter(Mandatory = $false)]
      [datetime]$date = $(Get-Date)
   )

   [int][double]::Parse((Get-Date ($date).touniversaltime() -UFormat %s))
}
