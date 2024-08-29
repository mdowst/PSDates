---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Measure-TimeSpan

## SYNOPSIS

Measures statistical properties (such as sum, average, and maximum) of a specified property within grouped time spans.

## SYNTAX

### __AllParameterSets

```
Measure-TimeSpan [-GroupTimeSpan] <GroupTimeSpan[]> [-Property] <String> [-Average] [-Maximum] [-Minimum] [-ProgressAction <ActionPreference>] [-Sum] [<CommonParameters>]
```

## DESCRIPTION

The `Measure-TimeSpan` function calculates various statistical measures (sum, average, maximum, minimum) for a specified property across a collection of grouped time spans.
It is designed to work with objects grouped by the `Group-TimeSpan` function, focusing on numerical properties for aggregation.


## EXAMPLES

### Example 1: EXAMPLE 1

```
$groupedData = Get-EventLog -LogName System | Group-TimeSpan -Property TimeGenerated -Days 1
$groupedData | Measure-TimeSpan -Property Count -Sum
```

Measures the sum of the 'Count' property for each grouped time span in the system event log.





### Example 2: EXAMPLE 2

```
$groupedData = Get-ChildItem $PSHOME | Group-TimeSpan -Property CreationTime -Hours 1
$groupedData | Measure-TimeSpan -Property Length -Average -Sum
```

Measures the sum and average size of files grouped by each hour based on their CreationTime.






## PARAMETERS

### -Average

Switch parameter that, when specified, calculates the average of the specified property across all input objects.

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

### -GroupTimeSpan

Specifies the input objects that represent grouped time spans.
This parameter accepts pipeline input and is mandatory.

```yaml
Type: GroupTimeSpan[]
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

### -Maximum

Switch parameter that, when specified, calculates the maximum value of the specified property across all input objects.

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

### -Minimum

Switch parameter that, when specified, calculates the minimum value of the specified property across all input objects.

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

### -Property

Specifies the property name of the GroupTimeSpan objects to measure.
This property should be numeric and is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (All) False (None)
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Sum

Switch parameter that, when specified, calculates the sum of the specified property across all input objects.

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


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### GroupTimeSpan[]
The function accepts grouped time span objects from the pipeline.


## OUTPUTS

### TimeSpanMeasureInfo[]
Returns the calculated statistical value(s) based on the input and specified parameters.


## NOTES



## RELATED LINKS

Fill Related Links Here

