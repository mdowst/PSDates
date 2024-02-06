BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-CronNextOccurrence Tests' {
    It 'Get-CronNextOccurrence Test' {
        $fivePM = Get-Date '17:00'
        if($fivePM -lt (Get-Date)){
            $fivePM = $fivePM.AddDays(1)
        }
        Get-CronNextOccurrence -Crontab '0 17 * * *' | Should -Be $fivePM
    }
    It 'Get-CronNextOccurrence Specific Date Test' {
        $StartTime = Get-Date '12/14/2032'
        Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $StartTime | Should -Be (Get-Date '12/14/2032 17:00')
    }
    It 'Get-CronNextOccurrence Multiple Occurrences Test' {
        $StartTime = Get-Date '12/14/2032'
        $threeDays = 14..16 | ForEach-Object{
            Get-Date "12/$($_)/2032 17:00"
        }
        Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $StartTime -EndTime $StartTime.AddDays(3) | Should -Be $threeDays
    }
}
