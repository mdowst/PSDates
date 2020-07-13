Function ConvertTo-WmiDateTime {
   <#
.SYNOPSIS
   Converts a datetime value to a Wmi datetime string

.DESCRIPTION
   This function will return the WMI datetime string based on a datetime passed.

.PARAMETER WmiTime
   The WmiTime value to return the datetime for
   
.EXAMPLE
   ConvertTo-WmiDateTime -Date '06/25/2019 16:17'
   
   Return the WMI datetime string for the datetime of "06/25/2019 16:17"

.OUTPUTS
   The string value based on the datetime
#>
   [CmdletBinding()]
   [OutputType([string])]
   param(
      [Parameter(Mandatory = $false)]
      [datetime]$Date = (Get-Date)
   )
        
   [Management.ManagementDateTimeConverter]::ToDmtfDateTime($Date)
}