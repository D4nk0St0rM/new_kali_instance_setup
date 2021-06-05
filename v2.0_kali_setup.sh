#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0ve & kn0wledge #### #### #### ####
# Created after some inspiration from https://github.com/blacklanternsecurity/kali-setup-script
# Create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)
# Use the following for password-less privesc : sudo apt-get install -y -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### Enable debug mode
#set -x


#### sudo no passwd - manual
sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### update sources.list
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo mv sources.list /etc/apt/sources.list

#### Add repo keys
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo tee -a /usr/share/keyrings/protonvpn.asc

#### region UK - manual
sudo setxkbmap -layout gb
### GB Locales
sudo update-locale LANG=en_GB.UTF-8
# sudo dpkg-reconfigure locales - requires manual intervention






#### Update
sudo apt update && sudo apt -y full-upgrade


#### install some basic tools
sudo apt-get install -y figlet -y 2>/dev/null
sudo apt-get install -y toilet -y 2>/dev/null
sudo apt-get install -y tree -y 2>/dev/null


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
virtenv="~/.virtualenv"

### install kde-desktop
#sudo apt-get install -y kali-desktop-kde
# requires reboot
# Select sddm display manager and press Enter
#### kde - carry this out manually and reboot
# sudo update-alternatives --config x-session-manager
# sudo apt purge --autoremove kali-desktop-xfce
# sudo apt autoremove


#### Check KDE Version for config changes
#if [ "`which kwriteconfig5`" ]; then
#    KWRITECONF=kwriteconfig5
#    HOTKEYS="$HOME/.config/khotkeysrc"
#    PLASMADESK="$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
#    KDEVER=5
#else
#    KWRITECONF=kwriteconfig
#    HOTKEYS="$HOME/.kde/share/config/khotkeysrc"
#    PLASMADESK="$HOME/.kde/share/config/plasma-desktop-appletsrc"
#    KDEVER=4
#fi

#### skip prompts in apt-upgrade, etc.
export DEBIAN_FRONTEND=noninteractive
alias apt-get='yes "" | apt-get -o Dpkg::Options::="--force-confdef" -y'


#### install transport protocol
sudo apt-get install -y apt-transport-https

#### another update
toilet -f term -F border --gay "apt-get update for good measure"
sudo apt-get update


echo -e "${GREEN}================== Install some things =======================${NC}"

####install visual code studio
toilet -f term -F border --gay "Microsoft Visual Code Studio"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install -y code
sudo rm microsoft.gpg 

#### Tweaking the themeing and look
toilet -f term -F border --gay "wallpaper"


sudo mkdir -p '/usr/share/wallpapers/wallpapers/' &>/dev/null

wallpaper_file="$(find . -type f -name Kali_dark_shadow_eye.jpg)"
if [[ -z "$wallpaper_file" ]]
        then
                sudo wget -P '/usr/share/wallpapers/wallpapers/' https://github.com/D4nk0St0rM/general_linux_notes/raw/main/wallpaper/Kali_dark_shadow_eye.jpg
        else
                sudo cp "$wallpaper_file" '/usr/share/wallpapers/wallpapers/Kali_dark_shadow_eye.jpg'
fi
#${KWRITECONF} --file plasmarc --group "Wallpapers" --key "usersWallpapers" "/home/$curuse/Pictures/Kali_dark_shadow_eye.jpg"

#### commandline with oh-my-zsh
toilet -f term -F border --gay "... oh my zsh ..."
# git clone http://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
sudo rm -r ~/.oh-my-zsh 
# sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
touch ~/.hushlogin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf 
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
sudo cp .zshrc .zshrc__
sudo rm .zshrc
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/.zshrc ~/.zshrc
#mv .zshrc ~/.zshrc

#### vim theme
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

#### conky
# sudo apt-get install -y conky
#sudo apt-get install -y conky-all
#mkdir -p ~/.conky/Minimal
#wget https://raw.githubusercontent.com/D4nk0St0rM/new_kali_instance_setup/main/conky.conf && mv conky.conf ~/.conky/Minimal/conky.conf
#echo '#!/bin/bash' >> ~/.conky/Minimal/conky-start.sh
#echo 'sleep 20 && conky -c ~/.conky/Minimal/conky.conf' >> ~/.conky/Minimal/conky-start.sh
#wget https://github.com/medisun/dotfiles/raw/master/.fonts/ConkySymbols.ttf && mv ConkySymbols.ttf ~/.conky/Minimal/ConkySymbols.ttf


#### A litte folder & file management
toilet -f term -F border --gay "... folder management ..."
rm -r  Music/ Public/ Videos/ Templates/ Desktop/
mkdir -p webserver
mkdir -p scripts
mkdir -p tempwork
mkdir -p general
mkdir -p .virtualenv
virtenv="~/.virtualenv"
mkdir -p Downloads
mkdir -p Documents
wget https://github.com/D4nk0St0rM/oscp_ethical_hacking/raw/main/reporting/box_name_IP_template_v2.1.ctb
mv *.ctb Documents/

