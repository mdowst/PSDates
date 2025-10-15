---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Test-FridayThe13th

## SYNOPSIS

Checks if a date is Friday the 13th; if not, returns the next occurrence and the time remaining.

## SYNTAX

### __AllParameterSets

```
Test-FridayThe13th [[-Date <DateTime>]] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Given a date (default: now), determines whether it falls on a Friday the 13th.
If not, it calculates the next Friday the 13th and the TimeSpan until that date
(using the same time-of-day as the input).


## EXAMPLES

### Example 1: EXAMPLE 1

```
Test-FridayThe13th
```







### Example 2: EXAMPLE 2

```
Test-FridayThe13th -Date '2025-01-10'
# -> Not Friday the 13th; next is 2025-06-13, in 154 days 12:34:56
```








## PARAMETERS

### -Date

The reference date/time.
Defaults to (Get-Date).

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

### PSCustomObject (TypeName: PSDates.FridayThe13thResult)
- IsFridayThe13th : [bool]
- Date            : [datetime]  # the evaluated date
- NextOccurrence  : [datetime]  # next Friday the 13th (null if already F13)
- TimeUntilNext   : [TimeSpan]  # time until next occurrence (00:00:00 if already F13)
- Message         : [string]


## NOTES



## RELATED LINKS

Fill Related Links Here

