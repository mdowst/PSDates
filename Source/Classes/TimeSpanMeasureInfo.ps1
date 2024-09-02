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
        if($null -ne $Measure.Average){$this.Average = $Measure.Average}
        if($null -ne $Measure.Sum){$this.Sum = $Measure.Sum}
        if($null -ne $Measure.Maximum){$this.Maximum = $Measure.Maximum}
        if($null -ne $Measure.Minimum){$this.Minimum = $Measure.Minimum}       
    }

    TimeSpanMeasureInfo([datetime]$DateTime, [string]$Property, [int]$count) {
        $this.DateTime = $DateTime
        $this.Property = $Property
        $this.Count = $count      
    }
}