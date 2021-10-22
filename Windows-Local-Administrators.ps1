# Logs and timestamp
$location = Get-Location
$timeStamp = Get-Date -Format yyyyMMdd-hhmmss
Write-Host

# Load Active Directory Module
if (!(Get-Module ActiveDirectory)) {Import-Module ActiveDirectory}

# Get list of servers
$Servers = Get-ADComputer -properties OperatingSystem -Filter 'OperatingSystem -like "windows*server*"' | Where-Object {$_.DistinguishedName -notlike "*Domain Controllers*"} | sort DNSHostName | select DNSHostName -ExpandProperty DNSHostName
Write-Host
Write-Host "Ping each computer:"
$ServersUp = @()
ForEach ($server in $Servers){
    if ((Test-Connection $server -Quiet) -eq $True){
        Write-Host -ForegroundColor Green "$server ping ok."
        $ServersUp += $server
    }
    else{
        Write-Host -ForegroundColor red "$server ping fails. Will be skipped."
    }
}

invoke-command {
    $members = net localgroup administrators |
    where {$_ -AND $_ -notmatch "command completed successfully"} |
    select -skip 4
    New-Object PSObject -Property @{
        Computername = [System.Net.DNS]::GetHostByName('').HostName
        Group = "Administrators"
        Members=$members
    }
} -computer $ServersUp -HideComputerName |
Select Computername,@{N='Members';E={($_.Members) -join ';'}} -ExcludeProperty RunspaceID,PSShowComputerName,PSComputerName | 
Export-CSV -NoTypeInformation -Append $location\Local_Administrators_$timeStamp.csv
Write-Host
Write-Host "Collect the report at $location\Local_Administrators_$timeStamp.csv"
