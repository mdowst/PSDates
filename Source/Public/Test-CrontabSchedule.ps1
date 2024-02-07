Function Test-CrontabSchedule {
    <#
.SYNOPSIS
   Tests that a crontab string is valid

.DESCRIPTION
   This function attempts to parse a crontab string to ensure it is valid.

.PARAMETER Crontab
   The datetime value to return the second Tuesday for the month

.EXAMPLE
   Test-CrontabSchedule -crontab '0 17 * * *'

    Valid schedule that returns:
    Crontab     Valid
    -------     -----
    0 17 * * *   True

.EXAMPLE
    Test-CrontabSchedule -crontab '0 17 * 13 *'

    Invalid schedule that returns:
    Crontab     Valid ErrorMsg
    -------     ----- --------
    0 17 * 13 * False 13 is higher than the maximum allowable value for the [Month] field. Value must be between 1 and 12 (all inclusive).

.OUTPUTS
   A psobject that contains the crontable, a validation value, and any error messages returned
#>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Crontab
    )

    $Result = [ordered]@{
        Schedule = $Crontab
        Valid    = $false
    }

    try {
        $Result['Schedule'] = [NCrontab.CrontabSchedule]::Parse($Crontab)
        $Result['Valid'] = $true
    }
    catch {
        $ErrorMsg = $_.Exception.ErrorRecord.ToString()
        $ErrorMsg = $ErrorMsg.Substring($ErrorMsg.IndexOf(': "') + 3)
        $ErrorMsg = $ErrorMsg.Substring(0, $ErrorMsg.Length - 1)
        $Result.Add('ErrorMsg', $ErrorMsg)
    }

    [PSCustomObject]$Result

}
