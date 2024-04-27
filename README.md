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
| [New-Duration](docs/New-Duration.md) | Short description |
| [Test-CrontabSchedule](docs/Test-CrontabSchedule.md) | Tests that a crontab string is valid |

