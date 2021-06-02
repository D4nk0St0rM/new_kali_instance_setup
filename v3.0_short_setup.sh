#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0ve & kn0wledge #### #### #### ####
# Create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)
# Use the following for password-less privesc : sudo apt-get install -y -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### Enable debug mode
#set -x

#### Run As Root - release if you want to run as root only install
#if [ "$HOME" != "/root" ]
#then
#    printf "This is to run as root... later gater\n"
#    exit 1
#fi


#### update sources.list
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo mv sources.list /etc/apt/sources.list
#### Add repo keys
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo tee -a /usr/share/keyrings/protonvpn.asc

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

#### some basic installs and config
sudo apt-get install -y figlet -y 2>/dev/null
sudo apt-get install -y toilet -y 2>/dev/null
sudo apt-get install -y tree -y 2>/dev/null
# sudo dpkg-reconfigure locales - requires manual intervention
sudo setxkbmap -layout gb



#### skip prompts in apt-upgrade, etc.
export DEBIAN_FRONTEND=noninteractive
alias apt-get='yes "" | apt-get -o Dpkg::Options::="--force-confdef" -y'

#### sudo no passwd - manual
sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### welcome messages
printf "${GREEN}"
toilet -f future -F border D4nk0St0rM --filter metal
printf "${NC}"
toilet -f future -F border 'spread l0ve & kn0wlege' --filter metal 
printf "${CYAN}"
printf "${NC}"


#### Update
figlet -c update
sudo apt update && sudo apt -y upgrade

#### install transport protocol
sudo apt-get install -y apt-transport-https

echo -e "${GREEN}================== install some things =======================${NC}"

#### wallpaper
sudo mkdir -p '/usr/share/wallpapers/wallpapers/' &>/dev/null
sudo wget -P '/usr/share/wallpapers/wallpapers/' https://github.com/D4nk0St0rM/new_kali_instance_setup/raw/main/images/Kalicarbon.jpg

#### terminal
sudo apt-get install -y terminator

#### folder management
figlet -c folders
rm -r  Music/ Public/ Videos/ Templates/ Desktop/ &>/dev/null
mkdir -p scripts &>/dev/null
mkdir -p oscp/lab_connect &>/dev/null
mkdir -p oscp/megacorpone/dns_ip/boxes &>/dev/null

sudo cp .zshrc .zshrc__
sudo rm .zshrc
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && sleep 10 && touch ~/.hushlogin
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo 'exec zsh' >> ~/.bashrc


sudo cp .zshrc .zshrc__
sudo rm .zshrc
sudo wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/.zshrc_2
mv .zshrc_2 ~/.zshrc


#### wifite dependancies
figlet -c configs
toilet -f term -F border --gay "wifite dependancies"
sudo apt-get install -y -y libcurl4-openssl-dev libssl-dev zlib1g-dev
sudo apt-get install -y libpcap-dev
toilet -f term -F border --gay "hcxtools"
sudo git clone https://github.com/ZerBea/hcxtools /opt/hcxtools
toilet -f term -F border --gay "hcxdumptool"
sudo git clone https://github.com/ZerBea/hcxdumptool /opt/hcxdumptool
toilet -f term -F border --gay "make and install hcxtools and hcxdumptool"
cd /opt/hcxtools
sudo make
sudo make install
cd /opt/hcxdumptool
sudo make
sudo make install
cd ~/

#### Python & Virtual Environments - optional
toilet -f term -F border --gay "some python set up and virtual envs"
sudo apt-get install -y python2.7
curl https://bootstrap.pypa.io/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo apt-get install python3-pip -y
sudo apt-get install python-dev -y
curl https://bootstrap.pypa.uo/get-pip.py --output get-pip.py
sudo python3 get-pip.py

