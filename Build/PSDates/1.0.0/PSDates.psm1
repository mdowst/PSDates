#Region '.\Classes\DateTimeExtended.ps1' -1

class DateTimeExtended {
    [datetime]$DateTime
    [datetime]$FirstDayOfYear
    [datetime]$LastDayOfYear
    [datetime]$StartOfWeek
    [datetime]$EndOfWeek
    [datetime]$StartOfMonth
    [datetime]$EndOfMonth
    [string]$WeekOfYear
    [System.TimeZoneInfo]$TimeZone
    [int]$Quater
    [datetime]$Date
    [int]$Day
    [System.DayOfWeek]$DayOfWeek
    [int]$DayOfYear
    [int]$Hour
    [System.DateTimeKind]$Kind
    [int]$Millisecond
    [int]$Minute
    [int]$Month
    [int]$Second
    [long]$Ticks
    [timespan]$TimeOfDay
    [int]$Year

    DateTimeExtended(
        [DateTime]$Date
    ) {
        $local:StartOfWeek = Get-Date $date -hour 0 -minute 0 -second 0
        $local:EndOfWeek = Get-Date $date -hour 23 -minute 59 -second 59
        $local:StartOfMonth = Get-Date $date -day 1 -hour 0 -minute 0 -second 0

        $this.DateTime = $Date
        $this.FirstDayOfYear = (Get-Date $date -hour 0 -minute 0 -second 0 -Day 1 -Month 1) 
        $this.LastDayOfYear = (Get-Date $date -hour 0 -minute 0 -second 0 -Day 31 -Month 12)
        $this.StartOfWeek = ($StartOfWeek.AddDays( - ($StartOfWeek).DayOfWeek.value__))
        $this.EndOfWeek = ($EndOfWeek.AddDays(6 - ($StartOfWeek).DayOfWeek.value__))
        $this.StartOfMonth = ($StartOfMonth)
        $this.EndOfMonth = ((($StartOfMonth).AddMonths(1).AddSeconds(-1)))
        $this.WeekOfYear = (Get-Date $date -uformat %V)
        $this.TimeZone = ([System.TimeZoneInfo]::Local)
        $this.Quater = [Math]::ceiling($Date.Month / 3)
        $this.Date = $Date.Date
        $this.Day = $Date.Day
        $this.DayOfWeek = $Date.DayOfWeek
        $this.DayOfYear = $Date.DayOfYear
        $this.Hour = $Date.Hour
        $this.Kind = $Date.Kind
        $this.Millisecond = $Date.Millisecond
        $this.Minute = $Date.Minute
        $this.Month = $Date.Month
        $this.Second = $Date.Second
        $this.Ticks = $Date.Ticks
        $this.TimeOfDay = $Date.TimeOfDay
        $this.Year = $Date.Year
    }

    # wrapper for the different datetime methods
    # had to be don this way since the datetime struct is sealed
    [DateTimeExtended] Add([timespan] $value) {
        Return [DateTimeExtended]::New($this.DateTime.Add($value))
    }

    [DateTimeExtended] AddDays([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddDays($value))
    }

    [DateTimeExtended] AddHours([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddHours($value))
    }

    [DateTimeExtended] AddMilliseconds([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddMilliseconds($value))
    }

    [DateTimeExtended] AddMinutes([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddMinutes($value))
    }

    [DateTimeExtended] AddMonths([int] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddMonths($value))
    }

    [DateTimeExtended] AddSeconds([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddSeconds($value))
    }

    [DateTimeExtended] AddTicks([long] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddTicks($value))
    }

    [DateTimeExtended] AddYears([int] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddYears($value))
    }

    [DateTimeExtended] ToLocalTime() {
        Return [DateTimeExtended]::New($this.DateTime.ToLocalTime())
    }

    [DateTimeExtended] ToUniversalTime() {
        Return [DateTimeExtended]::New($this.DateTime.ToUniversalTime())
    }
}
#EndRegion '.\Classes\DateTimeExtended.ps1' 104
#Region '.\Classes\DateTimeFormats.ps1' -1

