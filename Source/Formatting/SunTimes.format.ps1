$VirtualProperties = [ordered]@{ 
    "Date"      = { $_.Sunrise.ToString('d') }
    "Sunrise"   = { $_.Sunrise.ToString('t') }
    "Sunset"    = { $_.Sunset.ToString('t') }
    "DayLength" = { "{0:N3} hours" -f $_.DayLength }
}
$Property = $VirtualProperties.GetEnumerator() | ForEach-Object { $_.Name }
Write-FormatView -TypeName SunTimes -Property $Property -VirtualProperty $VirtualProperties

Write-FormatView -TypeName degree -Property degree