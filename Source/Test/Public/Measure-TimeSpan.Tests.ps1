BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Measure-TimeSpan' {

    # Sample data to be used in tests
    BeforeAll {
        # Mock GroupTimeSpan data for testing
        $TestDates = @(
            [PSCustomObject]@{ Property = 10; TimeSpan = "2024-08-01T00:00:00" },
            [PSCustomObject]@{ Property = 20; TimeSpan = "2024-08-01T01:00:00" },
            [PSCustomObject]@{ Property = 30; TimeSpan = "2024-08-01T02:00:00" }
        )
        $groupedData = $TestDates | Group-TimeSpan -Property 'TimeSpan' -Days 1 -Round
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
}
