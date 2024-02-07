BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
    [cultureinfo]::CurrentCulture = 'en-US'
}

Describe 'Get-DateFormat Tests' {
    It 'Get-DateFormat Test' {
        $dateFormat = Get-DateFormat -Date (Get-Date '2017-11-17T00:00:00.000Z').ToUniversalTime()
        $dateFormat.'24HourTime' | Should -Be '00:00'
        $dateFormat.DateTime | Should -Be '11/17/2017 00:00:00'
        $dateFormat.Day | Should -Be '17'
        $dateFormat.DayAbrv | Should -Be 'Fri'
        $dateFormat.DayName | Should -Be 'Friday'
        $dateFormat.DayOfWeek | Should -Be '5'
        $dateFormat.FileTime | Should -Be '131553504000000000'
        $dateFormat.FullDateShortTime | Should -Be 'Friday, November 17, 2017 12:00 AM'
        $dateFormat.FullDateTime | Should -Be 'Friday, November 17, 2017 12:00:00 AM'
        $dateFormat.GeneralDateShortTime | Should -Be '11/17/2017 12:00 AM'
        $dateFormat.GeneralDateTime | Should -Be '11/17/2017 12:00:00 AM'
        $dateFormat.IsDaylightSavingTime | Should -Be 'False'
        $dateFormat.IsLeapYear | Should -Be 'False'
        $dateFormat.ISO8601 | Should -Match '2017-11-17T00:00:00.000'
        $dateFormat.ISO8601UTC | Should -Be '2017-11-17T00:00:00.000Z'
        $dateFormat.LongDate | Should -Be 'Friday, November 17, 2017'
        $dateFormat.LongDateNoDay | Should -Be 'November 17, 2017'
        $dateFormat.LongTime | Should -Be '12:00:00 AM'
        $dateFormat.Month | Should -Be '11'
        $dateFormat.MonthAbrv | Should -Be 'Nov'
        $dateFormat.MonthDay | Should -Be 'November 17'
        $dateFormat.MonthName | Should -Be 'November'
        $dateFormat.Quater | Should -Be '4'
        $dateFormat.RFC1123 | Should -Be 'Fri, 17 Nov 2017 00:00:00 GMT'
        $dateFormat.RFC1123UTC | Should -Be 'Fri, 17 Nov 2017 00:00:00 GMT'
        $dateFormat.RoundTrip | Should -Be '2017-11-17T00:00:00.0000000Z'
        $dateFormat.ShortDate | Should -Be '11/17/2017'
        $dateFormat.ShortTime | Should -Be '12:00 AM'
        $dateFormat.SortableDateTime | Should -Be '2017-11-17T00:00:00'
        $dateFormat.SQL | Should -Be '2017-11-17 00:00:00.000'
        $dateFormat.UniversalFullDateTime | Should -Be 'Friday, November 17, 2017 12:00:00 AM'
        $dateFormat.UniversalSortableDateTime | Should -Be '2017-11-17 00:00:00Z'
        $dateFormat.UnixEpochTime | Should -Be '1510876800'
        $dateFormat.WimDatetime | Should -Be '20171117000000.000000+000'
        $dateFormat.Year | Should -Be '2017'
        $dateFormat.YearMonth | Should -Be 'November 2017'
        $dateFormat.YearQuater | Should -Be '201704'
    }
}
