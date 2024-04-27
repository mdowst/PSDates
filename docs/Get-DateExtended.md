---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-DateExtended

## SYNOPSIS

Gets additional extended date values that are not included by default with the Get-Date cmdlet

## SYNTAX

### __AllParameterSets

```
Get-DateExtended [[-Date <DateTime>]] [-Day <Int32>] [-DisplayHint <String>] [-Hour <Int32>] [-Millisecond <Int32>] [-Minute <Int32>] [-Month <Int32>] [-ProgressAction <ActionPreference>] [-Second <Int32>] [-UnixTimeSeconds] [-Year <Int32>] [<CommonParameters>]
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

Specifies the day of the month that is displayed.
Enter a value from 1 to 31.

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

Determines which elements of the date and time are displayed.

The accepted values are as follows:

   Date: displays only the date
   Time: displays only the time
   DateTime: displays the date and time

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

### -Hour

Specifies the hour that is displayed.
Enter a value from 0 to 23.

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

Specifies the milliseconds in the date.
Enter a value from 0 to 999.

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

Specifies the minute that is displayed.
Enter a value from 0 to 59.

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

Specifies the month that is displayed.
Enter a value from 1 to 12

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

### -Second

Specifies the second that is displayed.
Enter a value from 0 to 59.

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

### -UnixTimeSeconds

Date and time represented in seconds since January 1, 1970, 0:00:00.

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

### -Year

Specifies the year that is displayed.
Enter a value from 1 to 9999

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