#### wifite dependancies
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
#toilet -f term -F border --gay "some python set up and virtual envs"
#curl https://bootstrap.pypa.io/2.7/get-pip.py --output get-pip.py
#sudo python get-pip.py
#rm get-pip.py
#sudo apt-get install -y python2.7
#sudo apt-get install python3-pip -y
#sudo apt-get install python-dev -y
#sudo pip3 install virtualenv
#sudo pip3 install virtualenvwrapper
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
#echo "export WORKON_HOME=$HOME/.virtualenv" >> ~/.zshrc
#echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.zshrc
#source /usr/local/bin/virtualenvwrapper.sh
#source ~/.zshrc
#cd ~/.virtualenv
#virtualenv -p python3 python3
#virtualenv -p python2 python2
#echo -e "~#~ Alisas for activating python environments: py3act, py2act"
#cat << EOF >> ~/.zshrc
#alias py2act='source ~/.virtualenv/python2/bin/activate'
#alias py3act='source ~/.virtualenv/python3/bin/activate'
#EOF
#echo -e ''
#cd ~/
#source ~/.zshrc

toilet -f term -F border --gay "this may take a moment..."
toilet -f term -F border --gay "... running a bunch of installs..."

#### application install
figlet applications
toilet -f term -F border --gay "kali-linux-large"
sudo apt-get install -y kali-linux-large
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
toilet -f term -F border --gay "unrar"
sudo apt-get install -y unrar 2>/dev/null
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
toilet -f term -F border --gay "masscan"
sudo apt-get install -y masscan 2>/dev/null
toilet -f term -F border --gay "onesixtyone"
sudo apt-get install -y onesixtyone 2>/dev/null
toilet -f term -F border --gay "btscanner"
sudo apt-get install -y btscanner 2>/dev/null
toilet -f term -F border --gay "spooftooph"
sudo apt-get install -y spooftooph 2>/dev/null
toilet -f term -F border --gay "exploitdb"
sudo apt-get install -y exploitdb
toilet -f term -F border --gay "searchsploit"
searchsploit u
toilet -f term -F border --gay "pure-ftp"
sudo apt-get install -y pure-ftpd 2>/dev/null
toilet -f term -F border --gay "python3-dev"
sudo apt-get install -y python3 python3-pip python3-dev -y 2>/dev/null
toilet -f term -F border --gay "nodejs"
sudo apt-get install -y nodejs 2>/dev/null
toilet -f term -F border --gay "glances"
sudo apt-get install -y glances 2>/dev/null
toilet -f term -F border --gay "shellter"
sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install -y wine32 && sudo apt-get install -y shellter
toilet -f term -F border --gay "realtek-rtl88xxau-dkm"
sudo apt-get install -y realtek-rtl88xxau-dkms 2>/dev/null
toilet -f term -F border --gay "powershell"
sudo apt-get install -y powershell 2>/dev/null
toilet -f term -F border --gay " terminator"
sudo apt-get install -y  terminator 2>/dev/null
toilet -f term -F border --gay "net-tools"
sudo apt-get install -y net-tools 2>/dev/null
toilet -f term -F border --gay "rinetd port forwarding"
sudo apt-get install -y rinetd 2>/dev/null
toilet -f term -F border --gay "httptunnel"
sudo apt-get install -y httptunnel 2 >/dev/null
toilet -f term -F border --gay "zmap"
sudo apt-get install -y zmap 2>/dev/null
toilet -f term -F border --gay "gimp photo editor"
sudo apt-get install gimp -y  2>/dev/null
toilet -f term -F border --gay "bettercap dependancies"
sudo apt-get install -y libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev 2>/dev/null
toilet -f term -F border --gay "tempomail"
wget https://github.com/D4nk0St0rM/oscp_ethical_hacking/blob/main/tools/linux-amd64-tempomail.tgz
tar -xzvf linux-amd64-tempomail.tgz
sudo mv tempomail /usr/local/bin/
sudo rm linux-amd64-tempomail.tgz
toilet -f term -F border --gay "golang"
sudo apt-get install -y golang 2>/dev/null
mkdir -p ~/.go
gopath_exp='export GOPATH="$HOME/.go"'
path_exp='export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"'
sed -i '/export GOPATH=.*/c\' ~/.profile
sed -i '/export PATH=.*GOPATH.*/c\' ~/.profile
echo $gopath_exp | tee -a "$HOME/.profile"
grep -q -F "$path_exp" "$HOME/.profile" || echo $path_exp | tee -a "$HOME/.profile"
. "$HOME/.profile"

