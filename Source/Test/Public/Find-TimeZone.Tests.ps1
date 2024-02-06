BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Find-TimeZone Tests' {
    It 'Find-TimeZone Test' {
        Find-TimeZone -Name "GMT" | Should -Be '(UTC+00:00) Dublin, Edinburgh, Lisbon, London'
        Find-TimeZone -Name "central" -Offset -6 | Should -Contain ([System.TimeZoneInfo]::FindSystemTimeZoneById('Central Standard Time'))
    }
}
