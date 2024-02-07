---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Test-CrontabSchedule

## SYNOPSIS

Tests that a crontab string is valid

## SYNTAX

### __AllParameterSets

```
Test-CrontabSchedule [-Crontab] <String> [<CommonParameters>]
```

## DESCRIPTION

This function attempts to parse a crontab string to ensure it is valid.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Test-CrontabSchedule -crontab '0 17 * * *'
```

Valid schedule that returns:
 Crontab     Valid
 -------     -----
 0 17 * * *   True





### Example 2: EXAMPLE 2

```
Test-CrontabSchedule -crontab '0 17 * 13 *'
```

Invalid schedule that returns:
Crontab     Valid ErrorMsg
-------     ----- --------
0 17 * 13 * False 13 is higher than the maximum allowable value for the [Month] field.
Value must be between 1 and 12 (all inclusive).






## PARAMETERS

### -Crontab

The datetime value to return the second Tuesday for the month

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (All) False (None)
Position: 0
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### A psobject that contains the crontable, a validation value, and any error messages returned


## NOTES



## RELATED LINKS

Fill Related Links Here

