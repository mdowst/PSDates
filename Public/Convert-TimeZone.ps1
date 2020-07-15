Function Convert-TimeZone {
   <#
.SYNOPSIS
   Convert a datetime value from one time zone to another

.DESCRIPTION
   This function will allows you to pass a date to convert from one time zone to another. 
   If no date is specified the local time is used. If no FromTimeZone is passed then the 
   local time zone is used.
   If you don't know the time zone ID you can use the Find-TimeZone cmdlet.

.PARAMETER ToTimeZone
   The time zone ID of the time zone you want to convert the date to 

.PARAMETER date
   The date to convert. If not specified the current time will be used

.PARAMETER FromTimeZone
   The time zone ID of the time zone you want to convert the date from. If not specified the local time zone will be used 

.EXAMPLE
    Convert-TimeZone -ToTimeZone "GMT Standard Time"

    Convert the local system time to GMT Standard Time
    
.EXAMPLE
   Convert-TimeZone -date '11/17/2017 12:34 AM' -FromTimeZone "China Standard Time" -ToTimeZone "US Mountain Standard Time"

   Converts the date and time 11/17/2017 12:34 AM from 'China Standard Time' to 'US Mountain Standard Time'
   
.OUTPUTS
   A PSObject object containing the time zone conversion data
#> 
   param(
      [parameter(Mandatory = $True)]
      [Validatescript( { try { $id = $_; [System.TimeZoneInfo]::FindSystemTimeZoneById($_) }
            catch { throw("'$Id' is not a valid time zone Id. Use the Find-TimeZone cmdlet to find the valid time zone Id.") } })]
      [string]$ToTimeZone,

      [Parameter(Mandatory = $false)]
      [datetime]$date = $(Get-Date),
       
      [parameter(Mandatory = $false)]
      [Validatescript( { try { $id = $_; [System.TimeZoneInfo]::FindSystemTimeZoneById($_) }
            catch { throw("'$Id' is not a valid time zone Id. Use the Find-TimeZone cmdlet to find the valid time zone Id.") } })]
      [string]$FromTimeZone = [System.TimeZoneInfo]::Local.Id.ToString()
   )

   $DateTime = [DateTime]::SpecifyKind($date, [DateTimeKind]::Unspecified)
   $from = [System.TimeZoneInfo]::FindSystemTimeZoneById($FromTimeZone)
   $to = [System.TimeZoneInfo]::FindSystemTimeZoneById($ToTimeZone)
   $utc = [System.TimeZoneInfo]::ConvertTimeToUtc($DateTime, $from)
   $newTime = [System.TimeZoneInfo]::ConvertTime($utc, $to)
    
   [PSCustomObject]@{
        
      PsTypeName   = 'TimeZoneConversion'
    
      FromDateTime = $Date
      FromTimeZone = $FromTimeZone
      ToDateTime   = $newTime
      ToTimeZone   = $ToTimeZone

      Offset       = (New-TimeSpan -Start $date -End  $newTime)
   }
}