class DateTimeFormats {
    [string]   $24HourTime
    [datetime] $DateTime
    [int32]    $Day
    [string]   $DayAbrv
    [string]   $DayName
    [int32]    $DayOfWeek
    [Int64]    $FileTime
    [string]   $FullDateShortTime
    [string]   $FullDateTime
    [string]   $GeneralDateShortTime
    [string]   $GeneralDateTime
    [Boolean]  $IsDaylightSavingTime
    [Boolean]  $IsLeapYear
    [string]   $ISO8601
    [string]   $ISO8601UTC
    [string]   $LongDate
    [string]   $LongDateNoDay
    [string]   $LongTime
    [int32]    $Month
    [string]   $MonthAbrv
    [string]   $MonthDay
    [string]   $MonthName
    [int32]    $Quater
    [string]   $RFC1123
    [string]   $RFC1123UTC
    [string]   $RoundTrip
    [string]   $ShortDate
    [string]   $ShortTime
    [string]   $SortableDateTime
    [string]   $SQL
    [string]   $UniversalFullDateTime
    [string]   $UniversalSortableDateTime
    [int32]    $UnixEpochTime
    [string]   $WimDatetime
    [int32]    $Year
    [string]   $YearMonth
    [string]   $YearQuater

    [string] getStringProperty() {
        return $this.StringProperty
    }
}
#EndRegion '.\Classes\DateTimeFormats.ps1' 44
#Region '.\Classes\TimeZoneConversion.ps1' -1

class TimeZoneConversion {
    [DateTime] $FromDateTime
    [String] $FromTimeZone
    [DateTime] $ToDateTime
    [String] $ToTimeZone
    [TimeSpan] $Offset

    TimeZoneConversion ($ToTimeZone, $Date, $FromTimeZone) {
        $DateTime = [DateTime]::SpecifyKind($Date, [DateTimeKind]::Unspecified)
        $from = [System.TimeZoneInfo]::FindSystemTimeZoneById($FromTimeZone)
        $to = [System.TimeZoneInfo]::FindSystemTimeZoneById($ToTimeZone)
        $utc = [System.TimeZoneInfo]::ConvertTimeToUtc($DateTime, $from)
        $newTime = [System.TimeZoneInfo]::ConvertTime($utc, $to)

        $this.FromDateTime = $Date
        $this.FromTimeZone = $FromTimeZone
        $this.ToDateTime = $newTime
        $this.ToTimeZone = $ToTimeZone
        $this.Offset = (New-TimeSpan -Start $date -End  $newTime)
    }
}
#EndRegion '.\Classes\TimeZoneConversion.ps1' 22
#Region '.\Public\Convert-TimeZone.ps1' -1

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
   [CmdletBinding()]
   [OutputType([TimeZoneConversion])]
   param(
      [parameter(Mandatory = $True)]
      [Validatescript( { try { $id = $_; [System.TimeZoneInfo]::FindSystemTimeZoneById($_) }
            catch { throw("'$Id' is not a valid time zone Id. Use the Find-TimeZone cmdlet to find the valid time zone Id.") } })]
      [string]$ToTimeZone,

      [Parameter(Mandatory = $false)]
      [datetime]$Date = $(Get-Date),

      [parameter(Mandatory = $false)]
      [Validatescript( { try { $id = $_; [System.TimeZoneInfo]::FindSystemTimeZoneById($_) }
            catch { throw("'$Id' is not a valid time zone Id. Use the Find-TimeZone cmdlet to find the valid time zone Id.") } })]
      [string]$FromTimeZone = [System.TimeZoneInfo]::Local.Id.ToString()
   )

   [TimeZoneConversion]::new($ToTimeZone, $Date, $FromTimeZone)
}
#EndRegion '.\Public\Convert-TimeZone.ps1' 53
#Region '.\Public\ConvertFrom-UnixTime.ps1' -1

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
#EndRegion '.\Public\ConvertFrom-UnixTime.ps1' 29
#Region '.\Public\ConvertFrom-WmiDateTime.ps1' -1

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
#EndRegion '.\Public\ConvertFrom-WmiDateTime.ps1' 28
#Region '.\Public\ConvertTo-UnixTime.ps1' -1

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
#EndRegion '.\Public\ConvertTo-UnixTime.ps1' 27
#Region '.\Public\ConvertTo-WmiDateTime.ps1' -1

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
#EndRegion '.\Public\ConvertTo-WmiDateTime.ps1' 29
#Region '.\Public\Find-TimeZone.ps1' -1

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
#EndRegion '.\Public\Find-TimeZone.ps1' 68
#Region '.\Public\Get-CronNextOccurrence.ps1' -1

