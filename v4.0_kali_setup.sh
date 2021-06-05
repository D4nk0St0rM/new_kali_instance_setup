#!/bin/bash

## D4nk0St0rM
#### #### #### #### spread l0ve & kn0wledge #### #### #### ####
# Created after some inspiration from blacklanternsecurity & g0tmi1k scripts
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


#### sudo no passwd - manual
sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

#### update sources.list
file=/etc/apt/sources.list; [ -e "${file}" ] && cp -n $file{,.bkup}
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
wget https://raw.githubusercontent.com/D4nk0St0rM/general_linux_notes/main/sources.list
sudo mv sources.list $file


#### Add repo keys
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo tee -a /usr/share/keyrings/protonvpn.asc

### GB Locales
sudo update-locale LANG=en_GB.UTF-8

##### update 
 echo -e "\n ${GREEN}[+]${RESET} ${GREEN}Updating OS${RESET} from repositories ~ this ${BOLD}may take a while${RESET} depending on your connection & last time you updated / distro version"
for FILE in clean autoremove; do apt-get -y -qq "${FILE}"; done         # Clean up      clean remove autoremove autoclean
export DEBIAN_FRONTEND=noninteractive
apt-get -qq update && APT_LISTCHANGES_FRONTEND=none apt-get -o Dpkg::Options::="--force-confnew" -y dist-upgrade --fix-missing || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Cleaning up temp stuff
for FILE in clean autoremove; do apt-get -y -qq "${FILE}"; done         # Clean up - clean remove autoremove autoclean
###### kernel
_TMP=$(dpkg -l | grep linux-image- | grep -vc meta)
if [[ "${_TMP}" -gt 1 ]]; then
  echo -e "\n ${YELLOW}[i]${RESET} Detected multiple kernels installed"
  TMP=$(dpkg -l | grep linux-image | grep -v meta | sort -t '.' -k 2 -g | tail -n 1 | grep "$(uname -r)")
  [[ -z "${_TMP}" ]] && echo -e ' '${RED}'[!]'${RESET}' You are '${RED}'not using the latest kernel'${RESET} 1>&2 && echo -e " ${YELLOW}[i]${RESET} You have it downloaded & installed, ${YELLOW}just not using it${RESET}. You ${YELLOW}need to reboot${RESET}" && exit 1
  echo -e " ${YELLOW}[i]${RESET}   Clean up: apt-get remove --purge $(dpkg -l 'linux-image-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d')"  
  echo -e " ${RED}[i]${RESET}    DO NOT RUN IF NOT USING THE LASTEST KERNEL!"
fi


# sudo apt-get -full-upgrade -y


##### Update location information - either value "" to skip.
echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET}"
if [[ -n "${keyboardLayout}" ]]; then
  echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ keyboard layout (${BOLD}${keyboardLayout}${RESET})"
  geoip_keyboard=$(curl -s http://ifconfig.io/country_code | tr '[:upper:]' '[:lower:]')
  [ "${geoip_keyboard}" != "${keyboardLayout}" ] && echo -e " ${YELLOW}[i]${RESET} Keyboard layout (${BOLD}${keyboardLayout}${RESET}}) doesn't match what's been detected via GeoIP (${BOLD}${geoip_keyboard}${RESET}})"
  file=/etc/default/keyboard; #[ -e "${file}" ] && cp -n $file{,.bkup}
  sed -i 's/XKBLAYOUT=".*"/XKBLAYOUT="'${keyboardLayout}'"/' "${file}"
else
  echo -e " ${YELLOW}[i]${RESET} ${YELLOW}Skipping keyboard layout${RESET} (missing: '$0 ${BOLD}--keyboard <value>${RESET}')..." 1>&2
fi
#####  Changing time zone
if [[ -n "${timezone}" ]]; then
  echo -e "\n ${GREEN}[+]${RESET} Updating ${GREEN}location information${RESET} ~ time zone (${BOLD}${timezone}${RESET})"
  echo "${timezone}" > /etc/timezone
  ln -sf "/usr/share/zoneinfo/$(cat /etc/timezone)" /etc/localtime
  dpkg-reconfigure -f noninteractive tzdata
else
  echo -e " ${YELLOW}[i]${RESET} ${YELLOW}Skipping time zone${RESET} (missing: '$0 ${BOLD}--timezone <value>${RESET}')..." 1>&2
fi

##### Install kali large metapackage
# https://tools.kali.org/kali-metapackages
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}kali-linux-large${RESET} meta-package ~ this ${BOLD}may take a while${RESET} depending on your Kali version / network etc etc...."
sudo apt-get -y -qq install kali-linux-large || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2

