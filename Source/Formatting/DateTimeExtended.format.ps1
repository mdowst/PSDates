$PropertiesAndWidths = [ordered]@{
    Date = 25
    WeekOfYear = 10
    DayOfWeek = 15
    StartOfWeek = 15
    EndOfWeek = 15
    StartOfMonth = 15
    EndOfMonth = 15
}
$VirtualProperties = [ordered]@{ 
    "StartOfWeek"= {$_.EndOfWeek.ToShortDateString()}
    "EndOfWeek"={$_.EndOfWeek.ToShortDateString()}
    "StartOfMonth"={$_.StartOfMonth.ToShortDateString()}
    "EndOfMonth"={$_.EndOfMonth.ToShortDateString()}
}

$Property = $PropertiesAndWidths.GetEnumerator() | ForEach-Object { $_.Name }
$Width = $PropertiesAndWidths.GetEnumerator() | ForEach-Object { $_.Value }
Write-FormatView -TypeName DateTimeExtended -Property $Property -Width $Width -VirtualProperty $VirtualProperties