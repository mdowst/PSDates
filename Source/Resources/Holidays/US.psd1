@{
    CountryCode = 'US'
    Name        = 'United States'
    Types       = @('Federal', 'Traditional', 'National', 'Observance', 'Religious')
    Holidays    = @(
        @{
            Holiday       = 'New Year''s Day'
            Type          = 'Federal'
            Date          = $null
            Month         = 1
            Day           = 1
            WeekOccurance = $null
            DayOfWeek     = $null
            OffsetDays    = $null
            Custom        = $null
        },
        @{
            Holiday       = 'Martin Luther King Day'
            Type          = 'Federal'
            Date          = $null
            Month         = 1
            Day           = $null
            WeekOccurance = '3'
            DayOfWeek     = 1
            OffsetDays    = $null
            Custom        = $null
        }
    )
}
