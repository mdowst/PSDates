---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-CronNextOccurrence

## SYNOPSIS

Get the next occurrence for a crontab

## SYNTAX

### __AllParameterSets

```
Get-CronNextOccurrence [-Crontab] <String> [[-StartTime <DateTime>]] [[-EndTime <DateTime>]] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

This function will either return the next occurrence, or if an end date is supplied, it will return
all the occurrences between the start and end date.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-CronNextOccurrence -Crontab '0 17 * * *'
```

Will return the next occurrence of the crontab from the current time





### Example 2: EXAMPLE 2

```
$Date = Get-Date '12/14/2032'
Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date
```

Will return the next occurrence of the crontab from the time provided





### Example 3: EXAMPLE 3

```
Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date -EndTime $Date.AddDays(3)
```

Will return the all occurrences of the crontab between the two times






## PARAMETERS

### -Crontab

A valid crontab string

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

### -EndTime

The datetime object to stop finding occurrences for from the StartTime

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 2
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

### -StartTime

The datetime object to find the next occurrence from.
Uses current time if not supplied.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 1
Default value: (Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### A datetime object for every occurrence returned


## NOTES



## RELATED LINKS

Fill Related Links Here