#### application install
figlet -c applications
toilet -f term -F border --gay "libpcap-dev libcurl4-openssl-dev libssl-dev"
sudo apt-get install -y libpcap-dev libcurl4-openssl-dev libssl-dev 2>/dev/null
toilet -f term -F border --gay "htop"
sudo apt-get install -y htop 2>/dev/null
toilet -f term -F border --gay "hexedit"
sudo apt-get install -y hexedit 2>/dev/null
toilet -f term -F border --gay "exif"
sudo apt-get install -y exif 2>/dev/null
toilet -f term -F border --gay "git"
sudo apt-get install git -y 2>/dev/null
toilet -f term -F border --gay "dbus-x11"
sudo apt-get install dbus-x11 -y 2>/dev/null
toilet -f term -F border --gay "linux-headers"
sudo apt-get install linux-headers-$(uname -r) -y 2>/dev/null
toilet -f term -F border --gay "dnsutils"
sudo apt-get install dnsutils -y 2>/dev/null
toilet -f term -F border --gay "exiftool"
sudo apt-get install  exiftool -y 2>/dev/null
toilet -f term -F border --gay "openvpn"
sudo apt-get install openvpn -y 2>/dev/null
toilet -f term -F border --gay "dialog"
sudo apt-get install dialog -y 2>/dev/null
toilet -f term -F border --gay "protonvpn"
sudo apt-get install -y protonvpn-cli 2>/dev/null
sudo apt-get install -y protonvpn 2>/dev/null
toilet -f term -F border --gay "terminator"
sudo apt-get install -y terminator 2>/dev/null
toilet -f term -F border --gay "openvpn"
sudo apt-get install -y openvpn 2>/dev/null
toilet -f term -F border --gay "powercat"
sudo apt-get install -y powercat 2>/dev/null
toilet -f term -F border --gay "joplin"
sudo apt-get install -y joplin 2>/dev/null
toilet -f term -F border --gay "chrome"
sudo apt-get install -y google-chrome-stable
toilet -f term -F border --gay "theHarvester"
sudo apt-get install -y theHarvester 2>/dev/null
toilet -f term -F border --gay "seclists"
sudo apt-get install -y seclists 2>/dev/null
toilet -f term -F border --gay "exploitdb"
sudo apt-get install -y exploitdb
toilet -f term -F border --gay "searchsploit"
searchsploit -u
toilet -f term -F border --gay "shellter"
sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install -y wine32 && sudo apt-get install -y shellter
toilet -f term -F border --gay "net-tools"
sudo apt-get install -y net-tools 2>/dev/null
toilet -f term -F border --gay "rinetd port forwarding"
sudo apt-get install -y rinetd 2>/dev/null
toilet -f term -F border --gay "httptunnel"
sudo apt-get install -y httptunnel 2 >/dev/null
toilet -f term -F border --gay "bettercap dependancies"
sudo apt-get install -y libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev 2>/dev/null
toilet -f term -F border --gay "tempomail"
wget https://github.com/D4nk0St0rM/oscp_ethical_hacking/blob/main/tools/linux-amd64-tempomail.tgz
tar -xzvf linux-amd64-tempomail.tgz
sudo mv tempomail /usr/local/bin/
sudo rm linux-amd64-tempomail.tgz

toilet -f term -F border --gay "enum4linux"
sudo apt-get install -y enum4linux 2>/dev/null
toilet -f term -F border --gay " twofi"
sudo apt-get install -y twofi 2>/dev/null
toilet -f term -F border --gay "nbtscan"
sudo apt-get install -y nbtscan 2>/dev/null
toilet -f term -F border --gay "kerberoast"
sudo apt-get install -y kerberoast 2>/dev/null


### git clones
figlet -c GitClones
cd /opt/
toilet -f term -F border --gay "git clone h8mail"
sudo git clone https://github.com/khast3x/h8mail /opt/h8mail
toilet -f term -F border --gay "git clone nmapautomator"
sudo git clone https://github.com/21y4d/nmapAutomator.git /opt/nmapAutomator
toilet -f term -F border --gay "git clone subbrute"
sudo git clone https://github.com/TheRook/subbrute.git /opt/subbrute 2>/dev/null
toilet -f term -F border --gay "git clone windows exploit suggester"
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git /opt/windows-exploit-suggester 2>/dev/null
toilet -f term -F border --gay "git clone priv-esc-scripts"
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/priv-esc-scripts 2>/dev/null
toilet -f term -F border --gay "git clone sublist3r"
sudo git clone https://github.com/aboul3la/Sublist3r.git /opt/sublist3r 2>/dev/null
toilet -f term -F border --gay "git clone gobuster"
sudo git clone https://github.com/OJ/gobuster.git /opt/gobuster 2>/dev/null
toilet -f term -F border --gay "git clone Windows-Exploit-Suggester"
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git /opt/Windows-Exploit-Suggester
toilet -f term -F border --gay "git clone privilege-escalation-awesome-scripts-suite"
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/privilege-escalation-awesome-scripts-suite

#### final clean up
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y


printf ${GREEN}
figlet -c D4nk0St0rM
printf ${CYAN}
figlet -c spread l0v3 share kn0wl3dge
printf ${NC}
source ~/.zshrc
