#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0ve & kn0wledge #### #### #### ####
# Created after some inspiration from https://github.com/blacklanternsecurity/kali-setup-script
# Create user to not require password for sudo [sudo visudo / theUSER ALL=(ALL) NOPASSWD:ALL)
# Use the following for password-less privesc : sudo apt-get install -y -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### Enable debug mode
#set -x


##### Location information
keyboardLayout=""         # Set keyboard layout                                       [ --keyboard gb]
timezone=""    # Set timezone location                                     [ --timezone Europe/London ]

##### (Optional) Enable debug mode?
#set -x

##### Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

##### Read command line arguments
while [[ "${#}" -gt 0 && ."${1}" == .-* ]]; do
  opt="${1}";
  shift;
  case "$(echo ${opt} | tr '[:upper:]' '[:lower:]')" in
    -|-- ) break 2;;

    -keyboard|--keyboard )
       keyboardLayout="${1}"; shift;;
    -keyboard=*|--keyboard=* )
       keyboardLayout="${opt#*=}";;
    -timezone|--timezone )
       timezone="${1}"; shift;;
    -timezone=*|--timezone=* )
       timezone="${opt#*=}";;

    *) echo -e ' '${RED}'[!]'${RESET}" Unknown option: ${RED}${x}${RESET}" 1>&2 && exit 1;;
   esac
done


##### Check user inputs
if [[ -n "${timezone}" && ! -f "/usr/share/zoneinfo/${timezone}" ]]; then
  echo -e ' '${RED}'[!]'${RESET}" Looks like the ${RED}timezone '${timezone}'${RESET} is incorrect/not supported (Example: Europe/London). Quitting..." 1>&2
  exit 1
elif [[ -n "${keyboardLayout}" && -e /usr/share/X11/xkb/rules/xorg.lst ]]; then
  if ! $(grep -q " ${keyboardLayout} " /usr/share/X11/xkb/rules/xorg.lst); then
    echo -e ' '${RED}'[!]'${RESET}" Looks like the ${RED}keyboard layout '${keyboardLayout}'${RESET} is incorrect/not supported (Example: gb). Quitting..." 1>&2
    exit 1
  fi
fi


############################ Start

##### Disable screensaver
  echo -e "\n ${GREEN}[+]${RESET} Disabling ${GREEN}screensaver${RESET}"
  xset s 0 0
  xset s off
  gsettings set org.gnome.desktop.session idle-delay 0   # Disable swipe on lockscreen
fi

#### sudo no passwd - manual
sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### update sources.list
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo mv sources.list /etc/apt/sources.list

#### Add repo keys
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo tee -a /usr/share/keyrings/protonvpn.asc

### GB Locales
sudo update-locale LANG=en_GB.UTF-8

##### update 

sudo apt-get -qq update 
sudo apt-get -qq full-upgrade -y


