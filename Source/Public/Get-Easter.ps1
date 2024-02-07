Function Get-Easter {
    <#
    .SYNOPSIS
    This function offers a generic Easter computing method for any given year, using Western, Orthodox or Julian algorithms.

    .DESCRIPTION
    Shamelessly stolen from python dateutil (https://github.com/dateutil/dateutil/blob/master/src/dateutil/easter.py)

    .PARAMETER Year
    The year to get Easter from

    .PARAMETER Calendar
    Gregorian : is the default and valid from 1583 to 4099
    Orthodox :  valid from 1583 to 4099
    Julian : valid from 326

    .EXAMPLE
    Get-Easter -Year 2024

    #>
    [CmdletBinding()]
    [OutputType([datetime])]
    param(
        [Parameter(Mandatory = $false)]
        [int]$year = (Get-Date).Year,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Gregorian', 'Julian', 'Orthodox')]
        [string]$Calendar = 'Gregorian'
    )

    # Golden year - 1
    $g = $year % 19
    $e = 0
    if ($Calendar -ne 'Gregorian') {
        # Old method
        $i = (19 * $g + 15) % 30
        $j = ($year + [math]::floor($year / 4) + $i) % 7
        if ($Calendar -eq 'Orthodox') {
            # Extra dates to convert Julian to Gregorian date
            $e = 10
            if ($year -gt 1600) {
                $e = $e + [math]::floor([math]::floor($year / 100) - 16 - ([math]::floor($year / 100) - 16) / 4)
            }
        }
    }
    else {
        # Century
        $c = [math]::floor($year / 100)
        # (23 - Epact) mod 30
        $h = ($c - [math]::floor($c / 4) - [math]::floor((8 * $c + 13) / 25) + 19 * $g + 15) % 30
        # Number of days from March 21 to Paschal Full Moon
        $i = $h - ([math]::floor($h / 28)) * (1 - ([math]::floor($h / 28)) * ([math]::floor(29 / ($h + 1))) * ([math]::floor((21 - $g) / 11)))
        # Weekday for PFM (0=Sunday, etc)
        $j = ($year + [math]::floor($year / 4) + $i + 2 - $c + [math]::floor($c / 4)) % 7
    }



    # Number of days from March 21 to Sunday on or before PFM
    $p = $i - $j + $e
    $d = 1 + ($p + 27 + [math]::floor(($p + 6) / 40)) % 31
    $m = 3 + [math]::floor(($p + 26) / 30)

    [datetime]::new($year, $m, $d)
}
