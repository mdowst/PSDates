# PSDates

PSDates provides you all the tools you need when working with dates and times in PowerShell. It contains function to help you find specific date formats, get certain dates based on other dates (first/last day of the month or year, patch Tuesday, etc). I also has functions for working with timezones, unix time, WMI time, crontabs. 

# Installation

```powershell
Install-Module PSDates
```

# Examples

* [Get-DateExtended](docs\Convert-TimeZone.md)
* [Get-DateFormats](#Get-DateFormats)
* [Get-PatchTuesday](#Get-PatchTuesday)
* [Test-CrontabSchedule](#Test-CrontabSchedule)
* [Get-CronNextOccurrence](#Get-CronNextOccurrence)
* [Find-TimeZone](#Find-TimeZone)
* [Convert-TimeZone](docs\Convert-TimeZone.md)
* [ConvertFrom-UnixTime](#ConvertFrom-UnixTime)
* [ConvertTo-UnixTime](#ConvertTo-UnixTime)
* [ConvertFrom-WmiDateTime](#ConvertFrom-WmiDateTime)
* [ConvertTo-WmiDateTime](#ConvertTo-WmiDateTime)

## Get-DateExtended 
Gets common extended date values that are not included by default with the Get-Date cmdlet. It expects all the same parameters as the standard Get-Date cmdlet.

### Example 1: Gets extended date and time information based on the current time
```powershell
PS:> Get-DateExtended

Date                      WeekOfYear DayOfWeek       StartOfWeek     EndOfWeek       StartOfMonth    EndOfMonth
----                      ---------- ---------       -----------     ---------       ------------    ----------
7/15/2020 7:30:36 AM      29         Wednesday       7/12/2020       7/18/2020       7/1/2020        7/31/2020
```

### Example 2: Gets extended date and time information for a specific date
```powershell
PS:> Get-DateExtended -Date "11/17/2017"

DateTime       : 11/17/2017 12:00:00 AM
FirstDayOfYear : 1/1/2017 12:00:00 AM
LastDayOfYear  : 12/31/2017 12:00:00 AM
StartOfWeek    : 11/12/2017 12:00:00 AM
EndOfWeek      : 11/18/2017 11:59:59 PM
StartOfMonth   : 11/1/2017 12:00:00 AM
EndOfMonth     : 11/30/2017 11:59:59 PM
WeekOfYear     : 46
TimeZone       : (UTC-06:00) Central Time (US & Canada)
Quater         : 4
Date           : 11/17/2017 12:00:00 AM
Day            : 17
DayOfWeek      : Friday
DayOfYear      : 321
Hour           : 0
Kind           : Unspecified
Millisecond    : 0
Minute         : 0
Month          : 11
Second         : 0
Ticks          : 636464736000000000
TimeOfDay      : 00:00:00
Year           : 2017
```
[top](#examples)
## Get-DateFormats 
Get-DateFormats returns the date and time values into multiple different common formats. All dates are based on the date passed. If no date is passed in the current date and time are used.

### Example 1: Gets formatted date and time information based on the current time
```powershell
PS:> Get-DateFormats

24HourTime                : 07:36
DateTime                  : 7/15/2020 7:36:41 AM
Day                       : 15
DayAbrv                   : Wed
DayName                   : Wednesday
DayOfWeek                 : 3
FileTime                  : 132392902016053261
FullDateShortTime         : Wednesday, July 15, 2020 7:36 AM
FullDateTime              : Wednesday, July 15, 2020 7:36:41 AM
GeneralDateShortTime      : 7/15/2020 7:36 AM
GeneralDateTime           : 7/15/2020 7:36:41 AM
IsDaylightSavingTime      : True
IsLeapYear                : True
ISO8601                   : 2020-07-15T07:36:41.605-06:00
ISO8601UTC                : 2020-07-15T12:36:41.605Z
LongDate                  : Wednesday, July 15, 2020
LongTime                  : 7:36:41 AM
Month                     : 7
MonthAbrv                 : Jul
MonthDay                  : July 15
MonthName                 : July
Quater                    : 3
RFC1123                   : Wed, 15 Jul 2020 07:36:41 GMT
RFC1123UTC                : Wed, 15 Jul 2020 12:36:41 GMT
RoundTrip                 : 2020-07-15T07:36:41.6053261-05:00
ShortDate                 : 7/15/2020
ShortTime                 : 7:36 AM
SortableDateTime          : 2020-07-15T07:36:41
SQL                       : 2020-07-15 07:36:41.605
UniversalFullDateTime     : Wednesday, July 15, 2020 12:36:41 PM
UniversalSortableDateTime : 2020-07-15 07:36:41Z
UnixEpochTime             : 1594816602
WimDatetime               : 20200715073641.605326-300
Year                      : 2020
YearMonth                 : July 2020
YearQuater                : 202003
```
[top](#examples)
## Get-PatchTuesday
Get-PatchTuesday allows you to pass a date, or a month/year combination to find the second Tuesday (aka Patch Tuesday) of any month.

### Example 1: Returns the second Tuesday for the current month
```powershell
PS:> Get-PatchTuesday

Tuesday, July 14, 2020 12:00:00 AM
```

### Example 2: Returns the second Tuesday for November 2021
```powershell
PS:> Get-PatchTuesday -Date "11/17/2021" 

Tuesday, November 9, 2021 12:00:00 AM
```

### Example 3: Returns the second Tuesday for June 2020
```powershell
PS:> Get-PatchTuesday -Month 6 -Year 2020 

Tuesday, June 9, 2020 12:00:00 AM
```

### Example 4: Returns the second Tuesday for April of the current year
```powershell
PS:> Get-PatchTuesday -Month 4 

Tuesday, April 14, 2020 12:00:00 AM
```
[top](#examples)
## Test-CrontabSchedule
This function attempts to parse a crontab string to ensure it is valid.

### Example 1 : Valid schedule that returns:
```powershell
PS:> Test-CrontabSchedule -crontab '0 17 * * *'

Schedule   Valid
--------   -----
0 17 * * *  True
```

### Example 2 : Invalid schedule that returns:
```powershell
PS:> Test-CrontabSchedule -crontab '0 17 * 13 *'

Schedule    Valid ErrorMsg                                                                                                            
--------    ----- --------                                                                                                            
0 17 * 13 * False 13 is higher than the maximum allowable value for the [Month] field. Value must be between 1 and 12 (all inclusive).
```
[top](#examples)
## Get-CronNextOccurrence
This function will either return the next occurrence, or if an end date is supplied, it will return 
all the occurrences between the start and end date.

### Example 1 : Will return the next occurrence of the crontab from the current time
```powershell
PS:> Get-CronNextOccurrence -Crontab '0 17 * * *'

Wednesday, July 15, 2020 5:00:00 PM
```

### Example 2 : Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date
```powershell
PS:> $Date = Get-Date '12/14/2032'
PS:> Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date

Tuesday, December 14, 2032 5:00:00 PM
```

### Example 3 : Will return the all occurrences of the crontab between the two times
```powershell
PS:> $Date = Get-Date '12/14/2020'
PS:> Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date -EndTime $Date.AddDays(3)

Monday, December 14, 2020 5:00:00 PM
Tuesday, December 15, 2020 5:00:00 PM
Wednesday, December 16, 2020 5:00:00 PM
```
[top](#examples)
## Find-TimeZone
This function will return the information for the system time zones. You can search by name and/or hour offsets. 
You can also return the local time zone.

### Example 1 : Return the time zone of the local system
```powershell
PS:> Find-TimeZone -local

Id                         : Central Standard Time
DisplayName                : (UTC-06:00) Central Time (US & Canada)
StandardName               : Central Standard Time
DaylightName               : Central Daylight Time
BaseUtcOffset              : -06:00:00
SupportsDaylightSavingTime : True
```

### Example 2 : Search for time zones with 'GMT' in the name
```powershell
PS:> Find-TimeZone -Name "GMT"

Id                         : GMT Standard Time
DisplayName                : (UTC+00:00) Dublin, Edinburgh, Lisbon, London
StandardName               : GMT Standard Time
DaylightName               : GMT Daylight Time
BaseUtcOffset              : 00:00:00
SupportsDaylightSavingTime : True
```

### Example 3 : Search for time zones with 'Central' in the name and have a UTC offset of -6 hours
```powershell
PS:> Find-TimeZone -Name "central" -Offset -6

Id                         : Central America Standard Time
DisplayName                : (UTC-06:00) Central America
StandardName               : Central America Standard Time
DaylightName               : Central America Daylight Time
BaseUtcOffset              : -06:00:00
SupportsDaylightSavingTime : False

Id                         : Central Standard Time
DisplayName                : (UTC-06:00) Central Time (US & Canada)
StandardName               : Central Standard Time
DaylightName               : Central Daylight Time
BaseUtcOffset              : -06:00:00
SupportsDaylightSavingTime : True

Id                         : Central Standard Time (Mexico)
DisplayName                : (UTC-06:00) Guadalajara, Mexico City, Monterrey
StandardName               : Central Standard Time (Mexico)
DaylightName               : Central Daylight Time (Mexico)
BaseUtcOffset              : -06:00:00
SupportsDaylightSavingTime : True

Id                         : Canada Central Standard Time
DisplayName                : (UTC-06:00) Saskatchewan
StandardName               : Canada Central Standard Time
DaylightName               : Canada Central Daylight Time
BaseUtcOffset              : -06:00:00
SupportsDaylightSavingTime : False
```
[top](#examples)
## Convert-TimeZone
This function will allows you to pass a date to convert from one time zone to another. 
If no date is specified the local time is used. If no FromTimeZone is passed then the 
local time zone is used.

If you don't know the time zone ID you can use the [Find-TimeZone](Find-TimeZone) cmdlet.

### Example 1 : FromDateTime : 11/11/2017 3:54:12 PM
```powershell
PS:> Convert-TimeZone -ToTimeZone "GMT Standard Time"

FromDateTime : 7/15/2020 7:57:15 AM
FromTimeZone : Central Standard Time
ToDateTime   : 7/15/2020 1:57:15 PM
ToTimeZone   : GMT Standard Time
Offset       : 06:00:00
```

### Example 2 : FromDateTime : 11/17/2017 12:34:00 AM
```powershell
PS:> Convert-TimeZone -date '11/17/2017 12:34 AM' -FromTimeZone "China Standard Time" -ToTimeZone "US Mountain Standard Time"

FromDateTime : 11/17/2017 12:34:00 AM
FromTimeZone : China Standard Time
ToDateTime   : 11/16/2017 9:34:00 AM
ToTimeZone   : US Mountain Standard Time
Offset       : -15:00:00
```
[top](#examples)
## ConvertFrom-UnixTime
This function will return the datetime based on the unix epoch time.

### Example 1 : Gets datetime for the Unix time 1509512400
```powershell
PS:> ConvertFrom-UnixTime -UnixTime 1509512400

Wednesday, November 1, 2017 12:00:00 AM
```
[top](#examples)
## ConvertTo-UnixTime
This function will return the unix time based on the unix epoch time. If no date is passed in the current date and time is used.

### Example 1 : Gets unix time for the current time
```powershell
PS:> ConvertTo-UnixTime

1594817994
```

### Example 2 : Gets unix time for a specific date
```powershell
PS:> ConvertTo-UnixTime -date "11/17/2017"

1510898400
```
[top](#examples)
## ConvertFrom-WmiDateTime
This function will return the datetime based on a WMI datetime string.

### Example 1 : Gets datetime for the Wmi time 20190912173652.000000-300
```powershell
PS:> ConvertFrom-WmiDateTime -WmiTime '20190912173652.000000-300'

Thursday, September 12, 2019 5:36:52 PM
```
[top](#examples)
## ConvertTo-WmiDateTime
This function will return the WMI datetime string based on a datetime passed.

### Example 1 : Return the WMI datetime string for the datetime of "06/25/2019 16:17"
```powershell
PS:> ConvertTo-WmiDateTime -Date '06/25/2019 16:17'

20190625161700.000000-300
```