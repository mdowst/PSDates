BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Convert-TimeZone Tests' {
    It 'Convert-TimeZone Test' {
        $conversion = Convert-TimeZone -Date '11/17/2017 12:34 AM' -FromTimeZone "China Standard Time" -ToTimeZone "US Mountain Standard Time"
        $conversion.FromDateTime | Should -Be (Get-Date '11/17/2017 12:34:00 AM')
        $conversion.FromTimeZone | Should -Be 'China Standard Time'
        $conversion.ToDateTime   | Should -Be (Get-Date '11/16/2017 9:34:00 AM')
        $conversion.ToTimeZone   | Should -Be 'US Mountain Standard Time'
        $conversion.Offset       | Should -Be '-15:00:00'
    }
}
