---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-SunTime

## SYNOPSIS

Find sunrise and sunset times for any location on planet Earth.

## SYNTAX

### __AllParameterSets

```
Get-SunTime [[-Date <DateTime>]] [-Latitude] <Double> [-Longitude] <Double> [[-Elevation <Double>]] [[-TimeZone <String>]] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This function finds the time of day for sunrise, sunset based on the given latitude and longitude.
You can also specify time zone and elevation.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-SunTime -Latitude 51.501005 -Longitude -0.1445479
```

# Get the sunrise and sunset for the given coordinates for the current day





### Example 2: EXAMPLE 2

```
$address = '1600 Pennsylvania Avenue NW'
$addr = Invoke-RestMethod "https://nominatim.openstreetmap.org/search?q=$($address)&format=json" | Select-Object -First 1
Get-SunTime -Latitude $addr.lat -Longitude $addr.lon
```

# Use the free Nominatim API get the coordinates for an address, then use those results to get the sunrise and sunset for that location.






## PARAMETERS

### -Date

The day to find the sunrise and sunset for.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 0
Default value: $(Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Elevation

The Elevation in meters

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Latitude

The Latitude entered as a decimal number representing degrees and minutes

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (All) False (None)
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Longitude

The Longitude entered as a decimal number representing degrees and minutes

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (All) False (None)
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -ProgressAction

{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -TimeZone

The time zone for the final results

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 4
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## NOTES

Use can use Google Maps to find the latitude and longitude coordinates.

Right click a specific point on the Google map and you will see the latitude and longitude coordinates displayed, for example 45.51421, -122.68462.


## RELATED LINKS

Fill Related Links Here

