class GroupTimeSpan {
    [int]      $Count 
    [datetime] $DateTime
    [object]   $Group

    GroupTimeSpan([Int64]$Ticks, [int]$Count) {
        $this.Count = $Count
        $this.DateTime = (Get-Date 1/1/0001).AddTicks($Ticks)
        $this.Group = @()
    }
    GroupTimeSpan([Microsoft.PowerShell.Commands.GroupInfo]$GroupInfo) {
        $this.Count = $GroupInfo.Count
        $this.DateTime = (Get-Date 1/1/0001).AddTicks($GroupInfo.Name)
        $this.Group = $GroupInfo.Group.Object
    }
}