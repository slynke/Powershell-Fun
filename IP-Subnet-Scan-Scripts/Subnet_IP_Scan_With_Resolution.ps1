# Subnet_IP_Scan_With_Resolution.ps1

# Define the subnet to scan
$subnet = "192.168.1"

# Loop through IP range 1-254
1..254 | ForEach-Object {
    $ip = "$subnet.$_"

    # Ping the IP address
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {

        # Attempt to resolve hostname
        try {
            $hostname = ([System.Net.Dns]::GetHostEntry($ip)).HostName
        } catch {
            $hostname = "N/A"
        }

        # Output result
        [PSCustomObject]@{
            IP       = $ip
            Hostname = $hostname
            Status   = "Online"
        }
    }
} | Format-Table -AutoSize
