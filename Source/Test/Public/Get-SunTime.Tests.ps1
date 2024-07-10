BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Get-SunTime Tests' {
    It '<Name> Test' -ForEach @(
        @{Name = 'Buckingham Palace'; Latitude = 51.501005; Longitude = -0.1445479; Elevation = 0; Sunrise = '03:52'; Sunset = '20:20' }
        @{Name = 'The Great Pyramid of Giza'; Latitude = 29.9791705; Longitude = 31.1316297; Elevation = 0; Sunrise = '03:00'; Sunset = '17:01' }
        @{Name = 'Imperial Palace'; Latitude = 35.6778452; Longitude = 139.7547335; Elevation = 0; Sunrise = '19:31'; Sunset = '10:01' }
        @{Name = 'The White House'; Latitude = 38.8976763; Longitude = -77.0365298; Elevation = 0; Sunrise = '09:49'; Sunset = '00:37' }
        @{Name = 'The Eiffel Tower'; Latitude = 48.8583701; Longitude = 2.2919064; Elevation = 0; Sunrise = '03:55'; Sunset = '19:57' }
        @{Name = 'Sydney Opera House'; Latitude = -33.8531432; Longitude = 151.1764362; Elevation = 0; Sunrise = '21:01'; Sunset = '07:00' }
        @{Name = 'Pier 39'; Latitude = 37.7917995; Longitude = -122.4352178; Elevation = 0; Sunrise = '12:54'; Sunset = '03:36' }
        @{Name = 'The Zocalo'; Latitude = 19.4326018; Longitude = -99.1357798; Elevation = 0; Sunrise = '12:04'; Sunset = '01:20' }
        @{Name = 'Pike Place Market'; Latitude = 47.6096619; Longitude = -122.344816; Elevation = 0; Sunrise = '12:19'; Sunset = '04:10' }
        @{Name = 'Tsim Sha Tsui Waterfront'; Latitude = 22.2974716; Longitude = 114.1772887; Elevation = 0; Sunrise = '21:45'; Sunset = '11:12' }
        @{Name = 'Grand Bazaar'; Latitude = 41.0179762; Longitude = 28.9450643; Elevation = 0; Sunrise = '02:39'; Sunset = '17:40' }
        @{Name = 'The Forbidden City'; Latitude = 39.9168038; Longitude = 116.3945872; Elevation = 0; Sunrise = '20:52'; Sunset = '11:47' }
        @{Name = 'Niagara Falls'; Latitude = 43.0535092; Longitude = -79.3998494; Elevation = 0; Sunrise = '09:45'; Sunset = '01:00' }
        @{Name = 'The Colosseum'; Latitude = 41.8902101; Longitude = 12.48736; Elevation = 0; Sunrise = '03:42'; Sunset = '18:49' }
        @{Name = 'Times Square'; Latitude = 40.7579747; Longitude = -73.9881175; Elevation = 0; Sunrise = '09:31'; Sunset = '00:31' }
    ) {
        $TimeZone = [System.TimeZoneInfo]::Utc.Id
        $Date = Get-Date '2024-07-05'
        $CalculateSunTimesParam = @{
            Date      = $Date
            Latitude  = $Latitude
            Longitude = $Longitude
            Elevation = $Elevation
            TimeZone  = $TimeZone
        }
        $Result = Get-SunTime @CalculateSunTimesParam
        $Result.Sunrise.ToString('HH:mm') | Should -Be $Sunrise
        $Result.Sunset.ToString('HH:mm') | Should -Be $Sunset
    }
}