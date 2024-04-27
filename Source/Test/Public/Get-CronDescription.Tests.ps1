BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-CronDescription Tests' {
    It 'Get-CronDescription TestEveryMinute' {
        Get-CronDescription -Crontab "* * * * *" | Should -Be "Every minute"
    }

    It 'Get-CronDescription TestEvery1Minute' {
        Get-CronDescription -Crontab "*/1 * * * *" | Should -Be "Every minute"
        Get-CronDescription -Crontab "0 0/1 * * * ?" | Should -Be "Every minute"
    }

    It 'Get-CronDescription TestEveryHour' {
        Get-CronDescription -Crontab "0 0 * * * ?" | Should -Be "Every hour"
        Get-CronDescription -Crontab "0 0 0/1 * * ?" | Should -Be "Every hour"
    }

    It 'Get-CronDescription TestTimeOfDayCertainDaysOfWeek' {
        Get-CronDescription -Crontab "0 23 ? * MON-FRI" | Should -Be "At 11:00 PM, Monday through Friday"
    }

    It 'Get-CronDescription TestEverySecond' {
        Get-CronDescription -Crontab "* * * * * *" | Should -Be "Every second"
    }

    It 'Get-CronDescription TestEvery45Seconds' {
        Get-CronDescription -Crontab "*/45 * * * * *" | Should -Be "Every 45 seconds"
    }

    It 'Get-CronDescription TestEvery5Minutes' {
        Get-CronDescription -Crontab "*/5 * * * *" | Should -Be "Every 5 minutes"
        Get-CronDescription -Crontab "0 0/10 * * * ?" | Should -Be "Every 10 minutes"
    }

    It 'Get-CronDescription TestEvery5MinutesOnTheSecond' {
        Get-CronDescription -Crontab "0 */5 * * * *" | Should -Be "Every 5 minutes"
    }

    It 'Get-CronDescription TestWeekdaysAtTime' {
        Get-CronDescription -Crontab "30 11 * * 1-5" | Should -Be "At 11:30 AM, Monday through Friday"
    }

    It 'Get-CronDescription TestDailyAtTime' {
        Get-CronDescription -Crontab "30 11 * * *" | Should -Be "At 11:30 AM"
    }

    It 'Get-CronDescription TestMinuteSpan' {
        Get-CronDescription -Crontab "0-10 11 * * *" | Should -Be "Every minute between 11:00 AM and 11:10 AM"
    }

    It 'Get-CronDescription TestOneMonthOnly' {
        Get-CronDescription -Crontab "* * * 3 *" | Should -Be "Every minute, only in March"
    }

    It 'Get-CronDescription TestTwoMonthsOnly' {
        Get-CronDescription -Crontab "* * * 3,6 *" | Should -Be "Every minute, only in March and June"
    }

    It 'Get-CronDescription TestTwoTimesEachAfternoon' {
        Get-CronDescription -Crontab "30 14,16 * * *" | Should -Be "At 02:30 PM and 04:30 PM"
    }

    It 'Get-CronDescription TestThreeTimesDaily' {
        Get-CronDescription -Crontab "30 6,14,16 * * *" | Should -Be "At 06:30 AM, 02:30 PM and 04:30 PM"
    }

    It 'Get-CronDescription TestOnceAWeek' {
        Get-CronDescription -Crontab "46 9 * * 1" | Should -Be "At 09:46 AM, only on Monday"
    }

    It 'Get-CronDescription TestDayOfMonth' {
        Get-CronDescription -Crontab "23 12 15 * *" | Should -Be "At 12:23 PM, on day 15 of the month"
    }

    It 'Get-CronDescription TestMonthName' {
        Get-CronDescription -Crontab "23 12 * JAN *" | Should -Be "At 12:23 PM, only in January"
    }

    It 'Get-CronDescription TestLowerCaseMonthName' {
        Get-CronDescription -Crontab "23 12 * jan *" | Should -Be "At 12:23 PM, only in January"
    }

    It 'Get-CronDescription TestDayOfMonthWithQuestionMark' {
        Get-CronDescription -Crontab "23 12 ? JAN *" | Should -Be "At 12:23 PM, only in January"
    }

    It 'Get-CronDescription TestMonthNameRange2' {
        Get-CronDescription -Crontab "23 12 * JAN-FEB *" | Should -Be "At 12:23 PM, January through February"
    }

    It 'Get-CronDescription TestMonthNameRange3' {
        Get-CronDescription -Crontab "23 12 * JAN-MAR *" | Should -Be "At 12:23 PM, January through March"
    }

    It 'Get-CronDescription TestDayOfWeekName' {
        Get-CronDescription -Crontab "23 12 * * SUN" | Should -Be "At 12:23 PM, only on Sunday"
    }

    It 'Get-CronDescription TestDayOfWeekRange' {
        Get-CronDescription -Crontab "*/5 15 * * MON-FRI" | Should -Be "Every 5 minutes, between 03:00 PM and 03:59 PM, Monday through Friday"
    }

    It 'Get-CronDescription TestDayOfWeekRangeWithDOWLowerCased' {
        Get-CronDescription -Crontab "*/5 15 * * MoN-fri" | Should -Be "Every 5 minutes, between 03:00 PM and 03:59 PM, Monday through Friday"
    }

    It 'Get-CronDescription TestDayOfWeekOnceInMonth' {
        Get-CronDescription -Crontab "* * * * MON#3" | Should -Be "Every minute, on the third Monday of the month"
    }

    It 'Get-CronDescription TestLastDayOfTheWeekOfTheMonth' {
        Get-CronDescription -Crontab "* * * * 4L" | Should -Be "Every minute, on the last Thursday of the month"
    }

    It 'Get-CronDescription TestLastDayOfTheMonth' {
        Get-CronDescription -Crontab "*/5 * L JAN *" | Should -Be "Every 5 minutes, on the last day of the month, only in January"
    }

    It 'Get-CronDescription TestLastDayOffset' {
        Get-CronDescription -Crontab "0 0 0 L-5 * ?" | Should -Be "At 12:00 AM, 5 days before the last day of the month"
    }

    It 'Get-CronDescription TestLastWeekdayOfTheMonth' {
        Get-CronDescription -Crontab "* * LW * *" | Should -Be "Every minute, on the last weekday of the month"
    }

    It 'Get-CronDescription TestLastWeekdayOfTheMonth2' {
        Get-CronDescription -Crontab "* * WL * *" | Should -Be "Every minute, on the last weekday of the month"
    }

    It 'Get-CronDescription TestFirstWeekdayOfTheMonth' {
        Get-CronDescription -Crontab "* * 1W * *" | Should -Be "Every minute, on the first weekday of the month"
    }

    It 'Get-CronDescription TestThirteenthWeekdayOfTheMonth' {
        Get-CronDescription -Crontab "* * 13W * *" | Should -Be "Every minute, on the weekday nearest day 13 of the month"
    }

    It 'Get-CronDescription TestFirstWeekdayOfTheMonth2' {
        Get-CronDescription -Crontab "* * W1 * *" | Should -Be "Every minute, on the first weekday of the month"
    }

    It 'Get-CronDescription TestParticularWeekdayOfTheMonth' {
        Get-CronDescription -Crontab "* * 5W * *" | Should -Be "Every minute, on the weekday nearest day 5 of the month"
    }

    It 'Get-CronDescription TestParticularWeekdayOfTheMonth2' {
        Get-CronDescription -Crontab "* * W5 * *" | Should -Be "Every minute, on the weekday nearest day 5 of the month"
    }

    It 'Get-CronDescription TestTimeOfDayWithSeconds' {
        Get-CronDescription -Crontab "30 02 14 * * *" | Should -Be "At 02:02:30 PM"
    }

    It 'Get-CronDescription TestSecondInternvals' {
        Get-CronDescription -Crontab "5-10 * * * * *" | Should -Be "Seconds 5 through 10 past the minute"
    }

    It 'Get-CronDescription TestMultiPartSecond' {
        Get-CronDescription -Crontab "15,45 * * * * *" | Should -Be "At 15 and 45 seconds past the minute"
    }

    It 'Get-CronDescription TestSecondMinutesHoursIntervals' {
        Get-CronDescription -Crontab "5-10 30-35 10-12 * * *" | Should -Be "Seconds 5 through 10 past the minute, minutes 30 through 35 past the hour, between 10:00 AM and 12:59 PM"
    }

    It 'Get-CronDescription TestEvery5MinutesAt30Seconds' {
        Get-CronDescription -Crontab "30 */5 * * * *" | Should -Be "At 30 seconds past the minute, every 5 minutes"
    }

    It 'Get-CronDescription TestMinutesPastTheHourRange' {
        Get-CronDescription -Crontab "0 30 10-13 ? * WED,FRI" | Should -Be "At 30 minutes past the hour, between 10:00 AM and 01:59 PM, only on Wednesday and Friday"
    }

    It 'Get-CronDescription TestSecondsPastTheMinuteInterval' {
        Get-CronDescription -Crontab "10 0/5 * * * ?" | Should -Be "At 10 seconds past the minute, every 5 minutes"
    }

    It 'Get-CronDescription TestBetweenWithInterval' {
        Get-CronDescription -Crontab "2-59/3 1,9,22 11-26 1-6 ?" | Should -Be "Every 3 minutes, minutes 2 through 59 past the hour, at 01:00 AM, 09:00 AM, and 10:00 PM, between day 11 and 26 of the month, January through June"
    }

    It 'Get-CronDescription TestRecurringFirstOfMonth' {
        Get-CronDescription -Crontab "0 0 6 1/1 * ?" | Should -Be "At 06:00 AM"
    }

    It 'Get-CronDescription TestMinutesPastTheHour' {
        Get-CronDescription -Crontab "0 5 0/1 * * ?" | Should -Be "At 5 minutes past the hour"
    }

    It 'Get-CronDescription TestOneYearOnlyWithSeconds' {
        Get-CronDescription -Crontab "* * * * * * 2013" | Should -Be "Every second, only in 2013"
    }

    It 'Get-CronDescription TestOneYearOnlyWithoutSeconds' {
        Get-CronDescription -Crontab "* * * * * 2013" | Should -Be "Every minute, only in 2013"
    }

    It 'Get-CronDescription TestTwoYearsOnly' {
        Get-CronDescription -Crontab "* * * * * 2013,2014" | Should -Be "Every minute, only in 2013 and 2014"
    }

    It 'Get-CronDescription TestYearRange2' {
        Get-CronDescription -Crontab "23 12 * JAN-FEB * 2013-2014" | Should -Be "At 12:23 PM, January through February, 2013 through 2014"
    }

    It 'Get-CronDescription TestYearRange3' {
        Get-CronDescription -Crontab "23 12 * JAN-MAR * 2013-2015" | Should -Be "At 12:23 PM, January through March, 2013 through 2015"
    }

    It 'Get-CronDescription TestHourRange' {
        Get-CronDescription -Crontab "0 0/30 8-9 5,20 * ?" | Should -Be "Every 30 minutes, between 08:00 AM and 09:59 AM, on day 5 and 20 of the month"
    }

    It 'Get-CronDescription TestDayOfWeekModifier' {
        Get-CronDescription -Crontab "23 12 * * SUN#2" | Should -Be "At 12:23 PM, on the second Sunday of the month"
    }

    It 'Get-CronDescription TestDayOfWeekModifierWithSundayStartOne' {
        Get-CronDescription -Crontab "23 12 * * 1#2" -DayOfWeekStartIndexOne | Should -Be "At 12:23 PM, on the second Sunday of the month"
    }

    It 'Get-CronDescription TestHourRangeWithEveryPortion' {
        Get-CronDescription -Crontab "0 25 7-19/8 ? * *" | Should -Be "At 25 minutes past the hour, every 8 hours, between 07:00 AM and 07:59 PM"
    }

    It 'Get-CronDescription TestHourRangeWithTrailingZeroWithEveryPortion' {
        Get-CronDescription -Crontab "0 25 7-20/13 ? * *" | Should -Be "At 25 minutes past the hour, every 13 hours, between 07:00 AM and 08:59 PM"
    }

    It 'Get-CronDescription TestEvery3Day' {
        Get-CronDescription -Crontab "0 0 8 1/3 * ? *" | Should -Be "At 08:00 AM, every 3 days"
    }

    It 'Get-CronDescription TestsEvery3DayOfTheWeek' {
        Get-CronDescription -Crontab "0 15 10 ? * */3" | Should -Be "At 10:15 AM, every 3 days of the week"
    }

    It 'Get-CronDescription TestEvery2DayOfTheWeekInRange' {
        Get-CronDescription -Crontab "* * * ? * 1-5/2" | Should -Be "Every second, every 2 days of the week, Monday through Friday"
    }

    It 'Get-CronDescription TestEvery2DayOfTheWeekInRangeWithSundayStartOne' {
        Get-CronDescription -Crontab "* * * ? * 2-6/2" -DayOfWeekStartIndexOne | Should -Be "Every second, every 2 days of the week, Monday through Friday"
    }

    It 'Get-CronDescription TestMultiWithDayOfWeekStartIndexZeroFalse' {
        Get-CronDescription -Crontab "* * * ? * 1,2,3" -DayOfWeekStartIndexOne | Should -Be "Every second, only on Sunday, Monday, and Tuesday"
    }

    It 'Get-CronDescription TestEvery3Month' {
        Get-CronDescription -Crontab "0 5 7 2 1/3 ? *" | Should -Be "At 07:05 AM, on day 2 of the month, every 3 months"
    }

    It 'Get-CronDescription TestEvery2Years' {
        Get-CronDescription -Crontab "0 15 6 1 1 ? 1/2" | Should -Be "At 06:15 AM, on day 1 of the month, only in January, every 2 years"
    }

    It 'Get-CronDescription TestMutiPartRangeMinutes' {
        Get-CronDescription -Crontab "2,4-5 1 * * *" | Should -Be "At 2 and 4 through 5 minutes past the hour, at 01:00 AM"
    }

    It 'Get-CronDescription TestMutiPartRangeMinutes2' {
        Get-CronDescription -Crontab "2,26-28 18 * * *" | Should -Be "At 2 and 26 through 28 minutes past the hour, at 06:00 PM"
    }

    It 'Get-CronDescription TrailingSpaceDoesNotCauseAWrongDescription' {
        Get-CronDescription -Crontab "0 7 * * * " | Should -Be "At 07:00 AM"
    }

    It 'Get-CronDescription TestMultiPartDayOfTheWeek' {
        Get-CronDescription -Crontab "0 00 10 ? * MON-THU,SUN *" | Should -Be "At 10:00 AM, only on Monday through Thursday and Sunday"
    }

    It 'Get-CronDescription TestDayOfWeekWithDayOfMonth' {
        Get-CronDescription -Crontab "0 0 0 1,2,3 * WED,FRI" | Should -Be "At 12:00 AM, on day 1, 2, and 3 of the month, only on Wednesday and Friday"
    }

    It 'Get-CronDescription TestSecondsInternalWithStepValue' {
        Get-CronDescription -Crontab "5/30 * * * * ?" | Should -Be "Every 30 seconds, starting at 5 seconds past the minute"
    }

    It 'Get-CronDescription TestMinutesInternalWithStepValue' {
        Get-CronDescription -Crontab "0 5/30 * * * ?" | Should -Be "Every 30 minutes, starting at 5 minutes past the hour"
    }

    It 'Get-CronDescription TestHoursInternalWithStepValue' {
        Get-CronDescription -Crontab "* * 5/8 * * ?" | Should -Be "Every second, every 8 hours, starting at 05:00 AM"
    }

    It 'Get-CronDescription TestDayOfMonthInternalWithStepValue' {
        Get-CronDescription -Crontab "0 5 7 2/3 * ? *" | Should -Be "At 07:05 AM, every 3 days, starting on day 2 of the month"
    }

    It 'Get-CronDescription TestMonthInternalWithStepValue' {
        Get-CronDescription -Crontab "0 5 7 ? 3/2 ? *" | Should -Be "At 07:05 AM, every 2 months, March through December"
    }

    It 'Get-CronDescription TestDayOfWeekInternalWithStepValue' {
        Get-CronDescription -Crontab "0 5 7 ? * 2/3 *" | Should -Be "At 07:05 AM, every 3 days of the week, Tuesday through Saturday"
    }

    It 'Get-CronDescription TestYearInternalWithStepValue' {
        Get-CronDescription -Crontab "0 5 7 ? * ? 2016/4" | Should -Be "At 07:05 AM, every 4 years, 2016 through 9999"
    }

    It 'Get-CronDescription TestMinutesCombinedWithMultipleHourRanges' {
        Get-CronDescription -Crontab "1 1,3-4 * * *" | Should -Be "At 1 minutes past the hour, at 01:00 AM and 03:00 AM through 04:59 AM"
    }

    It 'Get-CronDescription TestMinuteRangeConbinedWithSecondRange' {
        Get-CronDescription -Crontab "12-50 0-10 6 * * * 2022" | Should -Be "Seconds 12 through 50 past the minute, minutes 0 through 10 past the hour, at 06:00 AM, only in 2022"
    }

    It 'Get-CronDescription TestSecondsExpressionCombinedWithHoursListAndSingleMinute' {
        Get-CronDescription -Crontab "5 30 6,14,16 5 * *" | Should -Be "At 5 seconds past the minute, at 30 minutes past the hour, at 06:00 AM, 02:00 PM, and 04:00 PM, on day 5 of the month"
    }

    It 'Get-CronDescription TestMinuteRangeWithInterval' {
        Get-CronDescription -Crontab "0-20/3 9 * * *" | Should -Be "Every 3 minutes, minutes 0 through 20 past the hour, between 09:00 AM and 09:59 AM"
    }

    It 'Get-CronDescription MinutesZero1' {
        Get-CronDescription -Crontab "* 0 */4 * * *" | Should -Be "Every second, at 0 minutes past the hour, every 4 hours"
    }

    It 'Get-CronDescription MinutesZero2' {
        Get-CronDescription -Crontab "*/10 0 * * * *" | Should -Be "Every 10 seconds, at 0 minutes past the hour"
    }

    It 'Get-CronDescription MinutesZero3' {
        Get-CronDescription -Crontab "* 0 0 * * *" | Should -Be "Every second, at 0 minutes past the hour, between 12:00 AM and 12:59 AM"
    }

    It 'Get-CronDescription MinutesZero4' {
        Get-CronDescription -Crontab "* 0 * * *" | Should -Be "Every minute, between 12:00 AM and 12:59 AM"
    }

    It 'Get-CronDescription MinutesZero5' {
        Get-CronDescription -Crontab "* 0 * * * *" | Should -Be "Every second, at 0 minutes past the hour"
    }

    It 'Get-CronDescription Sunday7' {
        Get-CronDescription -Crontab "0 0 9 ? * 7" | Should -Be "At 09:00 AM, only on Sunday"
    }

    It 'Get-CronDescription EveryYear' {
        Get-CronDescription -Crontab "0/10 * ? * MON-FRI *" | Should -Be "Every 10 minutes, Monday through Friday"
    }

}
