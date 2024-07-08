Function Get-DateFormat {
   <#
.SYNOPSIS
   Returns common date and time formats
   
.DESCRIPTION
   This function format date and time values into multiple different common formats. All dates are based on the date passed.
   If no date is passed in the current date and time are used.

.PARAMETER Date
   The datetime value to return the formats for

.EXAMPLE
   Get-DateFormats

   Gets formatted date and time information based on the current time
.EXAMPLE
   Get-DateFormats -Date "11/17/2017"

   Gets formatted date and time information for a specific date

.OUTPUTS
   A PSObject containing the diffent values for the datetime formats.
#>
   [alias("Get-DateFormats")]
   [CmdletBinding(DefaultParameterSetName = "Full")]
   [OutputType([DateTimeFormats], ParameterSetName = "ID")]
   [OutputType([object], ParameterSetName = "Format")]
   param(
      [Parameter(Mandatory = $false, ParameterSetName = "Full")]
      [Parameter(Mandatory = $false, ParameterSetName = "Format")]
      [datetime]$Date = $(Get-Date),

      [Parameter(Mandatory = $false, ParameterSetName = "Format")]
      [string]$Format
   )

   $offset = ([System.TimeZoneInfo]::Local).BaseUtcOffset.ToString()
   $offset = $offset.Substring(0, $offset.LastIndexOf(':'))

   $dateFormats = [DateTimeFormats]@{
      DateTime                  = $Date.DateTime
      RFC1123UTC                = $Date.ToUniversalTime().ToString('r')
      SQL                       = $Date.ToString("yyyy-MM-dd HH:mm:ss.fff")
      ISO8601UTC                = $Date.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
      ISO8601                   = $Date.ToString("yyyy-MM-ddTHH:mm:ss.fff") + $offset
      ShortDate                 = $Date.ToString('d')
      LongDate                  = $Date.ToString('D')
      LongDateNoDay             = $Date.ToString('D').Substring($Date.ToString('D').IndexOf(',') + 2)
      FullDateShortTime         = $Date.ToString('f')
      FullDateTime              = $Date.ToString('F')
      GeneralDateShortTime      = $Date.ToString('g')
      GeneralDateTime           = $Date.ToString('G')
      MonthDay                  = $Date.ToString('M')
      RoundTrip                 = $Date.ToString('o')
      RFC1123                   = $Date.ToString('r')
      SortableDateTime          = $Date.ToString('s')
      ShortTime                 = $Date.ToString('t')
      LongTime                  = $Date.ToString('T')
      UniversalSortableDateTime = $Date.ToString('u')
      UniversalFullDateTime     = $Date.ToString('U')
      YearMonth                 = $Date.ToString('Y')
      "24HourTime"              = $Date.ToString("HH:mm")
      Day                       = $Date.Day
      DayAbrv                   = (Get-Culture).DateTimeFormat.GetAbbreviatedDayName($Date.DayOfWeek.value__)
      DayName                   = $Date.DayOfWeek.ToString()
      DayOfWeek                 = $Date.DayOfWeek.value__
      Month                     = $Date.Month
      MonthName                 = (Get-Culture).DateTimeFormat.GetMonthName($Date.Month)
      MonthAbrv                 = (Get-Culture).DateTimeFormat.GetAbbreviatedMonthName($Date.Month)
      Quater                    = [Math]::ceiling($Date.Month / 3)
      YearQuater                = "$($Date.Year)$("{0:00}" -f [Math]::ceiling($Date.Month/3) )"
      Year                      = $Date.Year
      WimDatetime               = (ConvertTo-WmiDateTime $Date)
      UnixEpochTime             = (ConvertTo-UnixTime $Date)
      IsDaylightSavingTime      = $Date.IsDaylightSavingTime()
      IsLeapYear                = [datetime]::IsLeapYear($Date.Year)
      FileTime                  = $Date.ToFileTime()
   }

   if ([string]::IsNullOrEmpty($PSBoundParameters['Format'])) {
      $dateFormats
   }
   else {
      $dateFormats."$($PSBoundParameters['Format'])"
   }
}
