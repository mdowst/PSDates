class SunTimes {
    [double]       $Latitude 
    [double]       $Longitude
    [int64]        $Now
    [double]       $JulianDate
    [double]       $JulianDay
    [double]       $MeanSolarTime
    [double]       $SolarMeanAnomaly
    [double]       $EquationOfTheCenter
    [double]       $EclipticLongitude
    [double]       $SolarTransitTime
    [double]       $HourAngle
    [DateTime]     $Sunrise
    [DateTime]     $Sunset
    [double]       $DayLength
    [TimeZoneInfo] $TimeZone

    [string] ToDegreeString([double] $value) {
        $x = [math]::Round($value * 3600)
        $num = "∠{0:N3}°" -f $value
        $rad = "∠{0:N3}rad" -f ($value * ([math]::PI / 180))
        $human = "∠{0}°{1}′{2}″" -f ($x / 3600), ($x / 60 % 60), ($x % 60)
        return "$rad = $human = $num"
    }

    [string] FromTimestamp([double]$Timestamp,
    [System.TimeZoneInfo]$TimeZone = $null) {
        $datetime = ConvertFrom-UnixTime $Timestamp
        if ($TimeZone) {
            $datetime = [System.TimeZoneInfo]::ConvertTimeFromUtc($datetime, $TimeZone)
        }
        return $datetime.ToString()
    }

    [double] JulianToTimestamp(
        [double]$Julian
    ) {
        return ($Julian - 2440587.5) * 86400
    }
}