Function Group-TimeSpan {
    <#
.SYNOPSIS
Groups objects by a specified time span.

.DESCRIPTION
The `Group-TimeSpan` function takes a collection of objects and groups them based on a specified time span.
It supports grouping by properties such as days, hours, minutes, etc., allowing for flexible data grouping.

.PARAMETER InputObject
Specifies the input objects to be grouped. This parameter accepts pipeline input.

.PARAMETER Property
Specifies the property name of the InputObject to use for grouping. The property should be of a DateTime type.

.PARAMETER Years
Specifies the number of years to group by.

.PARAMETER Months
Specifies the number of months to group by.

.PARAMETER Days
Specifies the number of days to group by.

.PARAMETER Hours
Specifies the number of hours to group by.

.PARAMETER Minutes
Specifies the number of minutes to group by.

.PARAMETER Seconds
Specifies the number of seconds to group by.

.PARAMETER Round
Specifies to round the date to the top of the day, hour, or minute. Only used with Days, Hours, Minutes, and Seconds parameters

.EXAMPLE
Get-ChildItem $PSHOME | Group-TimeSpan -Property CreationTime -Hours 1

Groups the files by each hour based on their CreationTime.

.EXAMPLE
Get-ChildItem $PSHOME | Group-TimeSpan -Property CreationTime -Hours 1 -Round

Groups the files by each hour based on their CreationTime and rounds to the top of the hour.

.OUTPUTS
GroupTimeSpan[]
Returns an array of GroupTimeSpan objects.
#>
    [CmdletBinding()]
    [OutputType([GroupTimeSpan[]])]
    param (
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Mandatory = $true
        )]
        [Alias("PSObject")]
        [object]$InputObject,

        [Parameter(Mandatory = $false)]
        [string]$Property,

        [Parameter(Mandatory = $false, ParameterSetName = "Days")]
        [Parameter(Mandatory = $false, ParameterSetName = "Hours")]
        [Parameter(Mandatory = $false, ParameterSetName = "Minutes")]
        [Parameter(Mandatory = $false, ParameterSetName = "Seconds")]
        [switch]$Round = $false,

        [Parameter(Mandatory = $true, ParameterSetName = "Years")]
        [int]$Years,
        [Parameter(Mandatory = $true, ParameterSetName = "Months")]
        [int]$Months,
        [Parameter(Mandatory = $true, ParameterSetName = "Days")]
        [int]$Days,
        [Parameter(Mandatory = $true, ParameterSetName = "Hours")]
        [int]$Hours,
        [Parameter(Mandatory = $true, ParameterSetName = "Minutes")]
        [int]$Minutes,
        [Parameter(Mandatory = $true, ParameterSetName = "Seconds")]
        [int]$Seconds
    )

    begin {
        [Collections.Generic.List[PSObject]] $objects = @()
        switch($PsCmdlet.ParameterSetName){
            "Days" { $ticks = 36000000000 * 24 * $Days }
            "Hours" { $ticks = 36000000000 * $Hours }
            "Minutes" { $ticks = 600000000 * $Minutes }
            "Seconds" { $ticks = 10000000 * $Seconds }
        }
    }


    process {
        $InputObject | Foreach-Object { 
            if($PSBoundParameters['Property']){
                $timeValue = $_.$Property
            }
            else{
                $timeValue = $_
            }
            $objects.Add([pscustomobject]@{
                TimeProperty = $timeValue | Convert-ToDateTime
                Object = $_
            })
        }
    }


    end {
        if($PSBoundParameters['Months'] -or $PSBoundParameters['Years']){
            $min = $objects | Sort-Object TimeProperty | Select-Object -First 1 -ExpandProperty TimeProperty
        }
        elseif(-not $Round){
            $max = $objects | Sort-Object TimeProperty | Select-Object -Last 1 -ExpandProperty TimeProperty
        }
        $groupedDates = $objects | Group-Object {
            if($PSBoundParameters['Months']){
                # Monthly
                $monthsDifference = (($_.TimeProperty.Year - $min.Year) * 12 + $_.TimeProperty.Month - $min.Month)
                $groupStartMonth = [math]::Floor($monthsDifference / $PSBoundParameters['Months']) * $PSBoundParameters['Months']
                $month = $min.AddMonths($groupStartMonth)
                (Get-Date -Year $month.Year -Month $month.Month -day 1 -hour 0 -minute 0 -second 0 -Millisecond 0).Ticks
            }
            elseif($PSBoundParameters['Years']){
                # Yearly
                $yearDifference = $_.TimeProperty.Year - $min.Year
                $groupStartYear = [math]::Floor($yearDifference / $PSBoundParameters['Years']) * $PSBoundParameters['Years']
                $year = $min.AddMonths($groupStartYear * 12)
                (Get-Date -Year $year.Year -Month 1 -day 1 -hour 0 -minute 0 -second 0 -Millisecond 0).Ticks
            }
            elseif($Round){
                # Rounded
                $_.TimeProperty.Ticks - ($_.TimeProperty.Ticks % $ticks)
            }
            else{
                # Not Rounded
                $max.Ticks - (($max.Ticks - $_.TimeProperty.Ticks) - (($max.Ticks - $_.TimeProperty.Ticks) % $ticks))
            }
        }

        [GroupTimeSpan[]]$output = $groupedDates | Sort-Object Name | ForEach-Object{
            [GroupTimeSpan]::new($_)
        }
        $output
    }
}