##### Configure bash - all users
echo -e "\n ${GREEN}[+]${RESET} Configuring ${GREEN}bash${RESET} ~ CLI shell"
file=/etc/bash.bashrc; [ -e "${file}" ] && cp -n $file{,.bkup}   #~/.bashrc
grep -q "cdspell" "${file}" || echo "shopt -sq cdspell" >> "${file}"             # Spell check 'cd' commands
grep -q "checkwinsize" "${file}" || echo "shopt -sq checkwinsize" >> "${file}"   # Wrap lines correctly after resizing
grep -q "HISTSIZE" "${file}" || echo "HISTSIZE=10000" >> "${file}"               # Bash history (memory scroll back)
grep -q "HISTFILESIZE" "${file}" || echo "HISTFILESIZE=10000" >> "${file}"       # Bash history (file .bash_history)
#--- Apply new configs
if [[ "${SHELL}" == "/bin/zsh" ]]; then source ~/.zshrc else source "${file}"; fi


##### Install bash colour - all users
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}bash colour${RESET} ~ colours shell output"
file=/etc/bash.bashrc; [ -e "${file}" ] && cp -n $file{,.bkup}   #~/.bashrc
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
sed -i 's/.*force_color_prompt=.*/force_color_prompt=yes/' "${file}"
grep -q '^force_color_prompt' "${file}" 2>/dev/null || echo 'force_color_prompt=yes' >> "${file}"
sed -i 's#PS1='"'"'.*'"'"'#PS1='"'"'${debian_chroot:+($debian_chroot)}\\[\\033\[01;31m\\]\\u@\\h\\\[\\033\[00m\\]:\\[\\033\[01;34m\\]\\w\\[\\033\[00m\\]\\$ '"'"'#' "${file}"
grep -q "^export LS_OPTIONS='--color=auto'" "${file}" 2>/dev/null || echo "export LS_OPTIONS='--color=auto'" >> "${file}"
grep -q '^eval "$(dircolors)"' "${file}" 2>/dev/null || echo 'eval "$(dircolors)"' >> "${file}"
grep -q "^alias ls='ls $LS_OPTIONS'" "${file}" 2>/dev/null || echo "alias ls='ls $LS_OPTIONS'" >> "${file}"
grep -q "^alias ll='ls $LS_OPTIONS -l'" "${file}" 2>/dev/null || echo "alias ll='ls $LS_OPTIONS -l'" >> "${file}"
grep -q "^alias l='ls $LS_OPTIONS -lA'" "${file}" 2>/dev/null || echo "alias l='ls $LS_OPTIONS -lA'" >> "${file}"

#--- Apply new configs
if [[ "${SHELL}" == "/bin/zsh" ]]; then source ~/.zshrc else source "${file}"; fi


################# TO CONTINUE TESTING .......... 

##### Install GNOME Terminator
echo -e "\n ${GREEN}[+]${RESET} Installing GNOME ${GREEN}Terminator${RESET} ~ multiple terminals in a single window"
apt-get -y -qq install terminator || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Configure terminator
mkdir -p ~/.config/terminator/
file=~/.config/terminator/config; [ -e "${file}" ] && cp -n $file{,.bkup}
[ -e "${file}" ] || cat <<EOF > "${file}"
[global_config]
  enabled_plugins = TerminalShot, LaunchpadCodeURLHandler, APTURLHandler, LaunchpadBugURLHandler
[keybindings]
[profiles]
  [[default]]
    background_darkness = 0.9
    scroll_on_output = False
    copy_on_selection = True
    background_type = transparent
    scrollback_infinite = True
    show_titlebar = False
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
EOF


