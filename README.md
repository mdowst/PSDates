# PSDates

PSDates provides you all the tools you need when working with dates and times in PowerShell. It contains function to help you find specific date formats, get certain dates based on other dates (first/last day of the month or year, patch Tuesday, etc). I also has functions for working with timezones, unix time, WMI time, crontabs. 

# Installation

```powershell
Install-Module PSDates
```

# Commands

| Cmdlet | Synopsis |
| ------ | -------- |
| [Convert-TimeZone](docs/Convert-TimeZone.md) | Convert a datetime value from one time zone to another |
| [Convert-ToDateTime](docs/Convert-ToDateTime.md) | Converts various input objects to a DateTime object. |
| [ConvertFrom-UnixTime](docs/ConvertFrom-UnixTime.md) | Converts a Unix Time value to a datetime value |
| [ConvertFrom-WmiDateTime](docs/ConvertFrom-WmiDateTime.md) | Converts a Wmi Time value to a datetime value |
| [ConvertTo-UnixTime](docs/ConvertTo-UnixTime.md) | Converts a datetime value to Unix Time |
| [ConvertTo-WmiDateTime](docs/ConvertTo-WmiDateTime.md) | Converts a datetime value to a Wmi datetime string |
| [Find-TimeZone](docs/Find-TimeZone.md) | Returns Time Zone information |
| [Get-CronDescription](docs/Get-CronDescription.md) | Convert a cron expression into a human readable description |
| [Get-CronNextOccurrence](docs/Get-CronNextOccurrence.md) | Get the next occurrence for a crontab |
| [Get-DateExtended](docs/Get-DateExtended.md) | Gets additional extended date values that are not included by default with the Get-Date cmdlet |
| [Get-DateFormat](docs/Get-DateFormat.md) | Returns common date and time formats |
| [Get-Easter](docs/Get-Easter.md) | This function offers a generic Easter computing method for any given year, using Western, Orthodox or Julian algorithms. |
| [Get-PatchTuesday](docs/Get-PatchTuesday.md) | Returns the second Tuesday of the month |
| [Get-SunTime](docs/Get-SunTime.md) | Find sunrise and sunset times for any location on planet Earth. |
| [Group-TimeSpan](docs/Group-TimeSpan.md) | Groups objects by a specified time span. |
| [Measure-TimeSpan](docs/Measure-TimeSpan.md) | Measures statistical properties (such as sum, average, and maximum) of a specified property within grouped time spans. |
| [New-Duration](docs/New-Duration.md) | Calculates the time span between two dates and returns the duration in the ISO 8601 format |
| [Test-CrontabSchedule](docs/Test-CrontabSchedule.md) | Tests that a crontab string is valid |

