function ConvertTo-DegreeString {
    param (
        [double]$Degrees
    )
    $x = [math]::Round($Degrees * 3600)
    $num = "∠{0:N3}°" -f $Degrees
    $rad = "∠{0:N3}rad" -f ($Degrees * ([math]::PI / 180))
    $human = "∠{0}°{1}′{2}″" -f ($x / 3600), ($x / 60 % 60), ($x % 60)
    "$rad = $human = $num"
}