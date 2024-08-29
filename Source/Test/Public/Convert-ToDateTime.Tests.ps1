BeforeAll {
    # Import the module
    $TopLevel = (Split-Path(Split-Path(Split-Path $PSScriptRoot)))
    $ModulePath = Get-ChildItem -Path (Join-Path $TopLevel 'Build\PSDates') -Filter 'PSDates.psd1' -Recurse | Select-Object -Last 1
    Import-Module $ModulePath.FullName -Force
}

Describe 'Convert-ToDateTime' {

    Context 'Valid DateTime Conversion' {
        It 'Should convert a valid date string to a DateTime object' {
            # Arrange
            $input = '2024-08-29'

            # Act
            $result = $input | Convert-ToDateTime

            # Assert
            $result | Should -BeOfType 'DateTime'
            $result | Should -Be ([datetime]'2024-08-29T00:00:00.0000000')
        }

        It 'Should return a DateTime object unchanged if input is already a DateTime' {
            # Arrange
            $input = Get-Date

            # Act
            $result = $input | Convert-ToDateTime

            # Assert
            $result | Should -BeOfType 'DateTime'
            $result | Should -Be $input
        }
    }

    Context 'Invalid DateTime Conversion' {
        It 'Should throw an error for an invalid date string' {
            # Arrange
            $invalidInput = 'InvalidDateString'

            # Act & Assert
            { $invalidInput | Convert-ToDateTime -ErrorAction Stop } | Should -Throw
        }

        It 'Should throw an error for non-convertible input' {
            # Arrange
            $nonConvertibleInput = @{ Name = 'Test' }

            # Act & Assert
            { $nonConvertibleInput | Convert-ToDateTime -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Null and Empty Input' {
        It 'Should throw an error when input is $null' {
            # Arrange
            $nullInput = $null

            # Act & Assert
            { $nullInput | Convert-ToDateTime -ErrorAction Stop } | Should -Throw
        }

        It 'Should throw an error when input is an empty string' {
            # Arrange
            $emptyInput = ''

            # Act & Assert
            { $emptyInput | Convert-ToDateTime -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Edge Cases' {
        It 'Should handle a leap year date correctly' {
            # Arrange
            $input = '2024-02-29'

            # Act
            $result = $input | Convert-ToDateTime

            # Assert
            $result | Should -BeOfType 'DateTime'
            $result | Should -Be ([datetime]'2024-02-29T00:00:00.0000000')
        }

        It 'Should handle different date formats correctly' {
            # Arrange
            $input = '08/29/2024'

            # Act
            $result = $input | Convert-ToDateTime

            # Assert
            $result | Should -BeOfType 'DateTime'
            $result | Should -Be ([datetime]'2024-08-29T00:00:00.0000000')
        }
    }
}
