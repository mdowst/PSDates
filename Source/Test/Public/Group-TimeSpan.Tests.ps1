BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Group-TimeSpan Tests' {
    BeforeEach {
        $TestDates = @(
            [pscustomobject]@{StartTime = [datetime]'2015-01-15T17:10:57Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2015-02-20T00:59:37Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2019-03-05T10:21:36Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2019-04-10T04:14:39Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2020-05-25T22:45:54Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2020-06-30T01:16:43Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2021-07-15T15:33:09Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2021-08-10T18:40:37Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2022-09-01T19:53:41Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2022-10-15T16:10:54Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-01-15T14:47:38Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-02-20T10:26:54Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-03-05T18:56:03Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-04-10T22:48:28Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-05-25T05:17:59Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-06-30T19:26:08Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-07-15T16:24:47Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-08-10T21:01:22Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-09-01T04:51:36Z'; Total = 2 }
            [pscustomobject]@{StartTime = [datetime]'2023-10-15T14:17:39Z'; Total = 2 }
        )
    }
    
    It 'Group-TimeSpan Hours' {
        $TestDates | ForEach-Object {
            $_.StartTime = Get-Date $_.StartTime -Month 1 -Day 1 -Year 2023
        }
        
        $FiveHours = $TestDates | Group-TimeSpan -Property 'StartTime' -Hours 5 -Round
        $FiveHours[0].DateTime | Should -Be ([datetime]'2023-01-01T00:00:00.0000000')
        $FiveHours[0].Count | Should -Be 3
        $FiveHours[1].DateTime | Should -Be ([datetime]'2023-01-01T05:00:00.0000000')
        $FiveHours[1].Count | Should -Be 2
        $FiveHours[2].DateTime | Should -Be ([datetime]'2023-01-01T10:00:00.0000000')
        $FiveHours[2].Count | Should -Be 8
        $FiveHours[3].DateTime | Should -Be ([datetime]'2023-01-01T15:00:00.0000000')
        $FiveHours[3].Count | Should -Be 4
        $FiveHours[4].DateTime | Should -Be ([datetime]'2023-01-01T20:00:00.0000000')
        $FiveHours[4].Count | Should -Be 3

        $FiveHours = $TestDates | Group-TimeSpan -Property 'StartTime' -Hours 5
        $FiveHours[0].DateTime | Should -Be ([datetime]'2023-01-01T03:51:36.0000000')
        $FiveHours[0].Count | Should -Be 1
        $FiveHours[1].DateTime | Should -Be ([datetime]'2023-01-01T08:51:36.0000000')
        $FiveHours[1].Count | Should -Be 3
        $FiveHours[2].DateTime | Should -Be ([datetime]'2023-01-01T13:51:36.0000000')
        $FiveHours[2].Count | Should -Be 7
        $FiveHours[3].DateTime | Should -Be ([datetime]'2023-01-01T18:51:36.0000000')
        $FiveHours[3].Count | Should -Be 5
        $FiveHours[4].DateTime | Should -Be ([datetime]'2023-01-01T23:51:36.0000000')
        $FiveHours[4].Count | Should -Be 4
    }

    It 'Group-TimeSpan Minutes' {
        $TestDates | ForEach-Object {
            $_.StartTime = Get-Date $_.StartTime -Month 1 -Day 1 -Year 2023 -Hour 6
        }
        
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Minutes 5 -Round
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T06:00:00.0000000')
        $Results[0].Count | Should -Be 1
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-01T06:10:00.0000000')
        $Results[1].Count | Should -Be 3
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-01T06:15:00.0000000')
        $Results[2].Count | Should -Be 3
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T06:20:00.0000000')
        $Results[3].Count | Should -Be 2
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-01T06:25:00.0000000')
        $Results[4].Count | Should -Be 2
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-01T06:30:00.0000000')
        $Results[5].Count | Should -Be 1
        $Results[6].DateTime | Should -Be ([datetime]'2023-01-01T06:45:00.0000000')
        $Results[6].Count | Should -Be 3
        $Results[7].DateTime | Should -Be ([datetime]'2023-01-01T06:50:00.0000000')
        $Results[7].Count | Should -Be 2
        $Results[8].DateTime | Should -Be ([datetime]'2023-01-01T06:55:00.0000000')
        $Results[8].Count | Should -Be 2
        $Results[9].DateTime | Should -Be ([datetime]'2023-01-01T06:40:00.0000000')
        $Results[9].Count | Should -Be 1

        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Minutes 5
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T06:04:37.0000000')
        $Results[0].Count | Should -Be 1
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-01T06:14:37.0000000')
        $Results[1].Count | Should -Be 2
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-01T06:19:37.0000000')
        $Results[2].Count | Should -Be 4
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T06:24:37.0000000')
        $Results[3].Count | Should -Be 1
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-01T06:29:37.0000000')
        $Results[4].Count | Should -Be 3
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-01T06:34:37.0000000')
        $Results[5].Count | Should -Be 1
        $Results[6].DateTime | Should -Be ([datetime]'2023-01-01T06:44:37.0000000')
        $Results[6].Count | Should -Be 1
        $Results[7].DateTime | Should -Be ([datetime]'2023-01-01T06:49:37.0000000')
        $Results[7].Count | Should -Be 3
        $Results[8].DateTime | Should -Be ([datetime]'2023-01-01T06:54:37.0000000')
        $Results[8].Count | Should -Be 2
        $Results[9].DateTime | Should -Be ([datetime]'2023-01-01T06:59:37.0000000')
        $Results[9].Count | Should -Be 2
    }

    It 'Group-TimeSpan Seconds' {
        $TestDates | ForEach-Object {
            $_.StartTime = Get-Date $_.StartTime -Month 1 -Day 1 -Year 2023 -Hour 6 -Minute 23
        }
        
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Seconds 5 -Round
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T06:23:00.0000000')
        $Results[0].Count | Should -Be 1
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-01T06:23:05.0000000')
        $Results[1].Count | Should -Be 2
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-01T06:23:20.0000000')
        $Results[2].Count | Should -Be 1
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T06:23:25.0000000')
        $Results[3].Count | Should -Be 1
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-01T06:23:35.0000000')
        $Results[4].Count | Should -Be 7
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-01T06:23:40.0000000')
        $Results[5].Count | Should -Be 2
        $Results[6].DateTime | Should -Be ([datetime]'2023-01-01T06:23:45.0000000')
        $Results[6].Count | Should -Be 1
        $Results[7].DateTime | Should -Be ([datetime]'2023-01-01T06:23:50.0000000')
        $Results[7].Count | Should -Be 3
        $Results[8].DateTime | Should -Be ([datetime]'2023-01-01T06:23:55.0000000')
        $Results[8].Count | Should -Be 2

        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Seconds 5
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T06:23:04.0000000')
        $Results[0].Count | Should -Be 1
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-01T06:23:09.0000000')
        $Results[1].Count | Should -Be 2
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-01T06:23:24.0000000')
        $Results[2].Count | Should -Be 1
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T06:23:29.0000000')
        $Results[3].Count | Should -Be 1
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-01T06:23:39.0000000')
        $Results[4].Count | Should -Be 7
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-01T06:23:44.0000000')
        $Results[5].Count | Should -Be 2
        $Results[6].DateTime | Should -Be ([datetime]'2023-01-01T06:23:49.0000000')
        $Results[6].Count | Should -Be 1
        $Results[7].DateTime | Should -Be ([datetime]'2023-01-01T06:23:54.0000000')
        $Results[7].Count | Should -Be 3
        $Results[8].DateTime | Should -Be ([datetime]'2023-01-01T06:23:59.0000000')
        $Results[8].Count | Should -Be 2
    }

    It 'Group-TimeSpan Days' {
        $TestDates | ForEach-Object {
            $_.StartTime = Get-Date $_.StartTime -Month 1 -Year 2023
        }
        
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Days 5 -Round
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T00:00:00.0000000')
        $Results[0].Count | Should -Be 3
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-06T00:00:00.0000000')
        $Results[1].Count | Should -Be 4
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-11T00:00:00.0000000')
        $Results[2].Count | Should -Be 6
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-16T00:00:00.0000000')
        $Results[3].Count | Should -Be 2
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-21T00:00:00.0000000')
        $Results[4].Count | Should -Be 2
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-26T00:00:00.0000000')
        $Results[5].Count | Should -Be 2
        $Results[6].DateTime | Should -Be ([datetime]'2023-01-31T00:00:00.0000000')
        $Results[6].Count | Should -Be 1

        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Days 5
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T23:51:36.0000000')
        $Results[0].Count | Should -Be 1
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-06T23:51:36.0000000')
        $Results[1].Count | Should -Be 2
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-11T23:51:36.0000000')
        $Results[2].Count | Should -Be 4
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-16T23:51:36.0000000')
        $Results[3].Count | Should -Be 6
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-21T23:51:36.0000000')
        $Results[4].Count | Should -Be 2
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-26T23:51:36.0000000')
        $Results[5].Count | Should -Be 2
        $Results[6].DateTime | Should -Be ([datetime]'2023-01-31T23:51:36.0000000')
        $Results[6].Count | Should -Be 3
    }

    It 'Group-TimeSpan Months' {
        $TestDates | ForEach-Object {
            $_.StartTime = Get-Date $_.StartTime -Year 2023
        }
        
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Months 3
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T00:00:00.0000000')
        $Results[0].Count | Should -Be 6
        $Results[1].DateTime | Should -Be ([datetime]'2023-04-01T00:00:00.0000000')
        $Results[1].Count | Should -Be 6
        $Results[2].DateTime | Should -Be ([datetime]'2023-07-01T00:00:00.0000000')
        $Results[2].Count | Should -Be 6
        $Results[3].DateTime | Should -Be ([datetime]'2023-10-01T00:00:00.0000000')
        $Results[3].Count | Should -Be 2
    }

    It 'Group-TimeSpan Years' {       
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Years 2
        $Results[0].DateTime | Should -Be ([datetime]'2015-01-01T00:00:00.0000000')
        $Results[0].Count | Should -Be 2
        $Results[1].DateTime | Should -Be ([datetime]'2019-01-01T00:00:00.0000000')
        $Results[1].Count | Should -Be 4
        $Results[2].DateTime | Should -Be ([datetime]'2021-01-01T00:00:00.0000000')
        $Results[2].Count | Should -Be 4
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T00:00:00.0000000')
        $Results[3].Count | Should -Be 10
    }
}
