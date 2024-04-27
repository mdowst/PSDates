Set-Location $PSScriptRoot

if(-not (Test-Path .\Build)){
    throw "Project must be built first"
}

$psd1 = Get-ChildItem .\Build -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1 
Import-Module $psd1.FullName -Force

Get-ChildItem .\docs -Filter '*.md' | Remove-Item -Force

New-MarkdownHelp -Module PSDates -OutputFolder .\docs

$readme = Get-Content .\README.md
$docs = Get-ChildItem .\docs -Filter '*.md' | ForEach-Object{
    $content = Get-Content -LiteralPath $_.FullName
    "| [$($_.BaseName)](docs/$($_.Name)) | $($content[$content.IndexOf('## SYNOPSIS')+2]) |"
}



$commands = $false
$readmeupdate = foreach($line in $readme){
    if($line -eq '# Commands'){
        $commands = $true
        $line
        ''
        '| Cmdlet | Synopsis |'
        '| ------ | -------- |'
        $docs
        ''
    }
    elseif($commands -and $line -match '^#'){
        $commands = $false
    }

    if(-not $commands){
        $line
    }
}

$readmeupdate | Out-File .\README.md