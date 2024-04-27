param(
    [Parameter(Mandatory = $false)]    
    [string]$Version = 'v1.0.1'
)

$VersionNumber = [version]::parse($Version.Split('/')[-1].TrimStart('v'))
Set-Location $PSScriptRoot

if(Test-Path .\Build){
    Get-ChildItem -Path .\Build | Remove-Item -Recurse -Force
}

#$linter = . '.\Source\Test\ScriptAnalyzer\ScriptAnalyzer.Linter.ps1'
#if ($linter) {
##    $linter
#    throw "Failed linter tests"
#}

Build-Module -SourcePath .\Source -OutputDirectory ..\Build -Version $VersionNumber

$psd1 = Get-ChildItem .\Build -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1 

$ResourceFolder = Join-Path $psd1.DirectoryName 'Resources'
New-Item -Path $ResourceFolder -ItemType Directory | Out-Null
Copy-Item -Path '.\Source\Resources\CronExpressionDescriptor.dll' -Destination $ResourceFolder
Copy-Item -Path '.\Source\Resources\ncrontab.3.3.0\lib\net35\NCrontab.dll' -Destination $ResourceFolder
Copy-Item -Path '.\Source\Resources\DateTimeExtensions.format.ps1xml' -Destination $ResourceFolder

#$nuspec = Copy-Item -Path .\Source\PSDates.nuspec -Destination $psd1.DirectoryName -PassThru

#.'nuget.exe' pack "$($nuspec.FullName)" -OutputDirectory .\Build -Version "$($VersionNumber)"