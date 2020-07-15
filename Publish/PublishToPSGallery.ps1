# Script variables
$IncludeDirectories = 'Public','Resources'
$ModulesFolder = (Split-Path $PSScriptRoot)
$NugetAPIKey = Get-Content (Join-Path $PSScriptRoot 'APIKey.json')

# Get the module manifest
$psd1File = Get-ChildItem -path $ModulesFolder -Filter "*.psd1" | Select-Object -ExpandProperty FullName
$psd1 = Test-ModuleManifest $psd1File

# Revise the new version
$Revision = $psd1.Version.Revision + 1
[System.Version]$newVersion = [System.Version]::new($psd1.Version.Major, $psd1.Version.Minor, $psd1.Version.MinorRevision, $Revision)

Write-Verbose "New version '$version'"

Update-ModuleManifest -Path $psd1File -ModuleVersion $newVersion

# create the release folder
$releaseFolder = Join-Path $PSScriptRoot "\PSDates\$($newVersion.ToString())"
If (-not(Test-Path $releaseFolder)){
    New-Item -type Directory -Path $releaseFolder | Out-Null
}

# Copy files to release folder
Get-ChildItem $ModulesFolder -Filter '*.ps*1' | Where-Object { $_.Name -notlike '*test*' } |
    Copy-Item -Destination $releaseFolder

[System.Collections.Generic.List[PSObject]]$DirectoriesToCopy = @()
foreach($folder in $IncludeDirectories){
    $DirectoriesToCopy.Add($folder)
    Get-ChildItem -Path (Join-Path $ModulesFolder $folder) -Directory -Recurse | ForEach-Object {
        $DirectoriesToCopy.Add($_.FullName.Replace($ModulesFolder,''))
    }
}

foreach($folder in $DirectoriesToCopy){
    $destFolder = Join-Path $releaseFolder $folder
    If (-not(Test-Path $destFolder)){
        New-Item -type Directory -Path $destFolder | Out-Null
    }

    Get-ChildItem $modFolder -File | Copy-Item -Destination $destFolder
}


# Publish to powershell gallery
Publish-Module -Path $releaseFolder -NugetAPIKey $NugetAPIKey -Verbose