Function Get-CronNextOccurrence {
    <#
.SYNOPSIS
   Get the next occurrence for a crontab

.DESCRIPTION
   This function will either return the next occurrence, or if an end date is supplied, it will return
   all the occurrences between the start and end date.

.PARAMETER Crontab
   A valid crontab string

.PARAMETER StartTime
   The datetime object to find the next occurrence from. Uses current time if not supplied.

.PARAMETER EndTime
   The datetime object to stop finding occurrences for from the StartTime

.EXAMPLE
    Get-CronNextOccurrence -Crontab '0 17 * * *'

    Will return the next occurrence of the crontab from the current time

.EXAMPLE
    $Date = Get-Date '12/14/2032'
    Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date

    Will return the next occurrence of the crontab from the time provided

.EXAMPLE
    Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date -EndTime $Date.AddDays(3)

    Will return the all occurrences of the crontab between the two times

.OUTPUTS
   A datetime object for every occurrence returned
#>
    [CmdletBinding()]
    [OutputType('datetime')]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Crontab,
        [Parameter(Mandatory = $false)]
        [datetime]$StartTime = (Get-Date),
        [Parameter(Mandatory = $false)]
        [datetime]$EndTime
    )
    # validat crontab
    $Schedule = Test-CrontabSchedule -Crontab $Crontab

    # if no end date, just get next occurrence, else find all occurrences between start and end
    if ($Schedule.valid -eq $true -and $null -eq $EndTime) {
        $schedule.schedule.GetNextOccurrence($StartTime)
    }
    elseif ($Schedule.valid -eq $true) {
        $schedule.schedule.GetNextOccurrences($StartTime, $EndTime)
    }
    else {
        throw $Schedule.ErrorMsg
    }


}
#EndRegion '.\Public\Get-CronNextOccurrence.ps1' 64
#Region '.\Public\Get-DateExtended.ps1' -1

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

   process{
      [DateTimeExtended]::New((Get-Date @PSBoundParameters))
   }

}
#EndRegion '.\Public\Get-DateExtended.ps1' 81
#Region '.\Public\Get-DateFormat.ps1' -1

