function Convert-JulianToTimestamp {
    [CmdletBinding()]
    param (
        [double]$Julian
    )
    ($Julian - 2440587.5) * 86400
}