BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'New-Duration Tests' {
    It 'New-Duration Test' {
        New-Duration -Start '2/3/2023' -End '2/5/2023' | Should -Be 'P2D'
        New-Duration -Days 1 -Hours 4 | Should -Be 'P1DT4H'
        New-Duration -Weeks 3 | Should -Be 'P3W'
    }
}
