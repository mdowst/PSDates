---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Find-TimeZone

## SYNOPSIS

Returns Time Zone information

## SYNTAX

### __AllParameterSets

```
Find-TimeZone [[-Name <String>]] [[-Offset <Int32>]] [-Local] [-OutGrid] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This function will return the information for the system time zones.
You can search by name and/or hour offsets.
You can also return the local time zone.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Find-TimeZone -local
Return the time zone of the local system
```







### Example 2: EXAMPLE 2

```
Find-TimeZone -Name "GMT"
Search for time zones with 'GMT' in the name
```







### Example 3: EXAMPLE 3

```
Find-TimeZone -Name "central" -Offset -6
Search for time zones with 'Central' in the name and have a UTC offset of -6 hours
```








## PARAMETERS

### -Local

Use to return the time zone of the current system

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Name

All or part of the time zone name.
Will be used to perform a wildcard search on the time zones

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 0
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Offset

The number of hours the time zone is offset from UTC

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -OutGrid

Use to output time zone selects to Grid View

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: False
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


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### The TimeZoneInfo value or values found


## NOTES



## RELATED LINKS

Fill Related Links Here

