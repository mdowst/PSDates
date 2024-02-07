---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# New-Duration

## SYNOPSIS

Calculates the time span between two dates and returns the duration in the ISO 8601 format

## SYNTAX

### datetime

```
New-Duration -End <DateTime> -Start <DateTime> [<CommonParameters>]
```

### numbers

```
New-Duration [-Days <Int32>] [-Hours <Int32>] [-Minutes <Int32>] [-Months <Int32>] [-Seconds <Int32>] [-Years <Int32>] [<CommonParameters>]
```

### week

```
New-Duration [-Weeks <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Calculates the timespan between two dates and returns the duration in the ISO 8601 format

https://en.wikipedia.org/wiki/ISO_8601#Durations


## EXAMPLES

### Example 1: EXAMPLE 1

```
New-Duration -Start '2/3/2023' -End (Get-Date)
```







### Example 2: EXAMPLE 2

```
New-Duration -Days 1 -Hours 4
```







### Example 3: EXAMPLE 3

```
New-Duration -Weeks 3
```








## PARAMETERS

### -Days

{{ Fill Days Description }}

```yaml
Type: Int32
Parameter Sets: numbers
Aliases: 
Accepted values: 

Required: True (None) False (numbers)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -End

Specifies the end of a time span.
End date must be greater than the start date

```yaml
Type: DateTime
Parameter Sets: datetime
Aliases: 
Accepted values: 

Required: True (datetime) False (None)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Hours

{{ Fill Hours Description }}

```yaml
Type: Int32
Parameter Sets: numbers
Aliases: 
Accepted values: 

Required: True (None) False (numbers)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Minutes

{{ Fill Minutes Description }}

```yaml
Type: Int32
Parameter Sets: numbers
Aliases: 
Accepted values: 

Required: True (None) False (numbers)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Months

{{ Fill Months Description }}

```yaml
Type: Int32
Parameter Sets: numbers
Aliases: 
Accepted values: 

Required: True (None) False (numbers)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Seconds

{{ Fill Seconds Description }}

```yaml
Type: Int32
Parameter Sets: numbers
Aliases: 
Accepted values: 

Required: True (None) False (numbers)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Start

Specifies the start of a time span.

```yaml
Type: DateTime
Parameter Sets: datetime
Aliases: 
Accepted values: 

Required: True (datetime) False (None)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Weeks

{{ Fill Weeks Description }}

```yaml
Type: Int32
Parameter Sets: week
Aliases: 
Accepted values: 

Required: True (None) False (week)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Years

{{ Fill Years Description }}

```yaml
Type: Int32
Parameter Sets: numbers
Aliases: 
Accepted values: 

Required: True (None) False (numbers)
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### System.String


## NOTES



## RELATED LINKS

Fill Related Links Here

