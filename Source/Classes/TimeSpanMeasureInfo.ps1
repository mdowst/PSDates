class TimeSpanMeasureInfo {
    [datetime] $DateTime
    [int]      $Count 
    [Nullable[System.Double]] $Average
    [Nullable[System.Double]] $Sum
    [Nullable[System.Double]] $Maximum
    [Nullable[System.Double]] $Minimum
    [string] $Property

    TimeSpanMeasureInfo([datetime]$DateTime, [Microsoft.PowerShell.Commands.GenericMeasureInfo]$Measure) {
        $this.DateTime = $DateTime
        $this.Property = $Measure.Property
        $this.Count = $Measure.Count
        if($Measure.Average){$this.Average = $Measure.Average}
        if($Measure.Sum){$this.Sum = $Measure.Sum}
        if($Measure.Maximum){$this.Maximum = $Measure.Maximum}
        if($Measure.Minimum){$this.Minimum = $Measure.Minimum}       
    }
}