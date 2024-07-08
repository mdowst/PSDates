$VirtualProperties = [ordered]@{
    Date                = { $_.Sunrise.ToString('d') }
    Sunrise             = { $_.Sunrise.ToString('t') }
    Sunset              = { $_.Sunset.ToString('t') }
    DayLength           = { "{0:N3} hours" -f $_.DayLength }
    Latitude            = { $_.ToDegreeString($_.Latitude) }
    Longitude           = { $_.ToDegreeString($_.Longitude) }
    Now                 = { $_.FromTimestamp($_.Now, $_.TimeZone) }
    JulianDate          = { "{0:N3} days" -f $_.JulianDate }
    JulianDay           = { "{0:N3} days" -f $_.JulianDay }
    MeanSolarTime       = { "{0:N9} days" -f $_.MeanSolarTime }
    SolarMeanAnomaly    = { $_.ToDegreeString($_.SolarMeanAnomaly) }
    EquationOfTheCenter = { $_.ToDegreeString($_.EquationOfTheCenter) }
    EclipticLongitude   = { $_.ToDegreeString($_.EclipticLongitude) }
    SolarTransitTime    = { $_.FromTimestamp($_.JulianToTimestamp($_.SolarTransitTime), $_.TimeZone) }
    HourAngle           = { $_.ToDegreeString($_.HourAngle) }
}

$Property = $VirtualProperties.GetEnumerator() | ForEach-Object { $_.Name }
Write-FormatView -TypeName SunTimes -Property $Property -VirtualProperty $VirtualProperties -AsList

