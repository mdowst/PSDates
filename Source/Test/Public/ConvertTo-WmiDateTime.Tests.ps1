BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'ConvertTo-WmiDateTime Tests' {
    It 'ConvertTo-WmiDateTime Test' {
        ConvertTo-WmiDateTime -Date (Get-Date '2017-06-25T16:17:00.000Z').ToUniversalTime() | Should -Be '20170625161700.000000+000'
    }
}
