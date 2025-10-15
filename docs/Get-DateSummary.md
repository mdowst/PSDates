---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Get-DateSummary

## SYNOPSIS

Summarizes a sequence of timestamps (earliest, latest, total span) and gap statistics.

## SYNTAX

### __AllParameterSets

```
Get-DateSummary [[-InputObject <Object>]] [[-TimeProperty <String>]] [[-RoundTo <String>]] [-AsUtc] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Get-DateSummary takes a stream (or array) of timestamps and returns a single summary object
that includes:
- Count of non-null timestamps
- Earliest and latest timestamps
- Total span (Latest - Earliest)
- Gap statistics between consecutive timestamps (Average, Median, Min, Max)

Input can be DateTime values directly, strings that cast to DateTime, or arbitrary objects
when -TimeProperty is specified.
Use -AsUtc to normalize all timestamps to UTC before analysis.


## EXAMPLES

### Example 1: EXAMPLE 1

```
# Direct DateTime input
1..5 | ForEach-Object { (Get-Date).AddMinutes($_ * 10) } | Get-DateSummary
```







### Example 2: EXAMPLE 2

```
# Objects with a Time property
$events | Get-DateSummary -TimeProperty Time
```







### Example 3: EXAMPLE 3

```
# Normalize to UTC and round to the nearest minute
$events | Get-DateSummary -TimeProperty Timestamp -AsUtc -RoundTo Minute
```








## PARAMETERS

### -AsUtc

Normalize all timestamps to UTC prior to analysis (uses .ToUniversalTime()).

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

### -InputObject

Objects flowing in the pipeline.
These can be DateTime, string (parsable to DateTime),
or any object if -TimeProperty is used.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
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

### -RoundTo

Optionally round timestamps prior to analysis.
Useful for noisy data.
Valid values: Second, Minute, Hour, Day.

```yaml
Type: String
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

### -TimeProperty

Name of the property on each input object that contains the timestamp.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: 

Required: True (None) False (All)
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### PSCustomObject (TypeName: PSDates.DateSummary)
Properties:
- Count, NullsSkipped, Earliest, Latest, Span
- AverageGap, MedianGap, MinGap, MaxGap
- UniqueDays


## NOTES

If fewer than 2 timestamps are provided, gap metrics are set to [TimeSpan]::Zero.
Null or unparsable values are skipped and counted in NullsSkipped.


## RELATED LINKS

Fill Related Links Here

