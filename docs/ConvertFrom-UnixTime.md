---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# ConvertFrom-UnixTime

## SYNOPSIS

Converts a Unix Time value to a datetime value

## SYNTAX

### __AllParameterSets

```
ConvertFrom-UnixTime [-UnixTime] <Double> [<CommonParameters>]
```

## DESCRIPTION

This function will return the datetime based on the unix epoch time.


## EXAMPLES

### Example 1: EXAMPLE 1

```
ConvertFrom-UnixTime -UnixTime 1509512400
Gets datetime for the Unix time 1509512400
```








## PARAMETERS

### -UnixTime

The UnixTime value to return the datetime for

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (All) False (None)
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### The datetime value based on the unix time


## NOTES



## RELATED LINKS

Fill Related Links Here

