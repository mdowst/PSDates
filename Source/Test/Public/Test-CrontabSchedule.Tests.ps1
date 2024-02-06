BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Test-CrontabSchedule Tests' {
    It 'Test-CrontabSchedule Valid Test' {
        $valid = Test-CrontabSchedule -crontab '0 17 * * *'
        $valid.Schedule | Should -Be '0 17 * * *'
        $valid.Valid | Should -BeTrue
    }

    It 'Test-CrontabSchedule Invalid Test' {
        $invalid = Test-CrontabSchedule -crontab '0 17 * 13 *'
        $invalid.Schedule | Should -Be '0 17 * 13 *'
        $invalid.Valid | Should -BeFalse
        $invalid.ErrorMsg | Should -Be '13 is higher than the maximum allowable value for the [Month] field. Value must be between 1 and 12 (all inclusive).'
    }
}
