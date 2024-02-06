---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-PatchTuesday

## SYNOPSIS

Returns the second Tuesday of the month

## SYNTAX

### Date (Default)

```
Get-PatchTuesday [-Date <DateTime>] [<CommonParameters>]
```

### MonthYear

```
Get-PatchTuesday [-Month <Int32>] [-Year <Int32>] [<CommonParameters>]
```

## DESCRIPTION

This function allow you to pass a date, or a month/year combination to find the second Tuesday (aka Patch Tuesday) of any month


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-PatchTuesday
Returns the second Tuesday for the current month
```







### Example 2: EXAMPLE 2

```
Get-PatchTuesday -Date "11/17/2021"
Returns the second Tuesday for November 2021
```







### Example 3: EXAMPLE 3

```
Get-PatchTuesday -Month 6 -Year 2020
Returns the second Tuesday for June 2020
```







### Example 4: EXAMPLE 4

```
Get-PatchTuesday -Month 4
Returns the second Tuesday for April of the current year
```








## PARAMETERS

### -Date

The datetime value to return the second Tuesday for the month

```yaml
Type: DateTime
Parameter Sets: Date
Aliases: 
Accepted values: 

Required: True (None) False (Date)
Position: Named
Default value: $(Get-Date)
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Month

The month to return the second Tuesday for.
Enter a value from 1 to 12.

```yaml
Type: Int32
Parameter Sets: MonthYear
Aliases: 
Accepted values: 

Required: True (None) False (MonthYear)
Position: Named
Default value: $(Get-Date).Month
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Year

The year to return the second Tuesday for.
Enter a value from 1 to 9999

```yaml
Type: Int32
Parameter Sets: MonthYear
Aliases: 
Accepted values: 

Required: True (None) False (MonthYear)
Position: Named
Default value: $(Get-Date).Year
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### A datetime object of the second Tuesday.


## NOTES



## RELATED LINKS

Fill Related Links Here

