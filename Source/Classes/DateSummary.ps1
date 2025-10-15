class DateSummary {
    [int]           $Count
    [int]           $NullsSkipped
    [datetime]      $Earliest
    [datetime]      $Latest
    [TimeSpan]      $Span
    [TimeSpan]      $AverageGap
    [TimeSpan]      $MedianGap
    [TimeSpan]      $MinGap
    [TimeSpan]      $MaxGap
    [int]           $UniqueDays

    DateSummary() {
        $this.Count        = 0
        $this.NullsSkipped = 0
        $this.Earliest     = [datetime]::MinValue
        $this.Latest       = [datetime]::MinValue
        $this.Span         = [TimeSpan]::Zero
        $this.AverageGap   = [TimeSpan]::Zero
        $this.MedianGap    = [TimeSpan]::Zero
        $this.MinGap       = [TimeSpan]::Zero
        $this.MaxGap       = [TimeSpan]::Zero
        $this.UniqueDays   = 0
    }

    DateSummary([hashtable] $props) {
        foreach ($entry in $props.GetEnumerator()) {
            if ($this.PSObject.Properties.Match($entry.Key)) {
                $this.$($entry.Key) = $entry.Value
            }
        }
    }
    
    DateSummary(
        [int] $Count,
        [int] $NullsSkipped,
        [datetime] $Earliest,
        [datetime] $Latest,
        [TimeSpan] $Span,
        [TimeSpan] $AverageGap,
        [TimeSpan] $MedianGap,
        [TimeSpan] $MinGap,
        [TimeSpan] $MaxGap,
        [int] $UniqueDays
    ) {
        $this.Count        = $Count
        $this.NullsSkipped = $NullsSkipped
        $this.Earliest     = $Earliest
        $this.Latest       = $Latest
        $this.Span         = $Span
        $this.AverageGap   = $AverageGap
        $this.MedianGap    = $MedianGap
        $this.MinGap       = $MinGap
        $this.MaxGap       = $MaxGap
        $this.UniqueDays   = $UniqueDays
    }

    [string] ToString() {
        return "Count=$($this.Count), Span=$($this.Span), AvgGap=$($this.AverageGap), Earliest=$($this.Earliest), Latest=$($this.Latest)"
    }
}
