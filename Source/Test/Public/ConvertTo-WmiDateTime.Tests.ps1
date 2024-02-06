BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'ConvertTo-WmiDateTime Tests' {
    It 'ConvertTo-WmiDateTime Test' {
        ConvertTo-WmiDateTime -Date '06/25/2019 16:17' | Should -Be '20190625161700.000000-300'
    }
}
