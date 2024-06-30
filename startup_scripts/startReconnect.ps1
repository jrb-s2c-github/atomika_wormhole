Param (
        [Parameter(Mandatory=$true)][string]$MachineName 
)


[bool]$HasBeenStarted = $false
DO
{
 #Start-Sleep -Seconds 5
 [Microsoft.HyperV.PowerShell.VMNetworkAdapterBase]$IPAddress = Get-VM -Name $MachineName | select -ExpandProperty NetworkAdapters 
 $IP = $IPAddress.IPAddresses[0]

 if (! $IP -and ! $HasBeenStarted) {
  Start-VM -Name $MachineName 
  $HasBeenStarted = $true
 }
} WHILE (! $IP)

Set-Service   ssh-agent -StartupType Automatic
Start-Service ssh-agent
Start-Process ssh-add ..\..\ansible

Start-Process ssh -ArgumentList ('ansible@' + $IP)