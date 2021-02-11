#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0v3, share kn0wl3dge #### #### #### ####

# Created after some inspiration from https://github.com/blacklanternsecurity/kali-setup-script
# Create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)

RED='\e[1;31m'
NC='\e[0m' # No Color
reset_colour='\e[0m'
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
PURPLE='\e[1;35m'
CYAN='\e[1;36m'

echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${GREEN}============== D4nk0St0rM ==========================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${GREEN}======== Push up your glasses Mr Magoo... ==========${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${GREEN}======== spread l0v3, share kn0wl3dge ==============${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"
echo -e "${RED}====================================================${NC}"


#### Run As Root - release if you want to run as root only install
#if [ "$HOME" != "/root" ]
#then
#    printf "This is to run as root... later gater\n"
#    exit 1
#fi

curuse=$(whoami)

#### Check KDE Version
if [ "`which kwriteconfig5`" ]; then
    KWRITECONF=kwriteconfig5
    HOTKEYS="$HOME/.config/khotkeysrc"
    PLASMADESK="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
    KDEVER=5
else
    KWRITECONF=kwriteconfig
    HOTKEYS="$HOME/.kde/share/config/khotkeysrc"
    PLASMADESK="$HOME/.kde/share/config/plasma-desktop-appletsrc"
    KDEVER=4
fi

#### skip prompts in apt-upgrade, etc.
export DEBIAN_FRONTEND=noninteractive
alias apt-get='yes "" | apt-get -o Dpkg::Options::="--force-confdef" -y'

#### copy sources.list from git and replace
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bakup
sudo cp sources.list /etc/apt/sources.list
rm sources.list

sudo apt-get update

#### Tweaking the themeing and look
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}========Running in background...........======================${NC}"
echo -e "${GREEN}==================== - tweaking the theme=====================${NC}"
echo -e "${GREEN}==================== - setting language & text editor=========${NC}"
echo -e "${GREEN}==================== - clean up and create folders============${NC}"
echo -e "${GREEN}==================== - install python pip=====================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}=============!!WHY THE PHUQ IS PIP NOT HERE!!=================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"




mkdir -p '/usr/share/wallpapers/wallpapers/' &>/dev/null


wallpaper_file="$(find . -type f -name Kali_dark_shadow_eye.jpg)"
if [[ -z "$wallpaper_file" ]]
	then
		sudo wget -P '/usr/share/wallpapers/wallpapers/' https://raw.githubusercontent.com/D4nk0St0rM/simple_linux_tweaks/main/wallpaper/Kali_dark_shadow_eye.jpg
	else
		sudo cp "$wallpaper_file" '/usr/share/wallpapers/wallpapers/Kali_dark_shadow_eye.jpg'
fi

#### .config/kdeglobals
${KWRITECONF} --file kdeglobals --group "KDE-Global GUI Settings" --key "GraphicEffectsLevel" 0
${KWRITECONF} --file kdeglobals --group "General" --key "ColorScheme" "BreezeDark"
${KWRITECONF} --file kdeglobals --group "General" --key "Name" "Kali-Dark"
${KWRITECONF} --file kdeglobals --group "General" --key "shadeSortColumn" "true"
${KWRITECONF} --file kdeglobals --group "Icons" --key "Theme" "Flat-Remix-Blue-Dark"
${KWRITECONF} --file kdeglobals --group "KDE" --key "ColorScheme" "KaliDark"
${KWRITECONF} --file kdeglobals --group "KDE" --key "SingleClick" "false"
${KWRITECONF} --file kdeglobals --group "KDE" --key "widgetStyle" "Oxygen"
${KWRITECONF} --file plasmarc --group "Wallpapers" --key "usersWallpapers" "/home/$curuse/Pictures/Kali_dark_shadow_eye.jpg"
${KWRITECONF} --file plasmarc --group "Theme" --key "name" "breeze-dark"

#### Language setting
sudo setxkbmap -layout gb

#### Set default text editor
echo "export EDITOR=/usr/bin/nano" >> ~/.zshrc
echo "export VISUAL=/usr/bin/nano" >> ~/.zshrc

#### A litte folder management
rmdir ~/Music ~/Public ~/Videos ~/Templates ~/Desktop &>/dev/null
mkdir -p ~/Documents/vhl 2>/dev/null
mkdir -p ~/Documents/htb 2>/dev/null
mkdir -p ~/Documents/general 2>/dev/null
mkdir -p ~/.virtualenv 2>/dev/null
mkdir -p /opt/mytools 2>/dev/null
mytools="/opt/mytools"
virtenv="~/.virtualenv"
mkdir -p ~/Downloads 2>/dev/null
curl https://bootstrap.pypa.io/2.7/get-pip.py --output get-pip.py
sudo python get-pip.py
rm get-pip.py

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
echo -e "${GREEN}=================================== - git ====================${NC}"
echo -e "${GREEN}=================================== - dbus-x11 ===============${NC}"
echo -e "${GREEN}=================================== - linux-headers ==========${NC}"
echo -e "${GREEN}=================================== - hcxdumptool ============${NC}"
echo -e "${GREEN}=================================== - hcxtools ===============${NC}"
echo -e "${GREEN}=================================== - dnsutils ===============${NC}"
echo -e "${GREEN}=================================== - exiftool ===============${NC}"
echo -e "${GREEN}=================================== - openvpn ================${NC}"
echo -e "${GREEN}=================================== - dialog =================${NC}"
echo -e "${GREEN}=================================== - protonvpn ==============${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

sudo apt-get install \
    git \
    dbus-x11 \
    linux-headers-$(uname -r) \
    hcxdumptool \
    hcxtools \
    dnsutils \
    exiftool \
    openvpn \
    dialog \
    protonvpn-cli


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

echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Installing....... =========================${NC}"
echo -e "${GREEN}=========================== - realtek drivers ================${NC}"
echo -e "${GREEN}=========================== - golang =========================${NC}"
echo -e "${GREEN}=========================== - docker.io ======================${NC}"
echo -e "${GREEN}=========================== - powershell =====================${NC}"
echo -e "${GREEN}=========================== - terminator =====================${NC}"
echo -e "${GREEN}=========================== - python3dev  ====================${NC}"
echo -e "${GREEN}=========================== - python3pip =====================${NC}"
echo -e "${GREEN}=========================== - patator ========================${NC}"
echo -e "${GREEN}=========================== - net-tools ======================${NC}"
echo -e "${GREEN}=========================== - zmap ===========================${NC}"
echo -e "${GREEN}=========================== - htop ===========================${NC}"
echo -e "${GREEN}=========================== - mosh ===========================${NC}"
echo -e "${GREEN}=========================== - tmux ===========================${NC}"
echo -e "${GREEN}=========================== - nfs kernal server ==============${NC}"
echo -e "${GREEN}=========================== - dnsmasq ========================${NC}"
echo -e "${GREEN}=========================== - hcxtools =======================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

sudo apt-get install -y \
    realtek-rtl88xxau-dkms \
    golang \
    docker.io \
    powershell \
    terminator \
    python3-dev \
    python3-pip \
    patator \
    net-tools \
    zmap \
    htop \
    mosh \
    tmux \
    nfs-kernel-server \
    dnsmasq \
    hcxtools 

sudo pip install --upgrade setuptools
python2 -m pip install pipenv
python3 -m pip install pipenv

# default tmux config
cat <<EOF > ~/.tmux.conf
set -g mouse on
set -g history-limit 20000
EOF

mkdir -p ~/.go
gopath_exp='export GOPATH="$HOME/.go"'
path_exp='export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"'
sed -i '/export GOPATH=.*/c\' ~/.profile
sed -i '/export PATH=.*GOPATH.*/c\' ~/.profile
echo $gopath_exp | tee -a "$HOME/.profile"
grep -q -F "$path_exp" "$HOME/.profile" || echo $path_exp | tee -a "$HOME/.profile"
. "$HOME/.profile"

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
echo -e "${GREEN}==================== D4nk0St0rM ==============================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}=========== spread l0v3, share kn0wl3dge =====================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
