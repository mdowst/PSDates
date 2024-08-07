function Get-SunTime {
    <#
.SYNOPSIS
Find sunrise and sunset times for any location on planet Earth.

.DESCRIPTION
This function finds the time of day for sunrise, sunset based on the given latitude and longitude. You can also specify time zone and elevation.

.PARAMETER Date
The day to find the sunrise and sunset for.

.PARAMETER Latitude
The Latitude entered as a decimal number representing degrees and minutes

.PARAMETER Longitude
The Longitude entered as a decimal number representing degrees and minutes

.PARAMETER Elevation
The Elevation in meters

.PARAMETER TimeZone
The time zone for the final results

.EXAMPLE
Get-SunTime -Latitude 51.501005 -Longitude -0.1445479

# Get the sunrise and sunset for the given coordinates for the current day

.EXAMPLE
$address = '1600 Pennsylvania Avenue NW'
$addr = Invoke-RestMethod "https://nominatim.openstreetmap.org/search?q=$($address)&format=json" | Select-Object -First 1
Get-SunTime -Latitude $addr.lat -Longitude $addr.lon

# Use the free Nominatim API get the coordinates for an address, then use those results to get the sunrise and sunset for that location.

.NOTES
Use can use Google Maps to find the latitude and longitude coordinates. 
Right click a specific point on the Google map and you will see the latitude and longitude coordinates displayed, for example 45.51421, -122.68462.

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [datetime]$Date = $(Get-Date),
        [Parameter(Mandatory = $true)]
        [double]$Latitude,
        [Parameter(Mandatory = $true)]
        [double]$Longitude,
        [Parameter(Mandatory = $false)]
        [double]$Elevation = 0.0,
        [Parameter(Mandatory = $false)]
        [string]$TimeZone = $null
    )
    $suntime = [SunTime]::new()
    $datetimeOffset = [DateTimeOffset]::new($Date)
    $CurrentTimestamp = $datetimeOffset.ToUniversalTime().ToUnixTimeSeconds()

    $TimeZoneInfo = [System.TimeZoneInfo]::Local
    if(-not [string]::IsNullOrEmpty($TimeZone)){
        $TimeZoneInfo = [System.TimeZoneInfo]::FindSystemTimeZoneById($TimeZone)
    }
    

    Write-Verbose "Latitude               f       = $($suntime.ToDegreeString($Latitude))"
    Write-Verbose "Longitude              l_w     = $($suntime.ToDegreeString($Longitude))"
    Write-Verbose "Now                    ts      = $($suntime.FromTimestamp($CurrentTimestamp, $TimeZoneInfo))"

    
    $J_date = $suntime.TimestampToJulian($CurrentTimestamp)
    Write-Verbose ("Julian date            j_date  = {0:N3} days" -f $J_date)
    
    # Julian day
    $n = [math]::Ceiling($J_date - (2451545.0 + 0.0009) + 69.184 / 86400.0)
    Write-Verbose ("Julian day             n       = {0:N3} days" -f $n)

    # Mean solar time
    $J_ = $n + 0.0009 - $Longitude / 360.0
    Write-Verbose ("Mean solar time        J_      = {0:N9} days" -f $J_)

    # Solar mean anomaly
    $M_degrees = [math]::IEEERemainder(357.5291 + 0.98560028 * $J_, 360)
    $M_radians = ($M_degrees * ([math]::PI / 180))
    Write-Verbose "Solar mean anomaly     M       = $($suntime.ToDegreeString($M_degrees))"

    # Equation of the center
    $C_degrees = 1.9148 * [math]::Sin($M_radians) + 0.02 * [math]::Sin(2 * $M_radians) + 0.0003 * [math]::Sin(3 * $M_radians)
    Write-Verbose "Equation of the center C       = $($suntime.ToDegreeString($C_degrees))"

    # Ecliptic longitude
    $L_degrees = [math]::IEEERemainder($M_degrees + $C_degrees + 180.0 + 102.9372, 360)
    Write-Verbose "Ecliptic longitude     L       = $($suntime.ToDegreeString($L_degrees))"

    $Lambda_radians = ($L_degrees * ([math]::PI / 180))

    # Solar transit (julian date)
    $J_transit = 2451545.0 + $J_ + 0.0053 * [math]::Sin($M_radians) - 0.0069 * [math]::Sin(2 * $Lambda_radians)
    Write-Verbose "Solar transit time     J_trans = $($suntime.FromTimestamp( $suntime.JulianToTimestamp($J_transit), $TimeZoneInfo))"

    # Declination of the Sun
    $sin_d = [math]::Sin($Lambda_radians) * [math]::Sin((23.4397 * ([math]::PI / 180)))
    $cos_d = [math]::Cos([math]::Asin($sin_d))

    # Hour angle
    $some_cos = ([math]::Sin(-0.833 * [math]::PI / 180 - 2.076 * [math]::Sqrt($Elevation) / 60.0 * [math]::PI / 180) - [math]::Sin($Latitude * [math]::PI / 180) * $sin_d) / ([math]::Cos($Latitude * [math]::PI / 180) * $cos_d)
    $w0_radians = [math]::Acos($some_cos)


    $w0_degrees = $w0_radians * 180 / [math]::PI
    Write-Verbose "Hour angle             w0      = $($suntime.ToDegreeString($w0_degrees))"

    $j_rise = $J_transit - $w0_degrees / 360
    $j_set = $J_transit + $w0_degrees / 360

    Write-Verbose "Sunrise                j_rise  = $($suntime.FromTimestamp( $suntime.JulianToTimestamp($j_rise), $TimeZoneInfo))"
    Write-Verbose "Sunset                 j_set   = $($suntime.JulianToTimestamp($j_rise)) = $($suntime.FromTimestamp($suntime.JulianToTimestamp($j_set), $TimeZoneInfo))"
    Write-Verbose ("Day length                       {0:N3} hours" -f ($w0_degrees / (180 / 24)))

    [SunTime]@{
        Latitude            = $Latitude
        Longitude           = $Longitude
        Now                 = $CurrentTimestamp
        JulianDate          = $J_date
        JulianDay           = $n
        MeanSolarTime       = $J_
        SolarMeanAnomaly    = $M_degrees
        EquationOfTheCenter = $C_degrees
        EclipticLongitude   = $L_degrees
        SolarTransitTime    = $J_transit
        HourAngle           = $w0_degrees
        Sunrise             = (Get-Date $($suntime.FromTimestamp($suntime.JulianToTimestamp($j_rise), $TimeZoneInfo)))
        Sunset              = (Get-Date $($suntime.FromTimestamp($suntime.JulianToTimestamp($j_set), $TimeZoneInfo)))
        DayLength           = ($w0_degrees / (180 / 24))
        TimeZone            = $TimeZoneInfo
    }
}