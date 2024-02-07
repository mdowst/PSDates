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

   # Extract individual components from the WMI DateTime string
   $year = [int]$WmiTime.Substring(0, 4)
   $month = [int]$WmiTime.Substring(4, 2)
   $day = [int]$WmiTime.Substring(6, 2)
   $hour = [int]$WmiTime.Substring(8, 2)
   $minute = [int]$WmiTime.Substring(10, 2)
   $second = [int]$WmiTime.Substring(12, 2)
   $millisecond = [int]$WmiTime.Substring(15, 6)

   # Create a DateTime object
   $dateTime = [datetime]::SpecifyKind(([datetime]"$year-$month-$day $($hour):$($minute):$second.$millisecond"), 'Utc')

   # Create a TimeSpan object for the UTC offset
   if ($WmiTime -match '\+') {
      $offsetMinutes = [int]$WmiTime.Split('+')[-1]
      $offset = New-TimeSpan -Minutes $offsetMinutes
      # Adjust for the UTC offset
      $dateTime = $dateTime.Add(-$offset)
   }
   elseif ($WmiTime -match '\-') {
      $offsetMinutes = [int]$WmiTime.Split('-')[-1]
      $offset = New-TimeSpan -Minutes $offsetMinutes
      # Adjust for the UTC offset
      $dateTime = $dateTime.Add($offset)
   }
   
   # Convert to local time and output
   $dateTime.ToLocalTime()
}
