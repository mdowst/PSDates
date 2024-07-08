BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-AnnualHoliday Tests' {
    It 'Get-AnnualHoliday Test' {
        Get-AnnualHoliday  -Month '1' -Day '1' | Should -Be (Get-Date 1/1/2024)
        Get-AnnualHoliday  -Month '1' -WeekOccurance '3' -DayOfWeek '1' | Should -Be (Get-Date 1/15/2024)
        Get-AnnualHoliday  -Month '2' -Day '2' | Should -Be (Get-Date 2/2/2024)
        Get-AnnualHoliday  -Month '2' -Day '14' | Should -Be (Get-Date 2/14/2024)
        Get-AnnualHoliday  -Month '2' -WeekOccurance '3' -DayOfWeek '1' | Should -Be (Get-Date 2/19/2024)
        Get-AnnualHoliday  -Month '3' -Day '17' | Should -Be (Get-Date 3/17/2024)
        Get-AnnualHoliday  -Month '4' -Day '15' | Should -Be (Get-Date 4/15/2024)
        Get-AnnualHoliday  -Month '4' -WeekOccurance 'LastFullWeek' -DayOfWeek '3' | Should -Be (Get-Date 4/24/2024)
        Get-AnnualHoliday  -Month '5' -WeekOccurance '2' -DayOfWeek '0' | Should -Be (Get-Date 5/12/2024)
        Get-AnnualHoliday  -Month '5' -Day '15' | Should -Be (Get-Date 5/15/2024)
        Get-AnnualHoliday  -Month '5' -WeekOccurance 'Last' -DayOfWeek '1' | Should -Be (Get-Date 5/27/2024)
        Get-AnnualHoliday  -Month '6' -Day '14' | Should -Be (Get-Date 6/14/2024)
        Get-AnnualHoliday  -Month '6' -WeekOccurance '3' -DayOfWeek '0' | Should -Be (Get-Date 6/16/2024)
        Get-AnnualHoliday  -Month '6' -Day '19' | Should -Be (Get-Date 6/19/2024)
        Get-AnnualHoliday  -Month '7' -Day '4' | Should -Be (Get-Date 7/4/2024)
        Get-AnnualHoliday  -Month '9' -WeekOccurance '1' -DayOfWeek '1' | Should -Be (Get-Date 9/2/2024)
        Get-AnnualHoliday  -Month '10' -WeekOccurance '2' -DayOfWeek '1' | Should -Be (Get-Date 10/14/2024)
        Get-AnnualHoliday  -Month '10' -Day '31' | Should -Be (Get-Date 10/31/2024)
        Get-AnnualHoliday  -Month '11' -WeekOccurance '1' -DayOfWeek '1' -OffsetDays '1' | Should -Be (Get-Date 11/5/2024)
        Get-AnnualHoliday  -Month '11' -Day '11' | Should -Be (Get-Date 11/11/2024)
        Get-AnnualHoliday  -Month '11' -WeekOccurance '4' -DayOfWeek '4' | Should -Be (Get-Date 11/28/2024)
        Get-AnnualHoliday  -Month '11' -WeekOccurance '4' -DayOfWeek '4' -OffsetDays '1' | Should -Be (Get-Date 11/29/2024)
        Get-AnnualHoliday  -Month '12' -Day '24' | Should -Be (Get-Date 12/24/2024)
        Get-AnnualHoliday  -Month '12' -Day '25' | Should -Be (Get-Date 12/25/2024)
        Get-AnnualHoliday  -Month '12' -Day '31' | Should -Be (Get-Date 12/31/2024)
    }
}

