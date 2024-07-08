$script:HolidayResources = Get-ChildItem -LiteralPath $PSScriptRoot -Filter '*.psd1' | ForEach-Object{
    $data = Import-PowerShellDataFile -LiteralPath $_.FullName
    [PSCustomObject]$data
}
function GetCountryCodes {
    $script:HolidayResources | ForEach-Object{
        New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList "'$($_.CountryCode)'", $_.CountryCode , ([System.Management.Automation.CompletionResultType]::ParameterValue) , $_.Name
    }
}

function GetHolidayTypes {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    $country = $fakeBoundParameter['Country']
    $holidays = $script:HolidayResources | Where-Object{ $_.CountryCode -eq $Country }
    if ($holidays) {
        $holidays.Types | foreach-object {
            New-Object -TypeName System.Management.Automation.CompletionResult -ArgumentList "'$_'",
            $_ , ([System.Management.Automation.CompletionResultType]::ParameterValue) , $_
        }
    }
}

if(Get-Command -ErrorAction SilentlyContinue -name Register-ArgumentCompleter) {
    Register-ArgumentCompleter -CommandName Get-Holiday -ParameterName Country  -ScriptBlock $Function:GetCountryCodes
    Register-ArgumentCompleter -CommandName Get-Holiday -ParameterName Type  -ScriptBlock $Function:GetHolidayTypes
}