$Public  = @( Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public\*.ps1')  -Recurse -ErrorAction SilentlyContinue )

#Dot source the files
Foreach ($import in $Public) {
    Try {
        Write-Verbose "dot-sourcing file '$($import.fullname)'"
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

#Add-Type -Path (Join-Path $PSScriptRoot 'Resources\ncrontab.3.3.0\lib\net35\NCrontab.dll')