Function Get-DateFormat {
   [alias("Get-DateFormats")]
   <#
.SYNOPSIS
   Returns common date and time formats
.DESCRIPTION
   This function format date and time values into multiple different common formats. All dates are based on the date passed.
   If no date is passed in the current date and time are used.

.PARAMETER Date
   The datetime value to return the formats for

.EXAMPLE
   Get-DateFormats

   Gets formatted date and time information based on the current time
.EXAMPLE
   Get-DateFormats -Date "11/17/2017"

   Gets formatted date and time information for a specific date

.OUTPUTS
   A PSObject containing the diffent values for the datetime formats.
#>
   [CmdletBinding()]
   [OutputType([DateTimeFormats])]
   param(
      [Parameter(Mandatory = $false)]
      [datetime]$Date = $(Get-Date)
   )

   $offset = ([System.TimeZoneInfo]::Local).BaseUtcOffset.ToString()
   $offset = $offset.Substring(0, $offset.LastIndexOf(':'))

   [DateTimeFormats]@{
      DateTime                  = $Date.DateTime
      RFC1123UTC                = $Date.ToUniversalTime().ToString('r')
      SQL                       = $Date.ToString("yyyy-MM-dd HH:mm:ss.fff")
      ISO8601UTC                = $Date.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
      ISO8601                   = $Date.ToString("yyyy-MM-ddTHH:mm:ss.fff") + $offset
      ShortDate                 = $Date.ToString('d')
      LongDate                  = $Date.ToString('D')
      LongDateNoDay             = $Date.ToString('D').Substring($Date.ToString('D').IndexOf(',')+2)
      FullDateShortTime         = $Date.ToString('f')
      FullDateTime              = $Date.ToString('F')
      GeneralDateShortTime      = $Date.ToString('g')
      GeneralDateTime           = $Date.ToString('G')
      MonthDay                  = $Date.ToString('M')
      RoundTrip                 = $Date.ToString('o')
      RFC1123                   = $Date.ToString('r')
      SortableDateTime          = $Date.ToString('s')
      ShortTime                 = $Date.ToString('t')
      LongTime                  = $Date.ToString('T')
      UniversalSortableDateTime = $Date.ToString('u')
      UniversalFullDateTime     = $Date.ToString('U')
      YearMonth                 = $Date.ToString('Y')
      "24HourTime"              = $Date.ToString("HH:mm")
      Day                       = $Date.Day
      DayAbrv                   = (Get-Culture).DateTimeFormat.GetAbbreviatedDayName($Date.DayOfWeek.value__)
      DayName                   = $Date.DayOfWeek.ToString()
      DayOfWeek                 = $Date.DayOfWeek.value__
      Month                     = $Date.Month
      MonthName                 = (Get-Culture).DateTimeFormat.GetMonthName($Date.Month)
      MonthAbrv                 = (Get-Culture).DateTimeFormat.GetAbbreviatedMonthName($Date.Month)
      Quater                    = [Math]::ceiling($Date.Month / 3)
      YearQuater                = "$($Date.Year)$("{0:00}" -f [Math]::ceiling($Date.Month/3) )"
      Year                      = $Date.Year
      WimDatetime               = (ConvertTo-WmiDateTime $Date)
      UnixEpochTime             = (ConvertTo-UnixTime $Date)
      IsDaylightSavingTime      = $Date.IsDaylightSavingTime()
      IsLeapYear                = [datetime]::IsLeapYear($Date.Year)
      FileTime                  = $Date.ToFileTime()
   }
}
#EndRegion '.\Public\Get-DateFormat.ps1' 75
#Region '.\Public\Get-Easter.ps1' -1

