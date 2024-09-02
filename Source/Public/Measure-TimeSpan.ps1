Function Measure-TimeSpan {
    <#
.SYNOPSIS
    Measures statistical properties (such as sum, average, and maximum) of a specified property within grouped time spans.

.DESCRIPTION
    The `Measure-TimeSpan` function calculates various statistical measures (sum, average, maximum, minimum) for a specified property across a collection of grouped time spans.
    It is designed to work with objects grouped by the `Group-TimeSpan` function, focusing on numerical properties for aggregation.

.PARAMETER TimeSpanGroupInfo
    Specifies the input objects that represent grouped time spans. This parameter accepts pipeline input and is mandatory.

.PARAMETER Property
    Specifies the property name of the TimeSpanGroupInfo objects to measure. This property should be numeric and is mandatory.

.PARAMETER Sum
    Switch parameter that, when specified, calculates the sum of the specified property across all input objects.

.PARAMETER Average
    Switch parameter that, when specified, calculates the average of the specified property across all input objects.

.PARAMETER Maximum
    Switch parameter that, when specified, calculates the maximum value of the specified property across all input objects.

.PARAMETER Minimum
    Switch parameter that, when specified, calculates the minimum value of the specified property across all input objects.

.EXAMPLE
    $groupedData = Get-EventLog -LogName System | Group-TimeSpan -Property TimeGenerated -Days 1
    $groupedData | Measure-TimeSpan -Property Count -Sum

    Measures the sum of the 'Count' property for each grouped time span in the system event log.

.EXAMPLE
    $groupedData = Get-ChildItem $PSHOME | Group-TimeSpan -Property CreationTime -Hours 1
    $groupedData | Measure-TimeSpan -Property Length -Average -Sum

    Measures the sum and average size of files grouped by each hour based on their CreationTime.

.INPUTS
    TimeSpanGroupInfo[]
    The function accepts grouped time span objects from the pipeline.

.OUTPUTS
    TimeSpanMeasureInfo[]
    Returns the calculated statistical value(s) based on the input and specified parameters.
#>

    [CmdletBinding()]
    [OutputType([TimeSpanMeasureInfo[]])]
    param (
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true
        )]
        [TimeSpanGroupInfo[]]$TimeSpanGroupInfo,

        [Parameter(Mandatory = $true)]
        [string]$Property,

        [Parameter(Mandatory = $false)]
        [switch]$Sum = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Average = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Maximum = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Minimum = $false
    )

    begin {
        [Collections.Generic.List[TimeSpanMeasureInfo]] $objects = @()
        $MeasureParameters = @{}
        $PSBoundParameters.GetEnumerator() | Where-Object { $_.Key -ne 'TimeSpanGroupInfo' } | ForEach-Object {
            $MeasureParameters.Add($_.Key, $_.Value)
        }
    }

    process {
        $TimeSpanGroupInfo | Foreach-Object { 
            $m = $_.Group | Measure-Object @MeasureParameters
            if($m){
                $objects.Add([TimeSpanMeasureInfo]::new($_.DateTime, $m))
            }
            else{
                $blankFill = [TimeSpanMeasureInfo]::new($_.DateTime, $Property, $_.Count)
                if($Average){$blankFill.Average = 0}
                if($Sum){$blankFill.Sum = 0}
                if($Maximum){$blankFill.Maximum = 0}
                if($Minimum){$blankFill.Minimum = 0}
                $objects.Add($blankFill)
            }

             
        }
    }

    end {
        $objects
    }
}