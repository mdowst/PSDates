Function ConvertFrom-WmiDateTime {
   <#
.SYNOPSIS
   Converts a Wmi Time value to a datetime value

.DESCRIPTION
   This function will return the datetime based on a WMI datetime string.

.PARAMETER WmiTime
   The WmiTime value to return the datetime for

.EXAMPLE
   ConvertFrom-WmiDateTime -WmiTime '20190912173652.000000-300'
   Gets datetime for the Wmi time 20190912173652.000000-300

.OUTPUTS
   The datetime value based on the wmi time
#>
   [CmdletBinding()]
   [OutputType([datetime])]
   param(
      [Parameter(Mandatory = $true)]
      [string]$WmiTime
   )

   [Management.ManagementDateTimeConverter]::ToDateTime($WmiTime)
}
