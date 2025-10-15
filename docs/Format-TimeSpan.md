---
external help file: PSDates-help.xml
Module Name: PSDates
online version: 
schema: 2.0.0
---

# Format-TimeSpan

## SYNOPSIS

Formats TimeSpan objects into human-readable, localized text.

## SYNTAX

### __AllParameterSets

```
Format-TimeSpan [-TimeSpan] <TimeSpan> [[-Culture <CultureInfo>]] [-IncludeZeros] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

The `Format-TimeSpan` cmdlet formats a .NET `TimeSpan` object into a human-readable string representation. It allows you to customize the output based on culture settings, optionally include zero-value time components, and control progress reporting. This cmdlet is useful for displaying durations in scripts, logs, or user interfaces in a clear and localized format. You can specify the culture for formatting, choose whether to display components with zero values (such as hours or minutes), and adjust progress action preferences. The cmdlet accepts a `TimeSpan` object as input and outputs a formatted string suitable for display or further processing.

## EXAMPLES

### Example 1: Example 1

```
PS C:\> Format-TimeSpan -TimeSpan (New-TimeSpan -Hours 2 -Minutes 30 -Seconds 15) -IncludeZeros
2 hours, 30 minutes, 15 seconds

This example formats a TimeSpan of 2 hours, 30 minutes, and 15 seconds, including zero-value components in the output.

## PARAMETERS

### -Culture

{{ Fill Culture Description }}

```yaml
Type: CultureInfo
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

### -IncludeZeros

{{ Fill IncludeZeros Description }}

```yaml
Type: SwitchParameter
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

### -TimeSpan

{{ Fill TimeSpan Description }}

```yaml
Type: TimeSpan
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


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None



## OUTPUTS

### System.Object



## NOTES

{{ Fill in the Notes }}

## RELATED LINKS

Fill Related Links Here

