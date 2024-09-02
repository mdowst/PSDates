BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Measure-TimeSpan' {

    # Sample data to be used in tests
    BeforeAll {
        # Mock TimeSpanGroupInfo data for testing
        $TestDates = @(
            [PSCustomObject]@{ Property = 10; TimeSpan = "2024-08-01T00:00:00" },
            [PSCustomObject]@{ Property = 20; TimeSpan = "2024-08-01T01:00:00" },
            [PSCustomObject]@{ Property = 30; TimeSpan = "2024-08-01T02:00:00" }
        )
        $groupedData = $TestDates | Group-TimeSpan -Property 'TimeSpan' -Days 1
    }

    Context 'Sum Calculation' {
        It 'Should calculate the correct sum of the specified property' {
            # Mocking the function Group-TimeSpan output
            $result = $groupedData | Measure-TimeSpan -Property 'Property' -Sum
            $expectedSum = 60

            # Assertion
            $result.Sum | Should -BeExactly $expectedSum
        }
    }

    Context 'Average Calculation' {
        It 'Should calculate the correct average of the specified property' {
            # Mocking the function Group-TimeSpan output
            $result = $groupedData | Measure-TimeSpan -Property 'Property' -Average
            $expectedAverage = 20

            # Assertion
            $result.Average | Should -BeExactly $expectedAverage
        }
    }

    Context 'Maximum Calculation' {
        It 'Should calculate the correct maximum of the specified property' {
            # Mocking the function Group-TimeSpan output
            $result = $groupedData | Measure-TimeSpan -Property 'Property' -Maximum
            $expectedMax = 30

            # Assertion
            $result.Maximum | Should -BeExactly $expectedMax
        }
    }

    Context 'Minimum Calculation' {
        It 'Should calculate the correct minimum of the specified property' {
            # Mocking the function Group-TimeSpan output
            $result = $groupedData | Measure-TimeSpan -Property 'Property' -Minimum
            $expectedMin = 10

            # Assertion
            $result.Minimum | Should -BeExactly $expectedMin
        }
    }

    Context 'IncludeAllTimes Calculations' {
        It 'Should calculate the correct sum of the specified properties' {
            $AllTestDates = @(
                [pscustomobject]@{TimeSpan = [dateTime]::new(2023, 1, 5, 0, 10, 57, 0, 0, 1); Property = 10 }
                [pscustomobject]@{TimeSpan = [dateTime]::new(2023, 1, 5, 3, 59, 37, 0, 0, 1); Property = 20 }
                [pscustomobject]@{TimeSpan = [dateTime]::new(2023, 1, 5, 5, 21, 36, 0, 0, 1); Property = 30 }
            )
            $AllGrouping = $AllTestDates | Group-TimeSpan -Property 'TimeSpan' -Hours 1 -Verbose -IncludeAllTimes
            $Results = $AllGrouping | Measure-TimeSpan -Property 'Property' -Sum
            $Results[0].DateTime | Should -Be ([datetime]'2023-01-05T00:00:00.0000000')
            $Results[0].Count | Should -Be 1
            $Results[0].Sum | Should -Be 10
            $Results[1].DateTime | Should -Be ([datetime]'2023-01-05T01:00:00.0000000')
            $Results[1].Count | Should -Be 0
            $Results[1].Sum | Should -Be 0
            $Results[2].DateTime | Should -Be ([datetime]'2023-01-05T02:00:00.0000000')
            $Results[2].Count | Should -Be 0
            $Results[2].Sum | Should -Be 0
            $Results[3].DateTime | Should -Be ([datetime]'2023-01-05T03:00:00.0000000')
            $Results[3].Count | Should -Be 1
            $Results[3].Sum | Should -Be 20
            $Results[4].DateTime | Should -Be ([datetime]'2023-01-05T04:00:00.0000000')
            $Results[4].Count | Should -Be 0
            $Results[4].Sum | Should -Be 0
            $Results[5].DateTime | Should -Be ([datetime]'2023-01-05T05:00:00.0000000')
            $Results[5].Count | Should -Be 1
            $Results[5].Sum | Should -Be 30
        }
    }
}
