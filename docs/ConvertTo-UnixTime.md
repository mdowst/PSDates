---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# ConvertTo-UnixTime

## SYNOPSIS

Converts a datetime value to Unix Time

## SYNTAX

### __AllParameterSets

```
ConvertTo-UnixTime [[-date <DateTime>]] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This function will return the unix time based on the unix epoch time.
If no date is passed in the current date and time is used.


## EXAMPLES

### Example 1: EXAMPLE 1

```
ConvertTo-UnixTime
Gets unix time for the current time
```







### Example 2: EXAMPLE 2

```
ConvertTo-UnixTime -date "11/17/2017"
Gets unix time for a specific date
```








## PARAMETERS

### -date

The datetime value to return the unix time for

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

### The int32 value of the unix time


## NOTES



## RELATED LINKS

Fill Related Links Here

