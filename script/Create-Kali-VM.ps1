# Create-Kali-VM.ps1
param(
    [string]$VmName = "Kali Linux",
    [string]$IsoPath = "C:\Downloads\kali-linux-2025.4-installer-amd64.iso",
    [int]$RamMB = 4096,
    [int]$CpuCount = 2,
    [int]$DiskSizeGB = 40,
    [string]$VboxManagePath = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
)

# Check if VBoxManage exists
if (-not (Test-Path $VboxManagePath)) {
    Write-Error "VirtualBox not found at $VboxManagePath"
    exit 1
}

# Check ISO
if (-not (Test-Path $IsoPath)) {
    Write-Error "ISO not found at $IsoPath"
    exit 1
}

Write-Host "Creating VM '$VmName'..." -ForegroundColor Green

# Create VM
& $VboxManagePath createvm --name "$VmName" --ostype "Debian_64" --register

# Set system settings
& $VboxManagePath modifyvm "$VmName" --memory $RamMB --cpus $CpuCount --vram 128 --accelerate3d on --graphicscontroller vmsvga

# Create virtual disk
$diskPath = "$env:USERPROFILE\VirtualBox VMs\$VmName\$VmName.vdi"
& $VboxManagePath createmedium disk --filename "$diskPath" --size ($DiskSizeGB * 1024) --format VDI --variant Standard

# Attach storage
& $VboxManagePath storagectl "$VmName" --name "SATA Controller" --add sata --controller IntelAhci
& $VboxManagePath storageattach "$VmName" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$diskPath"

# Attach IDE controller for DVD
& $VboxManagePath storagectl "$VmName" --name "IDE Controller" --add ide
& $VboxManagePath storageattach "$VmName" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$IsoPath"

# Network: NAT
& $VboxManagePath modifyvm "$VmName" --nic1 nat

# Enable audio (optional)
& $VboxManagePath modifyvm "$VmName" --audioout on

# Start VM
Write-Host "Starting VM '$VmName'..." -ForegroundColor Green
& $VboxManagePath startvm "$VmName"

Write-Host "VM created and started successfully!" -ForegroundColor Green
