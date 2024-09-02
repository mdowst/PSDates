function Convert-ToDateTime {
    <#
.SYNOPSIS
    Converts various input objects to a DateTime object.

.DESCRIPTION
    The `Convert-ToDateTime` function attempts to convert different types of input objects into a DateTime object.
    It supports input from various data types such as strings and objects that can be cast or converted to a DateTime.

.PARAMETER InputObject
    Specifies the input object to be converted to a DateTime. This parameter accepts pipeline input and is mandatory.

    The input can be of any type:
    - If the input is already a DateTime, it will be returned as-is.
    - If the input is a string, it attempts to parse it into a DateTime.
    - Other input types will be processed accordingly, if possible.

.EXAMPLE
    '2024-08-29' | Convert-ToDateTime

    Converts the string '2024-08-29' into a DateTime object representing the 29th of August, 2024.

.INPUTS
    System.Object
    The function accepts objects from the pipeline, which are attempted to be converted to DateTime.

.OUTPUTS
    System.DateTime
    The function outputs a DateTime object if the conversion is successful.
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Object]$InputObject
    )

    process {
        $Return = $null
        try {
            # Attempt to convert directly if input is already a DateTime or string
            if ($InputObject -is [DateTime]) {
                $Return = $InputObject
            }
            elseif ($InputObject -is [string]) {
                try{
                    $Return = Get-Date $InputObject -ErrorAction Stop
                }
                catch{
                # Attempt to parse string input to DateTime
                $Return = [DateTime]::ParseExact($InputObject, 
                    [System.Globalization.CultureInfo]::InvariantCulture.DateTimeFormat.GetAllDateTimePatterns(), 
                    [System.Globalization.CultureInfo]::InvariantCulture, 
                    [System.Globalization.DateTimeStyles]::None) -as [DateTime]
                }
            }
            else {
                # Attempt conversion for other types using their string representation
                $Return = [DateTime]::Parse($InputObject.ToString(), 
                    [System.Globalization.CultureInfo]::InvariantCulture) -as [DateTime]
            }
        }
        catch {
            # Return error if conversion fails
            Write-Error "Unable to convert '$InputObject' to DateTime."
        }
        $Return
    }
}