Function Get-Easter {
    <#
    .SYNOPSIS
    This function offers a generic Easter computing method for any given year, using Western, Orthodox or Julian algorithms.

    .DESCRIPTION
    Shamelessly stolen from python dateutil (https://github.com/dateutil/dateutil/blob/master/src/dateutil/easter.py)

    .PARAMETER Year
    The year to get Easter from

    .PARAMETER Calendar
    Gregorian : is the default and valid from 1583 to 4099
    Orthodox :  valid from 1583 to 4099
    Julian : valid from 326

    .EXAMPLE
    Get-Easter -Year 2024

    #>
    [CmdletBinding()]
    [OutputType([datetime])]
    param(
        [Parameter(Mandatory = $false)]
        [int]$year = (Get-Date).Year,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Gregorian', 'Julian', 'Orthodox')]
        [string]$Calendar = 'Gregorian'
    )

    # Golden year - 1
    $g = $year % 19
    $e = 0
    if ($Calendar -ne 'Gregorian') {
        # Old method
        $i = (19 * $g + 15) % 30
        $j = ($year + [math]::floor($year / 4) + $i) % 7
        if ($Calendar -eq 'Orthodox') {
            # Extra dates to convert Julian to Gregorian date
            $e = 10
            if ($year -gt 1600) {
                $e = $e + [math]::floor([math]::floor($year / 100) - 16 - ([math]::floor($year / 100) - 16) / 4)
            }
        }
    }
    else {
        # Century
        $c = [math]::floor($year / 100)
        # (23 - Epact) mod 30
        $h = ($c - [math]::floor($c / 4) - [math]::floor((8 * $c + 13) / 25) + 19 * $g + 15) % 30
        # Number of days from March 21 to Paschal Full Moon
        $i = $h - ([math]::floor($h / 28)) * (1 - ([math]::floor($h / 28)) * ([math]::floor(29 / ($h + 1))) * ([math]::floor((21 - $g) / 11)))
        # Weekday for PFM (0=Sunday, etc)
        $j = ($year + [math]::floor($year / 4) + $i + 2 - $c + [math]::floor($c / 4)) % 7
    }



    # Number of days from March 21 to Sunday on or before PFM
    $p = $i - $j + $e
    $d = 1 + ($p + 27 + [math]::floor(($p + 6) / 40)) % 31
    $m = 3 + [math]::floor(($p + 26) / 30)

    [datetime]::new($year, $m, $d)
}
#EndRegion '.\Public\Get-Easter.ps1' 67
#Region '.\Public\Get-HappyHour.ps1' -1

Function Get-HappyHour {
    [CmdletBinding()]
    [OutputType([string])]
    $now = Get-Date '16:30'

    $untilHH = New-TimeSpan -Start $now -End (Get-Date '17:00')

    if($untilHH.Hours -ne 0){

    }

    if ($hoursUntilHH -lt 0) {
        Write-Output "Happy hour started $($hoursUntilHH * -1) hours ago!"
    }
    elseif ($hoursUntilHH -eq 0) {
        Write-Output "Happy hour started $($now.Minute) minutes ago!"
    }
    else {
        if ($hoursUntilHH -eq 1) {
            Write-Output "Happy hour starts in $(60 - $now.Minute) minutes!"
        }
        else {
            Write-Output "Happy hour starts in $($hoursUntilHH) hours!"
        }

        Write-Output "It is currently happy hour in..."
        $local = [System.TimeZoneInfo]::Local
        $offsetHoursUntilHH = $local.BaseUtcOffset.Hours + $hoursUntilHH
        $TimeZones = [System.TimeZoneInfo]::GetSystemTimeZones()
        $TimeZones | Where-Object { $_.BaseUtcOffset.Hours -eq $offsetHoursUntilHH } | Foreach-Object {
            "  - $($_.DisplayName.Substring($_.DisplayName.IndexOf(' ')).Trim())"
        }
    }
}
#EndRegion '.\Public\Get-HappyHour.ps1' 35
#Region '.\Public\Get-PatchTuesday.ps1' -1

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
#EndRegion '.\Public\Get-PatchTuesday.ps1' 61
#Region '.\Public\New-Duration.ps1' -1

Function New-Duration {
    <#
    .SYNOPSIS
    Calculates the time span between two dates and returns the duration in the ISO 8601 format

    .DESCRIPTION
    Calculates the timespan between two dates and returns the duration in the ISO 8601 format

    https://en.wikipedia.org/wiki/ISO_8601#Durations

    .PARAMETER Start
    Specifies the start of a time span.

    .PARAMETER End
    Specifies the end of a time span. End date must be greater than the start date

    .EXAMPLE
    New-Duration -Start '2/3/2023' -End (Get-Date)

    .EXAMPLE
    New-Duration -Days 1 -Hours 4

    .EXAMPLE
    New-Duration -Weeks 3
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true,
            ParameterSetName = "datetime")]
        [datetime]$Start,

        [Parameter(Mandatory = $true,
            ParameterSetName = "datetime")]
        [datetime]$End,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Years = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Months = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Days = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Hours = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Minutes = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "numbers")]
        [int]$Seconds = 0,

        [Parameter(Mandatory = $false,
            ParameterSetName = "week")]
        [int]$Weeks = 0
    )

    if ($Start -gt $End) {
        throw "Start date must be before the end date"
    }
    if ($PSCmdlet.ParameterSetName -eq 'datetime') {
        # If start date is later in the month offset by 1
        $daysOffset = if ($start.Day -gt $End.Day) { 1 }else { 0 }
        # Get the total months between dates
        $TotalMonths = ($End.Month - $start.Month - $daysOffset) + ($End.Year - $start.Year) * 12
        # Get the number of years
        $Years = [math]::floor($TotalMonths / 12)
        # Get the number of months less the years
        $Months = $TotalMonths % 12
        # Calculate the remaining timespan
        $TimeSpan = New-TimeSpan -Start $start.AddYears($Years).AddMonths($Months) -End $End

        # Set variables to build the string
        $Days = $TimeSpan.Days
        $Hours = $TimeSpan.Hours
        $Minutes = $TimeSpan.Minutes
        $Seconds = $TimeSpan.Seconds
    }

    $Duration = 'P'
    if ($Years -ne 0) { $Duration += "$($Years)Y" }
    if ($Weeks -ne 0) { $Duration += "$($Weeks)W" }
    if ($Months -ne 0) { $Duration += "$($Months)M" }
    if ($Days -ne 0) { $Duration += "$($Days)D" }
    if (($Hours + $Minutes + $Seconds) -ne 0) {
        $Duration += "T"
        if ($Hours -ne 0) { $Duration += "$($Hours)H" }
        if ($Minutes -ne 0) { $Duration += "$($Minutes)M" }
        if ($Seconds -ne 0) { $Duration += "$($Seconds)S" }
    }

    if($Duration -eq 'P'){
        $Duration = 'PT0S'
    }

    $Duration
}
#EndRegion '.\Public\New-Duration.ps1' 106
#Region '.\Public\Test-CrontabSchedule.ps1' -1

