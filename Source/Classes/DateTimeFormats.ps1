class DateTimeFormats {
    [string]   $24HourTime
    [datetime] $DateTime
    [int32]    $Day
    [string]   $DayAbrv
    [string]   $DayName
    [int32]    $DayOfWeek
    [Int64]    $FileTime
    [string]   $FullDateShortTime
    [string]   $FullDateTime
    [string]   $GeneralDateShortTime
    [string]   $GeneralDateTime
    [Boolean]  $IsDaylightSavingTime
    [Boolean]  $IsLeapYear
    [string]   $ISO8601
    [string]   $ISO8601UTC
    [string]   $LongDate
    [string]   $LongDateNoDay
    [string]   $LongTime
    [int32]    $Month
    [string]   $MonthAbrv
    [string]   $MonthDay
    [string]   $MonthName
    [int32]    $Quater
    [string]   $RFC1123
    [string]   $RFC1123UTC
    [string]   $RoundTrip
    [string]   $ShortDate
    [string]   $ShortTime
    [string]   $SortableDateTime
    [string]   $SQL
    [string]   $UniversalFullDateTime
    [string]   $UniversalSortableDateTime
    [int32]    $UnixEpochTime
    [string]   $WimDatetime
    [int32]    $Year
    [string]   $YearMonth
    [string]   $YearQuater

    [string] getStringProperty() {
        return $this.StringProperty
    }
}