BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'ConvertFrom-UnixTime Tests' {
    It 'ConvertFrom-UnixTime Test' {
        ConvertFrom-UnixTime -UnixTime 1510876800 | Should -Be (Get-Date '2017-11-17T00:00:00.000Z').ToUniversalTime()
    }
}