Function Test-CrontabSchedule {
    <#
.SYNOPSIS
   Tests that a crontab string is valid

.DESCRIPTION
   This function attempts to parse a crontab string to ensure it is valid.

.PARAMETER Crontab
   The datetime value to return the second Tuesday for the month

.EXAMPLE
   Test-CrontabSchedule -crontab '0 17 * * *'

    Valid schedule that returns:
    Crontab     Valid
    -------     -----
    0 17 * * *   True

.EXAMPLE
    Test-CrontabSchedule -crontab '0 17 * 13 *'

    Invalid schedule that returns:
    Crontab     Valid ErrorMsg
    -------     ----- --------
    0 17 * 13 * False 13 is higher than the maximum allowable value for the [Month] field. Value must be between 1 and 12 (all inclusive).

.OUTPUTS
   A psobject that contains the crontable, a validation value, and any error messages returned
#>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Crontab
    )

    $Result = [ordered]@{
        Schedule = $Crontab
        Valid    = $false
    }

    try {
        $Result['Schedule'] = [NCrontab.CrontabSchedule]::Parse($Crontab)
        $Result['Valid'] = $true
    }
    catch {
        $ErrorMsg = $_.Exception.ErrorRecord.ToString()
        $ErrorMsg = $ErrorMsg.Substring($ErrorMsg.IndexOf(': "') + 3)
        $ErrorMsg = $ErrorMsg.Substring(0, $ErrorMsg.Length - 1)
        $Result.Add('ErrorMsg', $ErrorMsg)
    }

    [PSCustomObject]$Result

}
#EndRegion '.\Public\Test-CrontabSchedule.ps1' 57
