BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'ConvertFrom-WmiDateTime Tests' {
    It 'ConvertFrom-WmiDateTime Test' {
        ConvertFrom-WmiDateTime -WmiTime '20190912173652.000000-000' | Should -Be (Get-Date '2019-09-12T17:36:52.000Z').ToLocalTime()
    }
}
