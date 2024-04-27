---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-Easter

## SYNOPSIS

This function offers a generic Easter computing method for any given year, using Western, Orthodox or Julian algorithms.

## SYNTAX

### __AllParameterSets

```
Get-Easter [[-year <Int32>]] [[-Calendar <String>]] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Shamelessly stolen from python dateutil (https://github.com/dateutil/dateutil/blob/master/src/dateutil/easter.py)


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-Easter -Year 2024
```








## PARAMETERS

### -Calendar

Gregorian : is the default and valid from 1583 to 4099
Orthodox :  valid from 1583 to 4099
Julian : valid from 326

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 1
Default value: Gregorian
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

### -year

The year to get Easter from

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 0
Default value: (Get-Date).Year
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### System.DateTime


## NOTES



## RELATED LINKS

Fill Related Links Here

