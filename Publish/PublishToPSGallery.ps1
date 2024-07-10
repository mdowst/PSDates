<#
Run build.ps1 first
#>

# Script variables
$TopLevel = (Split-Path $PSScriptRoot)
$NugetAPIKey = Get-Content (Join-Path $PSScriptRoot 'APIKey.json')

Set-Location $TopLevel

$testResultsXML = Join-Path $TopLevel 'Build\testResults.xml'
$config = New-PesterConfiguration
$config.Run.Path = (Join-Path $TopLevel 'Source\Test')
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testResultsXML
Invoke-Pester -Configuration $config
[xml]$testResults = Get-Content -LiteralPath $testResultsXML -Raw
if($testResults.'test-results'.'test-suite'.result -eq 'Failure'){
    $testResults.'test-results'.'test-suite'.results.'test-suite' | Select-Object Name, result
    throw "Failed Pester tests"
}

# Get the module manifest
$psd1File = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
$psd1 = Test-ModuleManifest $psd1File
Read-Host "Publish version '$($psd1.Version)'"

# Publish to powershell gallery
Publish-Module -Path $psd1File.DirectoryName -NugetAPIKey $NugetAPIKey -Verbose