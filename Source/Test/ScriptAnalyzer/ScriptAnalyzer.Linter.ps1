$Public = Join-Path (Split-Path(Split-Path $PSScriptRoot)) 'Public'
$Settings = Join-Path $PSScriptRoot 'PSScriptAnalyzerSettings.psd1'
Invoke-ScriptAnalyzer -Path $Public -Recurse -Settings $Settings

