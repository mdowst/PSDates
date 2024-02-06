BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-PatchTuesday Tests' {
    It 'Get-PatchTuesday Test' {
        Get-PatchTuesday -Date "11/17/2021" | Should -Be (Get-Date '2021-11-09')
    }
}
