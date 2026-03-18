# Kali Linux on Windows using VirtualBox (Manual Installation)

**By RobbieJr**  
A complete step-by-step guide to install Kali Linux on Windows 10/11 using VirtualBox.  
Perfect for penetration testing with full network access and no proot limitations.

## 📋 Prerequisites

- Windows 10/11 (64-bit)
- At least **4GB RAM** (8GB+ recommended)
- **25GB free disk space** (40GB+ recommended)
- Virtualization enabled in BIOS

### ✅ Enable Virtualization

1. Restart your computer.
2. Press **F2/DEL/F12** during boot (varies by manufacturer) to enter BIOS/UEFI.
3. Find and enable:
   - **Intel:** VT-x, Intel Virtualization Technology
   - **AMD:** AMD-V, SVM Mode
4. Save and exit.

---

## 🚀 Step-by-Step Installation

### Step 1: Download Required Files

| Software | Download Link | Notes |
|----------|---------------|-------|
| **VirtualBox** | [Download](https://www.virtualbox.org/wiki/Downloads) | Choose "Windows hosts" |
| **Kali Linux ISO** | [Download](https://www.kali.org/get-kali/#kali-installer-images) | Select "Installer Images" → 64-bit |

> 💡 **Tip:** Save both files in an easy-to-find folder, e.g., `C:\Downloads\Kali`.

### Step 2: Install VirtualBox

1. Run the installer as Administrator.
2. Keep all default settings.
3. Click **Yes** if prompted about network interfaces.
4. Complete installation.

### Step 3: Create a New Virtual Machine

#### Using VirtualBox GUI (Manual)

1. Open **VirtualBox** → Click **New** (or `Ctrl+N`).
2. **Name:** `Kali Linux`
3. **Folder:** (default is fine)
4. **ISO Image:** Browse and select your downloaded Kali ISO.
5. **Type:** Linux
6. **Version:** Debian (64-bit)
7. Click **Next**.

#### Configure Resources

- **Memory:** 4096 MB (4GB) or more if available.
- **Processors:** 2-4 (depending on your CPU).
- **Virtual Hard Disk:** 
  - Select **"Create a virtual hard disk now"**
  - **Disk size:** 40 GB (dynamically allocated)
  - **File type:** VDI
  - Click **Finish**.

### Step 4: Adjust VM Settings (Optional but Recommended)

1. Select the VM → **Settings**.
2. **System** → **Processor** → Enable **PAE/NX**.
3. **Display**:
   - **Video Memory:** 128 MB
   - **Graphics Controller:** VMSVGA
   - Enable **3D Acceleration**
4. **Network**:
   - Adapter 1: **NAT** (for internet access)
   - (Optional) Adapter 2: **Bridged** for local network access
5. Click **OK**.

### Step 5: Start Installation

1. Click **Start**.
2. From the boot menu, select **"Graphical install"**.
3. Follow the installer prompts:

| Step | Selection |
|------|-----------|
| Language | Your preference |
| Location | Your country |
| Keyboard | Your layout |
| Hostname | `kali` |
| Domain | (leave blank) |
| Root password | Choose a strong password |
| User account | Create a regular user (optional) |
| Partition disks | **Guided – use entire disk** → select virtual disk → **All files in one partition** → Finish |
| Software selection | ✅ Kali Linux Desktop (Xfce) ✅ Kali Linux Default tools ✅ Standard system utilities |
| Install GRUB | Yes → select `/dev/sda` |

4. When installation completes, the VM will reboot.

### Step 6: First Login & Updates

1. Log in with the credentials you set.
2. Open a terminal (`Ctrl+Alt+T`).
3. Update the system:

```bash
sudo apt update && sudo apt full-upgrade -y
