Function Get-CronNextOccurrence {
    <#
.SYNOPSIS
   Get the next occurrence for a crontab

.DESCRIPTION
   This function will either return the next occurrence, or if an end date is supplied, it will return
   all the occurrences between the start and end date.

.PARAMETER Crontab
   A valid crontab string

.PARAMETER StartTime
   The datetime object to find the next occurrence from. Uses current time if not supplied.

.PARAMETER EndTime
   The datetime object to stop finding occurrences for from the StartTime

.EXAMPLE
    Get-CronNextOccurrence -Crontab '0 17 * * *'

    Will return the next occurrence of the crontab from the current time

.EXAMPLE
    $Date = Get-Date '12/14/2032'
    Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date

    Will return the next occurrence of the crontab from the time provided

.EXAMPLE
    Get-CronNextOccurrence -Crontab '0 17 * * *' -StartTime $Date -EndTime $Date.AddDays(3)

    Will return the all occurrences of the crontab between the two times

.OUTPUTS
   A datetime object for every occurrence returned
#>
    [CmdletBinding()]
    [OutputType('datetime')]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Crontab,
        [Parameter(Mandatory = $false)]
        [datetime]$StartTime = (Get-Date),
        [Parameter(Mandatory = $false)]
        [datetime]$EndTime
    )
    # validat crontab
    $Schedule = Test-CrontabSchedule -Crontab $Crontab

    # if no end date, just get next occurrence, else find all occurrences between start and end
    if ($Schedule.valid -eq $true -and $null -eq $EndTime) {
        $schedule.schedule.GetNextOccurrence($StartTime)
    }
    elseif ($Schedule.valid -eq $true) {
        $schedule.schedule.GetNextOccurrences($StartTime, $EndTime)
    }
    else {
        throw $Schedule.ErrorMsg
    }


}
