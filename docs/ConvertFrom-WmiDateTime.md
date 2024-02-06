---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# ConvertFrom-WmiDateTime

## SYNOPSIS

Converts a Wmi Time value to a datetime value

## SYNTAX

### __AllParameterSets

```
ConvertFrom-WmiDateTime [-WmiTime] <String> [<CommonParameters>]
```

## DESCRIPTION

This function will return the datetime based on a WMI datetime string.


## EXAMPLES

### Example 1: EXAMPLE 1

```
ConvertFrom-WmiDateTime -WmiTime '20190912173652.000000-300'
Gets datetime for the Wmi time 20190912173652.000000-300
```








## PARAMETERS

### -WmiTime

The WmiTime value to return the datetime for

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

### The datetime value based on the wmi time


## NOTES



## RELATED LINKS

Fill Related Links Here

