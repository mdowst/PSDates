Function Get-Holiday{
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true)]    
        [string]$Country,
        [Parameter(Mandatory = $false)]    
        [string]$Name,
        [Parameter(Mandatory = $false)]    
        [string]$Type
    )

    $holidays = $script:HolidayResources | Where-Object{ $_.CountryCode -eq $Country }
    foreach($h in $holidays.Holidays){
        $holidayParams = @{}
        $h.GetEnumerator() | Where-Object{ $_.Key -in 'Month','Day','WeekOccurance','DayOfWeek','OffsetDays' -and $_.Value} | ForEach-Object{
            $holidayParams.Add($_.Key, $_.Value)
        }
        Get-AnnualHoliday @holidayParams
    }
}