BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Find-TimeZone Tests' {
    It 'Find-TimeZone Test' {
        $london = 'GMT Standard Time'
        if($IsLinux){
            $london = 'Europe/London'
        }
        (Find-TimeZone -Name "London").Id | Should -Be $london
    }
}
