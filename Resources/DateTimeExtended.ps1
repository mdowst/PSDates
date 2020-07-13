class DateTimeExtended {
    [datetime]$DateTime
    [datetime]$FirstDayOfYear
    [datetime]$LastDayOfYear
    [datetime]$StartOfWeek
    [datetime]$EndOfWeek
    [datetime]$StartOfMonth
    [datetime]$EndOfMonth
    [string]$WeekOfYear
    [System.TimeZoneInfo]$TimeZone
    [int]$Quater
    [datetime]$Date
    [int]$Day
    [System.DayOfWeek]$DayOfWeek
    [int]$DayOfYear
    [int]$Hour
    [System.DateTimeKind]$Kind
    [int]$Millisecond
    [int]$Minute
    [int]$Month
    [int]$Second
    [long]$Ticks
    [timespan]$TimeOfDay
    [int]$Year

    DateTimeExtended(
        [DateTime]$Date
    ) {
        $local:StartOfWeek = Get-Date $date -hour 0 -minute 0 -second 0
        $local:EndOfWeek = Get-Date $date -hour 23 -minute 59 -second 59
        $local:StartOfMonth = Get-Date $date -day 1 -hour 0 -minute 0 -second 0

        $this.DateTime = $Date
        $this.FirstDayOfYear = (Get-Date $date -hour 0 -minute 0 -second 0 -Day 1 -Month 1) 
        $this.LastDayOfYear = (Get-Date $date -hour 0 -minute 0 -second 0 -Day 31 -Month 12)
        $this.StartOfWeek = ($StartOfWeek.AddDays( - ($StartOfWeek).DayOfWeek.value__))
        $this.EndOfWeek = ($EndOfWeek.AddDays(6 - ($StartOfWeek).DayOfWeek.value__))
        $this.StartOfMonth = ($StartOfMonth)
        $this.EndOfMonth = ((($StartOfMonth).AddMonths(1).AddSeconds(-1)))
        $this.WeekOfYear = (Get-Date $date -uformat %V)
        $this.TimeZone = ([System.TimeZoneInfo]::Local)
        $this.Quater = [Math]::ceiling($Date.Month / 3)
        $this.Date = $Date.Date
        $this.Day = $Date.Day
        $this.DayOfWeek = $Date.DayOfWeek
        $this.DayOfYear = $Date.DayOfYear
        $this.Hour = $Date.Hour
        $this.Kind = $Date.Kind
        $this.Millisecond = $Date.Millisecond
        $this.Minute = $Date.Minute
        $this.Month = $Date.Month
        $this.Second = $Date.Second
        $this.Ticks = $Date.Ticks
        $this.TimeOfDay = $Date.TimeOfDay
        $this.Year = $Date.Year
    }

    # wrapper for the different datetime methods
    # had to be don this way since the datetime struct is sealed
    [DateTimeExtended] Add([timespan] $value) {
        Return [DateTimeExtended]::New($this.DateTime.Add($value))
    }

    [DateTimeExtended] AddDays([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddDays($value))
    }

    [DateTimeExtended] AddHours([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddHours($value))
    }

    [DateTimeExtended] AddMilliseconds([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddMilliseconds($value))
    }

    [DateTimeExtended] AddMinutes([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddMinutes($value))
    }

    [DateTimeExtended] AddMonths([int] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddMonths($value))
    }

    [DateTimeExtended] AddSeconds([double] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddSeconds($value))
    }

    [DateTimeExtended] AddTicks([long] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddTicks($value))
    }

    [DateTimeExtended] AddYears([int] $value) {
        Return [DateTimeExtended]::New($this.DateTime.AddYears($value))
    }

    [DateTimeExtended] ToLocalTime() {
        Return [DateTimeExtended]::New($this.DateTime.ToLocalTime())
    }

    [DateTimeExtended] ToUniversalTime() {
        Return [DateTimeExtended]::New($this.DateTime.ToUniversalTime())
    }
}