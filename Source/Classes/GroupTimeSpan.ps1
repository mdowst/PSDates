class TimeSpanGroupInfo {
    [int]      $Count 
    [datetime] $DateTime
    [object]   $Group

    TimeSpanGroupInfo([Int64]$Ticks, [int]$Count) {
        $this.Count = $Count
        $this.DateTime = (Get-Date 1/1/0001).AddTicks($Ticks)
        $this.Group = @()
    }
    TimeSpanGroupInfo([Microsoft.PowerShell.Commands.GroupInfo]$GroupInfo) {
        $this.Count = $GroupInfo.Count
        $this.DateTime = (Get-Date 1/1/0001).AddTicks($GroupInfo.Name)
        $this.Group = $GroupInfo.Group.Object
    }
}