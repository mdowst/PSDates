$ScriptsToImport  = @( Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public\*.ps1')  -Recurse -ErrorAction SilentlyContinue ) +
    @( Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private\*.ps1')  -Recurse -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($import in $ScriptsToImport) {
    Try {
        Write-Verbose "dot-sourcing file '$($import.fullname)'"
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}