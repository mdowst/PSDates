---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-CronDescription

## SYNOPSIS

Convert a cron expression into a human readable description

## SYNTAX

### __AllParameterSets

```
Get-CronDescription [-Crontab] <String> [[-Locale <String>]] [-DayOfWeekStartIndexOne] [-ProgressAction <ActionPreference>] [-Use24HourTimeFormat] [<CommonParameters>]
```

## DESCRIPTION

Uses the .NET library CronExpressionDescriptor to convert cron expressions into human readable descriptions.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-CronDescription -Crontab '0 17 * * 1'
```

Results with default options:
At 05:00 PM, only on Monday





### Example 2: EXAMPLE 2

```
Get-CronDescription -Crontab '0 17 * * 1' -DayOfWeekStartIndexOne
```

Results with DayOfWeekStartIndexOne switch returns Sunday for the 1 instead of Monday:
At 05:00 PM, only on Sunday





### Example 3: EXAMPLE 3

```
Get-CronDescription -Crontab '0 17 * * 1' -Use24HourTimeFormat
```

Results with Use24HourTimeFormat options:
At 17:00, only on Monday





### Example 4: EXAMPLE 4

```
Get-CronDescription -Crontab '0 17 * * 1' -Locale 'fr'
```

Results with fr Locale options:
At 05:00 PM, only on lundi






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

### -DayOfWeekStartIndexOne

When used Sunday will equal 1, otherwise Sunday will be 0.
(Default: Sunday = 0)

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

### -Locale

The locale to use (Default: "en")
Supported values: cs-CZ, da, de, es, es-MX, fa, fi, fr, he-IL, hu, it, ja, ko, nb, nl, pl, pt, ro, ru, sl, sv, tr, uk, vi, zh-Hans, zh-Hant

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 1
Default value: en
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

### -Use24HourTimeFormat

If true, descriptions will use a 24-hour clock (Default: false but some translations will default to true)

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

## OUTPUTS

### A psobject that contains the crontable, a validation value, and any error messages returned


## NOTES



## RELATED LINKS

Fill Related Links Here