toilet -f term -F border --gay "bettercap dependancies"
sudo apt-get install libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev 2>/dev/null
toilet -f term -F border --gay "enum4linux"
sudo apt-get install -y enum4linux 2>/dev/null
toilet -f term -F border --gay " twofi"
sudo apt-get install -y twofi 2>/dev/null
toilet -f term -F border --gay "nbtscan"
sudo apt-get install -y nbtscan 2>/dev/null
toilet -f term -F border --gay "oscanner"
sudo apt-get install -y oscanner 2>/dev/null
toilet -f term -F border --gay "whatweb"
sudo apt-get install -y whatweb 2>/dev/null
toilet -f term -F border --gay "kerberoast"
sudo apt-get install -y kerberoast 2>/dev/null


### git clones
figlet -c GitClones
cd /opt/
toilet -f term -F border --gay "git clone bettercap"
sudo go get -v github.com/bettercap/bettercap
toilet -f term -F border --gay "git clone TJNull OSCP Repo"
sudo git clone https://github.com/tjnull/OSCP-Stuff.git
cd OSCP-Stuff/Priv-esc/Linux/
toilet -f term -F border --gay "git clone GTFOBins with TJNull Repo"
git clone https://github.com/GTFOBins/GTFOBins.github.io.git
python3 -m pip install -r requirements.txt
cd /opt/
toilet -f term -F border --gay "git clone wordlists"
sudo git clone https://github.com/7dbc/wordlists.git /opt/wordlists
toilet -f term -F border --gay "git clone h8mail"
sudo git clone https://github.com/khast3x/h8mail /opt/h8mail
toilet -f term -F border --gay "git clone discover"
sudo git clone https://github.com/leebaird/discover.git /opt/discover
toilet -f term -F border --gay "git clone nmapautomator"
sudo git clone https://github.com/21y4d/nmapAutomator.git /opt/nmapAutomator
toilet -f term -F border --gay "git clone subbrute"
sudo git clone https://github.com/TheRook/subbrute.git /opt/subbrute 2>/dev/null
toilet -f term -F border --gay "git clone windows exploit suggester"
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git /opt/windows-exploit-suggester 2>/dev/null
toilet -f term -F border --gay "git clone nmap vulners"
sudo git clone https://github.com/vulnersCom/nmap-vulners.git /usr/share/nmap/scripts/vulners 2>/dev/null
toilet -f term -F border --gay "git clone priv-esc-scripts"
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/priv-esc-scripts 2>/dev/null
toilet -f term -F border --gay "git clone sublist3r"
sudo git clone https://github.com/aboul3la/Sublist3r.git /opt/sublist3r 2>/dev/null
toilet -f term -F border --gay "git clone sherlock"
sudo git clone https://github.com/sherlock-project/sherlock.git /opt/sherlock 2>/dev/null
python3 -m pip install -r /opt/sherlock/requirements.txt
toilet -f term -F border --gay "git clone windows-php-reverse-shell"
sudo git clone https://github.com/Dhayalanb/windows-php-reverse-shell.git /opt/windows-reverse-shell 2>/dev/null
toilet -f term -F border --gay "git clone gobuster"
sudo git clone https://github.com/OJ/gobuster.git /opt/gobuster 2>/dev/null
toilet -f term -F border --gay "git clone ffuf"
sudo git clone https://github.com/ffuf/ffuf.git /opt/ffuf 2>/dev/null
toilet -f term -F border --gay "git clone robots disallowed"
sudo git clone https://github.com/D4nk0St0rM/RobotsDisallowed.git /opt/robotsdisallowed 2>/dev/null
toilet -f term -F border --gay "git clone fimap"
sudo git clone https://github.com/kurobeats/fimap.git /opt/fimap 
toilet -f term -F border --gay "git clone dirsearch"
sudo git clone https://github.com/maurosoria/dirsearch.git /opt/dirsearch
toilet -f term -F border --gay "git clone linkedin2username"
sudo git clone https://github.com/initstring/linkedin2username.git /opt/linkedin2username
toilet -f term -F border --gay "git clone Windows-Exploit-Suggester"
sudo git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git /opt/Windows-Exploit-Suggester
toilet -f term -F border --gay "git clone "
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -O ~/scripts/powerview.ps1
toilet -f term -F border --gay "git clone privilege-escalation-awesome-scripts-suite"
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/privilege-escalation-awesome-scripts-suite
toilet -f term -F border --gay "git clone GoblinWordGenerator"
sudo git clone https://github.com/UndeadSec/GoblinWordGenerator.git /opt/GoblinWordGenerator
toilet -f term -F border --gay "git clone Responder"
sudo git clone https://github.com/lgandx/Responder.git /opt/Responder

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
