---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-DateFormat

## SYNOPSIS

Returns common date and time formats

## SYNTAX

### Full (Default)

```
Get-DateFormat [-Date <DateTime>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Format

```
Get-DateFormat [-Date <DateTime>] [-Format <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This function format date and time values into multiple different common formats.
All dates are based on the date passed.
If no date is passed in the current date and time are used.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-DateFormats
```

Gets formatted date and time information based on the current time





### Example 2: EXAMPLE 2

```
Get-DateFormats -Date "11/17/2017"
```

Gets formatted date and time information for a specific date






## PARAMETERS

### -Date

The datetime value to return the formats for

```yaml
Type: DateTime
Parameter Sets: Format, Full
Aliases: 
Accepted values: 

Required: True (None) False (Format, Full)
Position: Named
Default value: $(Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Format

{{ Fill Format Description }}

```yaml
Type: String
Parameter Sets: Format
Aliases: 
Accepted values: 

Required: True (None) False (Format)
Position: Named
Default value: 
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

### A PSObject containing the diffent values for the datetime formats.


## NOTES



## RELATED LINKS

Fill Related Links Here

