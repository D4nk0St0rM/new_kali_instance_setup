#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0v3, share kn0wl3dge #### #### #### ####
# Created after some inspiration from https://github.com/blacklanternsecurity/kali-setup-script
# Create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)
# Use the following for password-less privesc : sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### Enable debug mode
#set -x

#### change region to UK
sudo setxkbmap -layout gb

#### update sources.list
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo mv sources.list /etc/apt/sources.list

#### Add repo keys
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo tee -a /usr/share/keyrings/protonvpn.asc


#### Update
sudo apt-get update


#### install some basic tools
sudo apt-get install figlet -y 2>/dev/null
sudo apt-get install toilet -y 2>/dev/null
sudo apt-get install tree -y 2>/dev/null

#### set up some colour referencing to change outputs depending on your preferences
RED='\e[1;31m'
NC='\e[0m' # No Color
reset_colour='\e[0m'
RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
PURPLE='\e[1;35m'
CYAN='\e[1;36m'

#### welcome messages
printf "${GREEN}"
toilet -f future -F border D4nk0St0rM --filter metal
printf "${NC}"
toilet -f future -F border 'spread l0ve & kn0wlege' --filter metal 
printf "${CYAN}"
printf "${NC}"


#### Run As Root - release if you want to run as root only install
#if [ "$HOME" != "/root" ]
#then
#    printf "This is to run as root... later gater\n"
#    exit 1
#fi

#### set variables for use in paths
curuse=$(whoami)
mytools="/opt"
virtenv="~/.virtualenv"

### install kde-desktop
sudo apt-get install -y kali-desktop-kde
# requires reboot
# Select sddm display manager and press Enter
# sudo apt remove kali-desktop-xfce xfce4* lightdm*
# sudo apt autoremove


#### Check KDE Version for config changes
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


#### install transport protocol
sudo apt-get install apt-transport-https

#### another update
toilet -f term -F border --gay "apt-get update for good measure"
sudo apt-get update


echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}================== Install some things =======================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"


####install visual code studio
echo -e "${RED}==============================================================${NC}"
toilet -f term -F border --gay "Microsoft Visual Code Studio"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install code


#### Tweaking the themeing and look
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}========Running in background...........======================${NC}"
echo -e "${GREEN}==================== - tweaking the theme=====================${NC}"
echo -e "${GREEN}==================== - setting language & text editor=========${NC}"
echo -e "${GREEN}==================== - clean up and create folders============${NC}"
echo -e "${GREEN}==================== - install python pip=====================${NC}"
echo -e "${GREEN}==================== - install python virtualenvs ============${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${GREEN}============= !!Why is pip not already installed!! ===========${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"
echo -e "${RED}==============================================================${NC}"

sudo mkdir -p '/usr/share/wallpapers/wallpapers/' &>/dev/null

wallpaper_file="$(find . -type f -name Kali_dark_shadow_eye.jpg)"
if [[ -z "$wallpaper_file" ]]
        then
                sudo wget -P '/usr/share/wallpapers/wallpapers/' https://github.com/D4nk0St0rM/general_linux_notes/raw/main/wallpaper/Kali_dark_shadow_eye.jpg
        else
                sudo cp "$wallpaper_file" '/usr/share/wallpapers/wallpapers/Kali_dark_shadow_eye.jpg'
fi



#### commandline with oh-my-zsh
toilet -f term -F border --gay "... oh my zsh ..."
git clone http://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf 
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
cp ~/.zshrc ~/.zshrc_
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/.zshrc
mv .zshrc ~/.zshrc

#### A litte folder & file management
toilet -f term -F border --gay "... folder management ..."
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
rm -r  ~/Music ~/Public ~/Videos ~/Templates ~/Desktop &>/dev/null
mkdir -p ~/webserver 2>/dev/null
mkdir -p ~/scripts 2>/dev/null
mkdir -p ~/tempwork 2>/dev/null
mkdir -p ~/general 2>/dev/null
mkdir -p ~/.virtualenv 2>/dev/null
virtenv="~/.virtualenv"
mkdir -p ~/Downloads 2>/dev/null
mkdir -p ~/Documents 2>/dev/null
wget https://github.com/D4nk0St0rM/oscp_ethical_hacking/raw/main/reporting/box_name_IP_template_v2.1.ctb
mv *.ctb ~/Documents/

#### application install
sudo apt-get install -y libpcap-dev libcurl4-openssl-dev libssl-dev
sudo apt-get install -y htop 
sudo apt-get install -y hexedit 
sudo apt-get install -y exiftool 
sudo apt-get install -y exif 
sudo apt-get install -y openvpn
sudo apt install -y libcurl4-openssl-dev libssl-dev zlib1g-dev
sudo git clone https://github.com/ZerBea/hcxtools /opt/hcxtools
sudo git clone https://github.com/ZerBea/hcxdumptool /opt/hcxdumptool
cd /opt/hcxtools
sudo make
sudo make install
cd /opt/hcxdumptool
sudo make
sudo make install
cd ~/
