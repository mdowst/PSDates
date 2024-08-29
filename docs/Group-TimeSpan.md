---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Group-TimeSpan

## SYNOPSIS

Groups objects by a specified time span.

## SYNTAX

### Seconds

```
Group-TimeSpan -InputObject <Object> -Seconds <Int32> [-ProgressAction <ActionPreference>] [-Property <String>] [-Round] [<CommonParameters>]
```

### Minutes

```
Group-TimeSpan -InputObject <Object> -Minutes <Int32> [-ProgressAction <ActionPreference>] [-Property <String>] [-Round] [<CommonParameters>]
```

### Hours

```
Group-TimeSpan -Hours <Int32> -InputObject <Object> [-ProgressAction <ActionPreference>] [-Property <String>] [-Round] [<CommonParameters>]
```

### Days

```
Group-TimeSpan -Days <Int32> -InputObject <Object> [-ProgressAction <ActionPreference>] [-Property <String>] [-Round] [<CommonParameters>]
```

### Years

```
Group-TimeSpan -InputObject <Object> -Years <Int32> [-ProgressAction <ActionPreference>] [-Property <String>] [<CommonParameters>]
```

### Months

```
Group-TimeSpan -InputObject <Object> -Months <Int32> [-ProgressAction <ActionPreference>] [-Property <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Group-TimeSpan` function takes a collection of objects and groups them based on a specified time span.
It supports grouping by properties such as days, hours, minutes, etc., allowing for flexible data grouping.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-ChildItem $PSHOME | Group-TimeSpan -Property CreationTime -Hours 1
```

Groups the files by each hour based on their CreationTime.





### Example 2: EXAMPLE 2

```
Get-ChildItem $PSHOME | Group-TimeSpan -Property CreationTime -Hours 1 -Round
```

Groups the files by each hour based on their CreationTime and rounds to the top of the hour.






## PARAMETERS

### -Days

Specifies the number of days to group by.

```yaml
Type: Int32
Parameter Sets: Days
Aliases: 
Accepted values: 

Required: True (Days) False (None)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Hours

Specifies the number of hours to group by.

```yaml
Type: Int32
Parameter Sets: Hours
Aliases: 
Accepted values: 

Required: True (Hours) False (None)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -InputObject

Specifies the input objects to be grouped.
This parameter accepts pipeline input.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: PSObject
Accepted values: 

Required: True (All) False (None)
Position: Named
Default value: 
Accept pipeline input: True
Accept wildcard characters: False
DontShow: False
```

### -Minutes

Specifies the number of minutes to group by.

```yaml
Type: Int32
Parameter Sets: Minutes
Aliases: 
Accepted values: 

Required: True (Minutes) False (None)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Months

Specifies the number of months to group by.

```yaml
Type: Int32
Parameter Sets: Months
Aliases: 
Accepted values: 

Required: True (Months) False (None)
Position: Named
Default value: 0
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

Specifies the property name of the InputObject to use for grouping.
The property should be of a DateTime type.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Round

Specifies to round the date to the top of the day, hour, or minute.
Only used with Days, Hours, Minutes, and Seconds parameters

```yaml
Type: SwitchParameter
Parameter Sets: Seconds, Minutes, Hours, Days
Aliases: 
Accepted values: 

Required: True (None) False (Seconds, Minutes, Hours, Days)
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Seconds

Specifies the number of seconds to group by.

```yaml
Type: Int32
Parameter Sets: Seconds
Aliases: 
Accepted values: 

Required: True (Seconds) False (None)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Years

Specifies the number of years to group by.

```yaml
Type: Int32
Parameter Sets: Years
Aliases: 
Accepted values: 

Required: True (Years) False (None)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### GroupTimeSpan[]
Returns an array of GroupTimeSpan objects.


## NOTES



## RELATED LINKS

Fill Related Links Here

