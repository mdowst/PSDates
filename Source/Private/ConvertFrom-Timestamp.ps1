function ConvertFrom-Timestamp {
    param (
        [double]$Timestamp,
        [System.TimeZoneInfo]$TimeZone = $null
    )
    $datetime = ConvertFrom-UnixTime $Timestamp
    if ($TimeZone) {
        $datetime = [System.TimeZoneInfo]::ConvertTimeFromUtc($datetime, $TimeZone)
    }
    $datetime.ToString()
}