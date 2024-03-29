Function ConvertFrom-UnixTime {
   <#
.SYNOPSIS
   Converts a Unix Time value to a datetime value

.DESCRIPTION
   This function will return the datetime based on the unix epoch time.

.PARAMETER UnixTime
   The UnixTime value to return the datetime for

.EXAMPLE
   ConvertFrom-UnixTime -UnixTime 1509512400
   Gets datetime for the Unix time 1509512400

.OUTPUTS
   The datetime value based on the unix time

#>
   [CmdletBinding()]
   [OutputType([datetime])]
   param(
      [Parameter(Mandatory = $true)]
      [double]$UnixTime
   )

   (Get-Date '1970-01-01T00:00:00.000Z').ToUniversalTime().AddSeconds($UnixTime)
}
