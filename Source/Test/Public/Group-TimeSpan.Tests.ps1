BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Group-TimeSpan Tests' {
    BeforeEach {
        $TestDates = @(
            [pscustomobject]@{StartTime = [dateTime]::new(2015, 01, 15, 17, 10, 57, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2015, 02, 20, 0, 59, 37, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2019, 03, 05, 10, 21, 36, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2019, 04, 10, 4, 14, 39, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2020, 05, 25, 22, 45, 54, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2020, 06, 30, 1, 16, 43, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2021, 07, 15, 15, 33, 09, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2021, 08, 10, 18, 40, 37, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2022, 09, 01, 19, 53, 41, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2022, 10, 15, 16, 10, 54, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 01, 15, 14, 47, 38, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 02, 20, 10, 26, 54, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 03, 05, 18, 56, 03, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 04, 10, 22, 48, 28, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 05, 25, 5, 17, 59, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 06, 30, 19, 26, 08, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 07, 15, 16, 24, 47, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 08, 10, 21, 01, 22, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 09, 01,  4, 51, 36, 0, 0, 1); Total = 2 }
            [pscustomobject]@{StartTime = [dateTime]::new(2023, 10, 15, 14, 17, 39, 0, 0, 1); Total = 2 }
        )
    }
    
    It 'Group-TimeSpan Hours' {
        $TestDates | ForEach-Object {
            $_.StartTime = [dateTime]::new(2023, 1, 1, $_.StartTime.Hour, $_.StartTime.Minute, $_.StartTime.Second , 0, 0, 1)
        }
        
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Hours 5 -Round
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T00:00:00.0000000')
        $Results[0].Count | Should -Be 4
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-01T05:00:00.0000000')
        $Results[1].Count | Should -Be 1
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-01T10:00:00.0000000')
        $Results[2].Count | Should -Be 4
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T15:00:00.0000000')
        $Results[3].Count | Should -Be 8
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-01T20:00:00.0000000')
        $Results[4].Count | Should -Be 3

        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Hours 5
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T02:48:28.0000000')
        $Results[0].Count | Should -Be 2
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-01T07:48:28.0000000')
        $Results[1].Count | Should -Be 3
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-01T12:48:28.0000000')
        $Results[2].Count | Should -Be 2
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-01T17:48:28.0000000')
        $Results[3].Count | Should -Be 6
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-01T22:48:28.0000000')
        $Results[4].Count | Should -Be 7
    }

    It 'Group-TimeSpan Minutes' {
        $TestDates | ForEach-Object {
            $_.StartTime = [dateTime]::new(2023, 1, 1, 6, $_.StartTime.Minute, $_.StartTime.Second , 0, 0, 1)
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
            $_.StartTime = [dateTime]::new(2023, 1, 1, 6, 23, $_.StartTime.Second , 0, 0, 1)
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
            $_.StartTime = [dateTime]::new(2023, 1, $_.StartTime.Day, $_.StartTime.Hour, $_.StartTime.Minute, $_.StartTime.Second , 0, 0, 1)
        }
        
        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Days 5 -Round
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-01T00:00:00.0000000')
        $Results[0].Count | Should -Be 4
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

        $Results = $TestDates | Group-TimeSpan -Property 'StartTime' -Days 5
        $Results[0].DateTime | Should -Be ([datetime]'2023-01-05T19:26:08.0000000')
        $Results[0].Count | Should -Be 4
        $Results[1].DateTime | Should -Be ([datetime]'2023-01-10T19:26:08.0000000')
        $Results[1].Count | Should -Be 2
        $Results[2].DateTime | Should -Be ([datetime]'2023-01-15T19:26:08.0000000')
        $Results[2].Count | Should -Be 8
        $Results[3].DateTime | Should -Be ([datetime]'2023-01-20T19:26:08.0000000')
        $Results[3].Count | Should -Be 2
        $Results[4].DateTime | Should -Be ([datetime]'2023-01-25T19:26:08.0000000')
        $Results[4].Count | Should -Be 1
        $Results[5].DateTime | Should -Be ([datetime]'2023-01-30T19:26:08.0000000')
        $Results[5].Count | Should -Be 3
    }

    It 'Group-TimeSpan Months' {
        $TestDates | ForEach-Object {
            $_.StartTime = [dateTime]::new(2023, $_.StartTime.Month, $_.StartTime.Day, $_.StartTime.Hour, $_.StartTime.Minute, $_.StartTime.Second , 0, 0, 1)
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
