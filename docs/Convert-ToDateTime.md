---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Convert-ToDateTime

## SYNOPSIS

Converts various input objects to a DateTime object.

## SYNTAX

### __AllParameterSets

```
Convert-ToDateTime [-InputObject] <Object> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The `Convert-ToDateTime` function attempts to convert different types of input objects into a DateTime object.
It supports input from various data types such as strings and objects that can be cast or converted to a DateTime.


## EXAMPLES

### Example 1: EXAMPLE 1

```
'2024-08-29' | Convert-ToDateTime
```

Converts the string '2024-08-29' into a DateTime object representing the 29th of August, 2024.






## PARAMETERS

### -InputObject

Specifies the input object to be converted to a DateTime.
This parameter accepts pipeline input and is mandatory.

The input can be of any type:
- If the input is already a DateTime, it will be returned as-is.
- If the input is a string, it attempts to parse it into a DateTime.
- Other input types will be processed accordingly, if possible.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (All) False (None)
Position: 0
Default value: 
Accept pipeline input: True
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

## INPUTS

### System.Object
The function accepts objects from the pipeline, which are attempted to be converted to DateTime.


## OUTPUTS

### System.DateTime
The function outputs a DateTime object if the conversion is successful.


## NOTES



## RELATED LINKS

Fill Related Links Here

