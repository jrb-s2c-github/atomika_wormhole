Param (
        [Parameter(Mandatory=$true)][string]$MachineName 
)


New-VM -Name $MachineName -MemoryStartupBytes 4GB -NewVHDPath $MachineName+'.vhdx' -NewVHDSizeBytes 20GB -SwitchName 'Default Switch' 
Set-VM -Name $MachineName -ProcessorCount 4 -StaticMemory 
Add-VMDvdDrive -VMName "$MachineName" -Path ubuntu-22.04-atomika-autoinstall_V5_1.iso
Start-VM -Name $MachineName 

$IP = 'NOT_SET'
DO
{
 Start-Sleep -Seconds 5
 [Microsoft.HyperV.PowerShell.VMNetworkAdapterBase]$IPAddress = Get-VM -Name $MachineName | select -ExpandProperty NetworkAdapters 
 $IP = $IPAddress.IPAddresses[0]
} WHILE (! $IP)

Set-Service   ssh-agent -StartupType Automatic
Start-Service ssh-agent
Start-Process ssh-add ..\..\ansible
Start-Process ssh -ArgumentList ('ansible@' + $IP)