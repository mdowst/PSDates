class TimeZoneConversion {
    [DateTime] $FromDateTime
    [String] $FromTimeZone
    [DateTime] $ToDateTime
    [String] $ToTimeZone
    [TimeSpan] $Offset

    TimeZoneConversion ($ToTimeZone, $Date, $FromTimeZone) {
        $DateTime = [DateTime]::SpecifyKind($Date, [DateTimeKind]::Unspecified)
        $from = [System.TimeZoneInfo]::FindSystemTimeZoneById($FromTimeZone)
        $to = [System.TimeZoneInfo]::FindSystemTimeZoneById($ToTimeZone)
        $utc = [System.TimeZoneInfo]::ConvertTimeToUtc($DateTime, $from)
        $newTime = [System.TimeZoneInfo]::ConvertTime($utc, $to)

        $this.FromDateTime = $Date
        $this.FromTimeZone = $FromTimeZone
        $this.ToDateTime = $newTime
        $this.ToTimeZone = $ToTimeZone
        $this.Offset = (New-TimeSpan -Start $date -End  $newTime)
    }
}