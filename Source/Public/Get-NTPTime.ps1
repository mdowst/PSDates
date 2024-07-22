Function Get-NTPTime {
    <#
.SYNOPSIS
Get the current date and time for an NTP server.

.DESCRIPTION
This function retrieves the current time from an NTP (Network Time Protocol) server. Value is returned as UTC time unless the ToLocalTime switch is used.

.PARAMETER NtpHost
The host name of the NtpHost. (Default: "pool.ntp.org")

.PARAMETER ToLocalTime
When used the datetime will be converted to the computers local time.

.EXAMPLE
Get-NTPTime

Get the NTP time from the default "pool.ntp.org" and return as UTC datetime

.EXAMPLE
Get-NTPTime -NtpHost "time.windows.com" -ToLocalTime

Get the NTP time from "time.windows.com" and converts to the local datetime

.NOTES
Created with help from:
 - https://github.com/WichardRiezebos/ntp-client
 - https://stackoverflow.com/questions/1193955/how-to-query-an-ntp-server-using-c
#>
    [cmdletbinding()]
    param(
        [Parameter(Position=0, Mandatory = $false)]    
        [string]$NtpHost = "pool.ntp.org",
        [Parameter(Position=1, Mandatory = $false)]    
        [switch]$ToLocalTime = $false
    )

    # This creates a byte array of 48 bytes (the size of an NTP packet) and sets the first byte to 0x1B, which corresponds to the NTP packet's "Leap Indicator", "Version Number", and "Mode" fields.
    $ntpData = New-Object byte[] 48
    $ntpData[0] = 0x1B;

    $previousEA = $ErrorActionPreference
    try {
        # Set Error Action to Stop so if any part of the connection fails, we can record the error and terminate processing
        $ErrorActionPreference = 'Stop'
        # This resolves the hostname to an IP address and creates an endpoint using the first resolved IP address and port 123, which is the NTP port.
        $addresses = [System.Net.Dns]::GetHostAddresses($NtpHost)
        $ipEndPoint = New-Object System.Net.IPEndPoint ($addresses[0], 123)

        # This creates a new UDP socket, connects it to the NTP server endpoint, and sets the receive timeout.
        $socket = New-Object System.Net.Sockets.Socket([System.Net.Sockets.AddressFamily]::InterNetwork, [System.Net.Sockets.SocketType]::Dgram, [System.Net.Sockets.ProtocolType]::Udp)
        $socket.Connect($ipEndPoint)
        $socket.ReceiveTimeout = 3000

        # This sends the NTP request packet to the server and receives the response into the same byte array. The socket is then closed.
        $socket.Send($ntpData) | Out-Null
        $socket.Receive($ntpData) | Out-Null
        $socket.Close()
        $ConnectionError = $null
    }
    catch {
        $ConnectionError = $_.Exception.Message
    }
    finally {
        # Reset Error Action Preference
        $ErrorActionPreference = $previousEA
        if ($ConnectionError) {
            throw $ConnectionError
        }
    }


    # This extracts the integer and fractional parts of the timestamp from the NTP response. The timestamp is stored in bytes 40-47 of the response packet. 
    # The byte indexes are shifted left indexes of 24, 16, & 8, then the bitwise OR operation combines the shifted values and the final byte into a single 32-bit integer.
    # $intPart represents the number of seconds since 1900-01-01
    $intPart = ([ulong]$ntpData[40] -shl 24) -bor ([ulong]$ntpData[41] -shl 16) -bor ([ulong]$ntpData[42] -shl 8) -bor $ntpData[43]
    # $fractPart part represents the fractional seconds
    $fractPart = ([ulong]$ntpData[44] -shl 24) -bor ([ulong]$ntpData[45] -shl 16) -bor ([ulong]$ntpData[46] -shl 8) -bor $ntpData[47]

    # This converts the extracted timestamp into milliseconds
    <#
    $intPart * 1000:
        - $intPart is the integer part of the NTP timestamp, representing the number of seconds since January 1, 1900.
        - Multiplying $intPart by 1000 converts it from seconds to milliseconds.

    $fractPart * 1000 / 0x100000000L:
        - $fractPart is the fractional part of the NTP timestamp.
        - The fractional part is originally a 32-bit fixed-point number where the fraction represents the fractional part of a second.
        - Multiplying $fractPart by 1000 scales the fraction to milliseconds.
        - Dividing by 0x100000000L (which is 232232 or 4294967296 in decimal) converts the 32-bit fraction to its proper value in milliseconds.

    Add the converted integer part (in milliseconds) and the converted fractional part (in milliseconds) to get the total milliseconds since January 1, 1900.
    #>
    $milliseconds = $intPart * 1000 + $fractPart * 1000 / 0x100000000L

    # Adds the milliseconds to the base date of 1900-01-01 to get the current date and time.
    $UtcTime = [DateTime]::new(1900, 1, 1).AddMilliseconds([long]$milliseconds)

    # Convert to local time if the ToLocalTime switch is used.
    if($ToLocalTime){
        $UtcTime.ToLocalTime()
    }
    else{
        $UtcTime
    }
}