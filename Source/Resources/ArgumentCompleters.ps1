function GetDateFormatsCompletionResult {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    [DateTimeFormats]::new().psobject.Properties.Name | foreach-object {
        New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList "'$_'",
        $_ , ([System.Management.Automation.CompletionResultType]::ParameterValue) , $_
    }
}

function GetTimeZoneCompletionResult {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    foreach ($dt in [System.TimeZoneInfo]::GetSystemTimeZones()) {
        if ($dt.id, $dt.displayname -match $wordToComplete) {
            [Management.Automation.CompletionResult]::new(
                ("'{0}'" -f $dt.id),
                $dt.DisplayName,
                "ParameterValue",
                ("{0}/{1} (DST:{2})" -f @(
                    $dt.StandardName
                    $dt.DaylightName
                    $dt.SupportsDaylightSavingTime
                ))
            )
        }
    }
}

if(Get-Command -ErrorAction SilentlyContinue -name Register-ArgumentCompleter) {
    Register-ArgumentCompleter -CommandName Get-DateFormat -ParameterName Format  -ScriptBlock $Function:GetDateFormatsCompletionResult
    Register-ArgumentCompleter -CommandName Convert-TimeZone -ParameterName ToTimeZone  -ScriptBlock $Function:GetTimeZoneCompletionResult
    Register-ArgumentCompleter -CommandName Convert-TimeZone -ParameterName FromTimeZone  -ScriptBlock $Function:GetTimeZoneCompletionResult
    Register-ArgumentCompleter -CommandName Get-SunTime -ParameterName TimeZone  -ScriptBlock $Function:GetTimeZoneCompletionResult
}