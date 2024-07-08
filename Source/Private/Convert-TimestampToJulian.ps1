function Convert-TimestampToJulian {
    param (
        [double]$Timestamp
    )
    $Timestamp / 86400.0 + 2440587.5
}