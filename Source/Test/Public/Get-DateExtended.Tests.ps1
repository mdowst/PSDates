BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-DateExtended Tests' {
    It 'Get-DateExtended Test' {
        $dateExt = Get-DateExtended "11/17/2017"
        $dateExt.DateTime | Should -Be (Get-Date '11/17/2017 00:00:00')
        $dateExt.FirstDayOfYear | Should -Be (Get-Date '01/01/2017 00:00:00')
        $dateExt.LastDayOfYear | Should -Be (Get-Date '12/31/2017 00:00:00')
        $dateExt.StartOfWeek | Should -Be (Get-Date '11/12/2017 00:00:00')
        $dateExt.EndOfWeek | Should -Be (Get-Date '11/18/2017 23:59:59')
        $dateExt.StartOfMonth | Should -Be (Get-Date '11/01/2017 00:00:00')
        $dateExt.EndOfMonth | Should -Be (Get-Date '11/30/2017 23:59:59')
        $dateExt.WeekOfYear | Should -Be 46
        $dateExt.TimeZone | Should -Be ([System.TimeZoneInfo]::Local)
        $dateExt.Quater | Should -Be 4
        $dateExt.Date | Should -Be (Get-Date '11/17/2017 00:00:00')
        $dateExt.Day | Should -Be 17
        $dateExt.DayOfWeek | Should -Be 'Friday'
        $dateExt.DayOfYear | Should -Be 321
        $dateExt.Hour | Should -Be 0
        $dateExt.Kind | Should -Be 'Unspecified'
        $dateExt.Millisecond | Should -Be 0
        $dateExt.Minute | Should -Be 0
        $dateExt.Month | Should -Be 11
        $dateExt.Second | Should -Be 0
        $dateExt.Ticks | Should -Be 636464736000000000
        $dateExt.TimeOfDay | Should -Be 00:00:00
        $dateExt.Year | Should -Be 2017
    }
}
