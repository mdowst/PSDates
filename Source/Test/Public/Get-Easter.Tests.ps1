BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-Easter Tests' {
    It '<Name> Gregorian Test' -ForEach @(
        @{Year = '1583'; Easter = '1583-04-10'; }
        @{Year = '1612'; Easter = '1612-04-22'; }
        @{Year = '1722'; Easter = '1722-04-05'; }
        @{Year = '1784'; Easter = '1784-04-11'; }
        @{Year = '1892'; Easter = '1892-04-17'; }
        @{Year = '2075'; Easter = '2075-04-07'; }
        @{Year = '2096'; Easter = '2096-04-15'; }
        @{Year = '2221'; Easter = '2221-04-15'; }
        @{Year = '2369'; Easter = '2369-03-30'; }
        @{Year = '2387'; Easter = '2387-04-05'; }
        @{Year = '2553'; Easter = '2553-04-01'; }
        @{Year = '2599'; Easter = '2599-04-07'; }
        @{Year = '2715'; Easter = '2715-04-11'; }
        @{Year = '2861'; Easter = '2861-04-17'; }
        @{Year = '2933'; Easter = '2933-04-05'; }
        @{Year = '3078'; Easter = '3078-04-21'; }
        @{Year = '3125'; Easter = '3125-04-12'; }
        @{Year = '3229'; Easter = '3229-04-08'; }
        @{Year = '3372'; Easter = '3372-04-12'; }
        @{Year = '3457'; Easter = '3457-04-05'; }
        @{Year = '3510'; Easter = '3510-04-24'; }
        @{Year = '3681'; Easter = '3681-04-20'; }
        @{Year = '3695'; Easter = '3695-04-17'; }
        @{Year = '3783'; Easter = '3783-04-06'; }
        @{Year = '3947'; Easter = '3947-04-20'; }
        @{Year = '3988'; Easter = '3988-04-17'; }
        @{Year = '4099'; Easter = '4099-04-19'; }
    ) {
        Get-Easter $Year | Should -Be (Get-Date $Easter)
    }
}