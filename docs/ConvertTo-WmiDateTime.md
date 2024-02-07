---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# ConvertTo-WmiDateTime

## SYNOPSIS

Converts a datetime value to a Wmi datetime string

## SYNTAX

### __AllParameterSets

```
ConvertTo-WmiDateTime [[-Date <DateTime>]] [<CommonParameters>]
```

## DESCRIPTION

This function will return the WMI datetime string based on a datetime passed.


## EXAMPLES

### Example 1: EXAMPLE 1

```
ConvertTo-WmiDateTime -Date '06/25/2019 16:17'
```

Return the WMI datetime string for the datetime of "06/25/2019 16:17"






## PARAMETERS

### -Date

{{ Fill Date Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 0
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### The string value based on the datetime


## NOTES



## RELATED LINKS

Fill Related Links Here

