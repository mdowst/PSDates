Function Get-CronDescription {
<#
.SYNOPSIS
   Convert a cron expression into a human readable description

.DESCRIPTION
   Uses the .NET library CronExpressionDescriptor to convert cron expressions into human readable descriptions.

.PARAMETER Crontab
   A valid crontab string

.PARAMETER DayOfWeekStartIndexOne
    When used Sunday will equal 1, otherwise Sunday will be 0. (Default: Sunday = 0)

.PARAMETER Use24HourTimeFormat
    If true, descriptions will use a 24-hour clock (Default: false but some translations will default to true)

.PARAMETER Locale
    The locale to use (Default: "en")
    Supported values: cs-CZ, da, de, es, es-MX, fa, fi, fr, he-IL, hu, it, ja, ko, nb, nl, pl, pt, ro, ru, sl, sv, tr, uk, vi, zh-Hans, zh-Hant

.EXAMPLE
    Get-CronDescription -Crontab '0 17 * * 1'

    Results with default options:
    At 05:00 PM, only on Monday

.EXAMPLE
    Get-CronDescription -Crontab '0 17 * * 1' -DayOfWeekStartIndexOne

    Results with DayOfWeekStartIndexOne switch returns Sunday for the 1 instead of Monday:
    At 05:00 PM, only on Sunday

.EXAMPLE
    Get-CronDescription -Crontab '0 17 * * 1' -Use24HourTimeFormat

    Results with Use24HourTimeFormat options:
    At 17:00, only on Monday

.EXAMPLE
    Get-CronDescription -Crontab '0 17 * * 1' -Locale 'fr'

    Results with fr Locale options:
    At 05:00 PM, only on lundi

.OUTPUTS
   A psobject that contains the crontable, a validation value, and any error messages returned
#>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Crontab,
        [Parameter(Mandatory = $false)]
        [switch]$DayOfWeekStartIndexOne = $false,
        [Parameter(Mandatory = $false)]
        [switch]$Use24HourTimeFormat = $false,
        [Parameter(Mandatory = $false)]
        [ValidateSet('cs-CZ','da','de','es','es-MX','fa','fi','fr','he-IL','hu','it','ja','ko','nb','nl','pl','pt','ro','ru','sl','sv','tr','uk','vi','zh-Hans','zh-Hant')]
        [string]$Locale = 'en'
    )

    # Set options
    $options = [CronExpressionDescriptor.Options]::new()
    if($DayOfWeekStartIndexOne){
        $options.DayOfWeekStartIndexZero = $false
    }
    $options.Use24HourTimeFormat = $Use24HourTimeFormat
    $options.Locale = $Locale

    # Get Description
    [CronExpressionDescriptor.ExpressionDescriptor]::GetDescription($Crontab, $options)
}