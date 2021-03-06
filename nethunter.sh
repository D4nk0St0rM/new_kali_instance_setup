#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0v3, share kn0wl3dge #### #### #### ####
sudo apt-get install toilet
sudo apt-get install figlet

#### set variables for use in paths
curuse=$(whoami)
mytools="/opt/mytools"

#### copy sources.list from git and replace
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bakup
sudo cp sources.list /etc/apt/sources.list
rm sources.list

#### Language setting
sudo setxkbmap -layout gb
mkdir -p /opt/mytools 2>/dev/null
mytools="/opt/mytools"
mkdir -p ~/Downloads 2>/dev/null

echo -e "${RED}============================================================${NC}"
echo -e "${RED}============================================================${NC}"
echo -e "${GREEN}==================Update the system=========================${NC}"
echo -e "${RED}============================================================${NC}"
echo -e "${RED}============================================================${NC}"
sudo apt-get update -y
sudo apt-get dist-upgrade -y

#### Lets install some additional progs and apps
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

toilet -f term -F border --gay "git"
sudo apt-get install git -y 2>/dev/null
toilet -f term -F border --gay "dbus-x11"
sudo apt-get install dbus-x11 -y 2>/dev/null
toilet -f term -F border --gay "linux-headers"
sudo apt-get install linux-headers-$(uname -r) -y 2>/dev/null
toilet -f term -F border --gay "hcxdumptool"
sudo apt-get install hcxdumptool -y 2>/dev/null
toilet -f term -F border --gay "hcxtools"
sudo apt-get install hcxtools -y 2>/dev/null
toilet -f term -F border --gay "dnsutils"
sudo apt-get install dnsutils -y 2>/dev/null
toilet -f term -F border --gay "exiftool"
sudo apt-get install  exiftool -y 2>/dev/null
toilet -f term -F border --gay "openvpn"
sudo apt-get install openvpn -y 2>/dev/null
toilet -f term -F border --gay "dialog"
sudo apt-get install dialog -y 2>/dev/null
toilet -f term -F border --gay "protonvpn"
sudo apt-get install protonvpn-cli -y 2>/dev/null
sudo apt-get update && sudo apt-get install protonvpn 2>/dev/null

echo -e "${RED}============================================================${NC}"
echo -e "${RED}============================================================${NC}"
echo -e "${GREEN}================ Update the system =========================${NC}"
echo -e "${RED}============================================================${NC}"
echo -e "${RED}============================================================${NC}"
sudo apt-get update -y
sudo apt-get autoremove -y

echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"

#### Lets install some additional progs and apps
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

toilet -f term -F border --gay "realtek-rtl88xxau-dkm"
sudo apt-get install -y realtek-rtl88xxau-dkms 2>/dev/null

toilet -f term -F border --gay "golang"
sudo apt-get install -y golang 2>/dev/null

toilet -f term -F border --gay "net-tools"
sudo apt-get install -y net-tools 2>/dev/null

toilet -f term -F border --gay "htop"
sudo apt-get install -y htop 2>/dev/null

toilet -f term -F border --gay "nfs-kernel-server"
sudo apt-get install -y nfs-kernel-server 2>/dev/null

toilet -f term -F border --gay "dnsmasq"
sudo apt-get install -y dnsmasq 2>/dev/null

printf ${GREEN}
figlet git clones
printf ${NC}
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}============================ - bettercap  ====================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

sudo apt-get install libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev 2>/dev/null
go get -v github.com/bettercap/bettercap

echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}============================ - SecLists  =====================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo apt-get install seclists -y 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}============================ - h8mail  =======================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/khast3x/h8mail $mytools/h8mail 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}=========================== - discover =======================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/leebaird/discover $mytools/discover 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - nmapautomator =====================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/21y4d/nmapAutomator.git $mytools/nmapAutomator 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - subbrute ==========================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/TheRook/subbrute.git $mytools/subbrute 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - theHarvester ======================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/laramies/theHarvester.git $mytools/theHarvester 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - windows exploit suggester =========${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git $mytools/windows-exploit-suggester 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - nmap vulners ======================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/vulnersCom/nmap-vulners.git /usr/share/nmap/scripts/vulners 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - priv esc scripts ==================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git $mytools/priv-esc-scripts 2>/dev/null


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - sublist3r =========================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/aboul3la/Sublist3r.git $mytools/sublist3r 2>/dev/null



echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - sherlock ==========================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/sherlock-project/sherlock.git $mytools/sherlock 2>/dev/null
python3 -m pip install -r $mytools/sherlock/requirements.txt



echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - windows reverse shell==============${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/Dhayalanb/windows-php-reverse-shell.git $mytools/windows-reverse-shell 2>/dev/null



echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - gobuster ==========================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/OJ/gobuster.git $mytools/gobuster 2>/dev/null



echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}======================== - ffuf ==============================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
sudo git clone https://github.com/ffuf/ffuf.git $mytools/ffuf 2>/dev/null

figlet -c New Install Section
##### new additional tools
toilet -f term -F border --gay "git clone robots disallowed"
sudo git clone https://github.com/D4nk0St0rM/RobotsDisallowed.git /opt/mytools/robotsdisallowed 2>/dev/null

toilet -f term -F border --gay "git clone fimap"
sudo git clone https://github.com/kurobeats/fimap.git /opt/mytools/fimap 

toilet -f term -F border --gay "git clone dirsearch"
sudo git clone https://github.com/maurosoria/dirsearch.git /opt/mytools/dirsearch

echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}============= the cats are wearing the hats ==================${NC}"
echo -e "${GREEN}============== system update and clean up ====================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

sudo apt-get update -y 
sudo apt-get upgrade -y 
sudo apt-get autoremove -y




echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}                                                            ${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}============= Reboot, grab a coffee ==========================${NC}"
echo -e "${GREEN}======= consider install paid licence items ==================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

printf ${GREEN}
figlet -c D4nk0St0rM
printf ${CYAN}
figlet -c spread l0v3 share kn0wl3dge
printf ${NC}
