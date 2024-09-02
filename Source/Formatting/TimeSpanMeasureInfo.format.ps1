$VirtualProperties = [ordered]@{ 
    "DateTime"      = { $_.DateTime }
    "Count"   = { $_.Count }
    "Average"    = { if ($_.Average -eq [math]::Floor($_.Average)) {
        # If the number is a whole number, format without decimals
        "{0:N0}" -f $_.Average
    } else {
        # If the number is not a whole number, format with decimals
        "{0:N2}" -f $_.Average
    } }
    "Sum" = { if ($_.Sum -eq [math]::Floor($_.Sum)) {
        # If the number is a whole number, format without decimals
        "{0:N0}" -f $_.Sum
    } else {
        # If the number is not a whole number, format with decimals
        "{0:N2}" -f $_.Sum
    } }
    "Maximum"    = { if ($_.Maximum -eq [math]::Floor($_.Maximum)) {
        # If the number is a whole number, format without decimals
        "{0:N0}" -f $_.Maximum
    } else {
        # If the number is not a whole number, format with decimals
        "{0:N2}" -f $_.Maximum
    } }
    "Minimum"    = { if ($_.Minimum -eq [math]::Floor($_.Minimum)) {
        # If the number is a whole number, format without decimals
        "{0:N0}" -f $_.Minimum
    } else {
        # If the number is not a whole number, format with decimals
        "{0:N2}" -f $_.Minimum
    } }
    "Property"    = { $_.Property }
}
$Property = $VirtualProperties.GetEnumerator() | ForEach-Object { $_.Name }
Write-FormatView -TypeName TimeSpanMeasureInfo -Property $Property -VirtualProperty $VirtualProperties