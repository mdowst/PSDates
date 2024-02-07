BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'ConvertTo-UnixTime Tests' {
    It 'ConvertTo-UnixTime Test' {
        ConvertTo-UnixTime -Date (Get-Date '2017-11-17T00:00:00.000Z').ToUniversalTime() | Should -Be 1510876800
    }
}
