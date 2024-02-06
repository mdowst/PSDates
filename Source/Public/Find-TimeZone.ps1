Function Find-TimeZone {
   <#
.SYNOPSIS
   Returns Time Zone information

.DESCRIPTION
   This function will return the information for the system time zones. You can search by name and/or hour offsets.
   You can also return the local time zone.

.PARAMETER Name
   All or part of the time zone name. Will be used to perform a wildcard search on the time zones

.PARAMETER Offset
   The number of hours the time zone is offset from UTC

.PARAMETER local
   Use to return the time zone of the current system

.EXAMPLE
   Find-TimeZone -local
   Return the time zone of the local system

.EXAMPLE
   Find-TimeZone -Name "GMT"
   Search for time zones with 'GMT' in the name

.EXAMPLE
   Find-TimeZone -Name "central" -Offset -6
   Search for time zones with 'Central' in the name and have a UTC offset of -6 hours

.OUTPUTS
   The TimeZoneInfo value or values found
#>
   [CmdletBinding()]
   [OutputType([System.TimeZoneInfo])]
   param(
      [parameter(Mandatory = $false)][string]$Name,
      [parameter(Mandatory = $false)][int]$Offset,
      [parameter(Mandatory = $false)][switch]$Local,
      [parameter(Mandatory = $false)][switch]$OutGrid
   )

   if ($Local) {
      [System.TimeZoneInfo]::Local
   }
   else {
      $TimeZones = [System.TimeZoneInfo]::GetSystemTimeZones()

      if ($Name) {
         $TimeZones = $TimeZones | Where-Object { $_.DisplayName -like "*$($Name)*" -or $_.DaylightName -like "*$($Name)*" -or
            $_.StandardName -like "*$($Name)*" -or
            $_.Id -like "*$($Name)*" }
      }

      if ($Offset) {
         $TimeZones = $TimeZones | Where-Object { $_.BaseUtcOffset.Hours -eq $Offset }
      }

      if ($OutGrid) {
         $TimeZones | Out-Gridview -Title "Select the timezone(s) to return" -PassThru
      }
      else {
         $TimeZones
      }

   }
}
