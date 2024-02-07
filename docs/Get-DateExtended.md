---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-DateExtended

## SYNOPSIS

Gets common extended date values that are not included by default with the Get-Date cmdlet

## SYNTAX

### __AllParameterSets

```
Get-DateExtended [[-Date <DateTime>]] [-Day <Int32>] [-DisplayHint <String>] [-FromUnixTime] [-Hour <Int32>] [-Millisecond <Int32>] [-Minute <Int32>] [-Month <Int32>] [-Second <Int32>] [-Year <Int32>] [<CommonParameters>]
```

## DESCRIPTION

This function includes added values for:
 FirstDayOfYear : First day of the year
 LastDayOfYear  : Last day of the year
 StartOfWeek    : First day of the week
 EndOfWeek      : Last day of the week
 StartOfMonth   : First day of the month
 EndOfMonth     : Last day of the month
 TimeZone       : Current machine timezone
 Quater         : The quarter of the year.

All dates are based on the date passed.
If no date is passed in the current date and time are used.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Get-DateExtended
Gets extended date and time information based on the current time
```







### Example 2: EXAMPLE 2

```
Get-DateExtended "11/17/2017"
Gets extended date and time information for a specific date
```








## PARAMETERS

### -Date

The datetime value to return the information for

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: LastWriteTime
Accepted values: 

Required: True (None) False (All)
Position: 0
Default value: [DateTime]::Now
Accept pipeline input: True
Accept wildcard characters: False
DontShow: False
```

### -Day

{{ Fill Day Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -DisplayHint

{{ Fill DisplayHint Description }}

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

### -FromUnixTime

{{ Fill FromUnixTime Description }}

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

### -Hour

{{ Fill Hour Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Millisecond

{{ Fill Millisecond Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Minute

{{ Fill Minute Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Month

{{ Fill Month Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Second

{{ Fill Second Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Year

{{ Fill Year Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### A PSObject containing extended values for the date.


## NOTES



## RELATED LINKS

Fill Related Links Here

