---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Convert-TimeZone

## SYNOPSIS

Convert a datetime value from one time zone to another

## SYNTAX

### Default

```
Convert-TimeZone -ToTimeZone <String> [-Date <DateTime>] [-FromTimeZone <String>] [<CommonParameters>]
```

## DESCRIPTION

This function will allows you to pass a date to convert from one time zone to another.
If no date is specified the local time is used.
If no FromTimeZone is passed then the
local time zone is used.
If you don't know the time zone ID you can use the Find-TimeZone cmdlet.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Convert-TimeZone -ToTimeZone "GMT Standard Time"
```

Convert the local system time to GMT Standard Time





### Example 2: EXAMPLE 2

```
Convert-TimeZone -date '11/17/2017 12:34 AM' -FromTimeZone "China Standard Time" -ToTimeZone "US Mountain Standard Time"
```

Converts the date and time 11/17/2017 12:34 AM from 'China Standard Time' to 'US Mountain Standard Time'






## PARAMETERS

### -Date

The date to convert.
If not specified the current time will be used

```yaml
Type: DateTime
Parameter Sets: Default
Aliases: 
Accepted values: 

Required: True (None) False (Default)
Position: Named
Default value: $(Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -FromTimeZone

The time zone ID of the time zone you want to convert the date from.
If not specified the local time zone will be used

```yaml
Type: String
Parameter Sets: Default
Aliases: 
Accepted values: 

Required: True (None) False (Default)
Position: Named
Default value: [System.TimeZoneInfo]::Local.Id.ToString()
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -ToTimeZone

The time zone ID of the time zone you want to convert the date to

```yaml
Type: String
Parameter Sets: Default
Aliases: 
Accepted values: 

Required: True (Default) False (None)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### A PSObject object containing the time zone conversion data


## NOTES



## RELATED LINKS

Fill Related Links Here

