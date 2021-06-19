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


sudo apt-get update
sudo apt-get install full-upgrade -y
sudo apt-get install kali-linux-full -y


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
grep -q "HISTSIZE" "${file}" || echo "HISTSIZE=100000" >> "${file}"               # Bash history (memory scroll back)
grep -q "HISTFILESIZE" "${file}" || echo "HISTFILESIZE=100000" >> "${file}"       # Bash history (file .bash_history)
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


##### Ivim - all users
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}vim${RESET} ~ CLI text editor"
apt-get -y -qq install vim || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Configure vim
file=/etc/vim/vimrc; [ -e "${file}" ] && cp -n $file{,.bkup}   #~/.vimrc
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
sed -i 's/.*syntax on/syntax on/' "${file}"
sed -i 's/.*set background=dark/set background=dark/' "${file}"
sed -i 's/.*set showcmd/set showcmd/' "${file}"
sed -i 's/.*set showmatch/set showmatch/' "${file}"
sed -i 's/.*set ignorecase/set ignorecase/' "${file}"
sed -i 's/.*set smartcase/set smartcase/' "${file}"
sed -i 's/.*set incsearch/set incsearch/' "${file}"
sed -i 's/.*set autowrite/set autowrite/' "${file}"
sed -i 's/.*set hidden/set hidden/' "${file}"
sed -i 's/.*set mouse=.*/"set mouse=a/' "${file}"
grep -q '^set number' "${file}" 2>/dev/null || echo 'set number' >> "${file}"                                                                        # Add line numbers
grep -q '^set autoindent' "${file}" 2>/dev/null || echo 'set autoindent' >> "${file}"                                                                # Set auto indent
grep -q '^set expandtab' "${file}" 2>/dev/null || echo -e 'set expandtab\nset smarttab' >> "${file}"                                                 # Set use spaces instead of tabs
grep -q '^set softtabstop' "${file}" 2>/dev/null || echo -e 'set softtabstop=4\nset shiftwidth=4' >> "${file}"                                       # Set 4 spaces as a 'tab'
grep -q '^set foldmethod=marker' "${file}" 2>/dev/null || echo 'set foldmethod=marker' >> "${file}"                                                  # Folding
grep -q '^nnoremap <space> za' "${file}" 2>/dev/null || echo 'nnoremap <space> za' >> "${file}"                                                      # Space toggle folds
grep -q '^set hlsearch' "${file}" 2>/dev/null || echo 'set hlsearch' >> "${file}"                                                                    # Highlight search results
grep -q '^set laststatus' "${file}" 2>/dev/null || echo -e 'set laststatus=2\nset statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]' >> "${file}"   # Status bar
grep -q '^filetype on' "${file}" 2>/dev/null || echo -e 'filetype on\nfiletype plugin on\nsyntax enable\nset grepprg=grep\ -nH\ $*' >> "${file}"     # Syntax highlighting
grep -q '^set wildmenu' "${file}" 2>/dev/null || echo -e 'set wildmenu\nset wildmode=list:longest,full' >> "${file}"                                 # Tab completion
grep -q '^set invnumber' "${file}" 2>/dev/null || echo -e ':nmap <F8> :set invnumber<CR>' >> "${file}"                                               # Toggle line numbers
grep -q '^set pastetoggle=<F9>' "${file}" 2>/dev/null || echo -e 'set pastetoggle=<F9>' >> "${file}"                                                 # Hotkey - turning off auto indent when pasting
grep -q '^:command Q q' "${file}" 2>/dev/null || echo -e ':command Q q' >> "${file}"                                                                 # Fix stupid typo I always make
#--- Set as default editor
export EDITOR="vim"   #update-alternatives --config editor
file=/etc/bash.bashrc; [ -e "${file}" ] && cp -n $file{,.bkup}
([[ -e "${file}" && "$(tail -c 1 ${file})" != "" ]]) && echo >> "${file}"
grep -q '^EDITOR' "${file}" 2>/dev/null || echo 'EDITOR="vim"' >> "${file}"
git config --global core.editor "vim"


##### Install conky
echo -e "\n ${GREEN}[+]${RESET} Installing ${GREEN}conky${RESET} ~ GUI desktop monitor"
apt-get -y -qq install conky || echo -e ' '${RED}'[!] Issue with apt-get'${RESET} 1>&2
#--- Configure conky
file=~/.conkyrc; [ -e "${file}" ] && cp -n $file{,.bkup}
[ -e "${file}" ] || cat <<EOF > "${file}"
## Useful: http://forums.opensuse.org/english/get-technical-help-here/how-faq-forums/unreviewed-how-faq/464737-easy-configuring-conky-conkyconf.html
background yes
#background no     # Kali rolling?
font Monospace:size=8:weight=bold
use_xft yes
update_interval 2.0
own_window yes
own_window_type normal
own_window_transparent yes
own_window_class conky-semi
own_window_argb_visual yes   # GNOME & XFCE yes, KDE no
#own_window_argb_visual no    # Kali rolling?
own_window_colour brown
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
double_buffer yes
maximum_width 260
draw_shades yes
draw_outline no
draw_borders no
stippled_borders 3
#border_margin 9   # Old command
border_inner_margin 9
border_width 10
default_color grey
alignment bottom_right
#gap_x 55   # KDE
#gap_x 0    # GNOME
gap_x 5
gap_y 0
uppercase no
use_spacer right

TEXT

\${color dodgerblue3}SYSTEM ${hr 2}$color
\${color white}Host$color: $nodename  ${alignr}${color white}Uptime$color: $uptime
\${color white}Kernel : ${color}$kernel on $machine

\${color dodgerblue3}CPU ${hr 2}$color
\${color white}MHz$color: ${freq} ${alignr}${color white}Load$color: ${exec uptime | awk -F "load average: "  '{print $2}'}
\${color white}Tasks$color: $running_processes/$processes ${alignr}${color white}CPU0$color: ${cpu cpu0}% ${color white}CPU1$color: ${cpu cpu1}%
\${cpugraph cpu0 25,120 000000 white} ${alignr}${cpugraph cpu1 25,120 000000 white}
\${color white}${cpubar cpu1 3,120} ${alignr}${color white}${cpubar cpu2 3,120}$color

\${color dodgerblue3}FILESYSTEM ${hr 2}$color
\${color white}root$color ${fs_free_perc /}% free${alignr}${fs_free /}/ ${fs_size /}
\${fs_bar 3 /}$color
\${color dodgerblue3}PROCESSES  ${hr 2} $color
\${color white} NAME             PID     CPU     MEM
\${color white} ${top name 1}  ${top pid 1}   ${top cpu 1}   ${top mem 1} $color
 \${top name 2}  ${top pid 2}   ${top cpu 2}   ${top mem 2}
 \${top name 3}  ${top pid 3}   ${top cpu 3}   ${top mem 3}
 \${top name 4}  ${top pid 4}   ${top cpu 4}   ${top mem 4}
 \${top name 5}  ${top pid 5}   ${top cpu 5}   ${top mem 5}

\${color dodgerblue3}LAN eth0 (${addr eth0}) ${hr 2}$color
\${color white}Down$color:  ${downspeed eth0} KB/s${alignr}${color white}Up$color: ${upspeed eth0} KB/s
\${color white}Downloaded$color: ${totaldown eth0} ${alignr}${color white}Uploaded$color: ${totalup eth0}
\${downspeedgraph eth0 25,120 000000 00ff00} ${alignr}${upspeedgraph eth0 25,120 000000 ff0000}$color

\${color dodgerblue3}Wi-Fi (${addr wlan0}) ${hr 2}$color
\${color white}Down$color:  ${downspeed wlan0} KB/s${alignr}${color white}Up$color: ${upspeed wlan0} KB/s
\${color white}Downloaded$color: ${totaldown wlan0} ${alignr}${color white}Uploaded$color: ${totalup wlan0}
\${downspeedgraph wlan0 25,120 000000 00ff00} ${alignr}${upspeedgraph wlan0 25,120 000000 ff0000}$color

\${color dodgerblue3}CONNECTIONS ${hr 2}$color
\${color white}Inbound: $color${tcp_portmon 1 32767 count}  ${alignc}${color white}Outbound: $color${tcp_portmon 32768 61000 count}${alignr}${color white}Total: $color${tcp_portmon 1 65535 count}
\${color white}Inbound ${alignr}Local Service/Port$color
\$color ${tcp_portmon 1 32767 rhost 0} ${alignr}${tcp_portmon 1 32767 lservice 0}
\$color ${tcp_portmon 1 32767 rhost 1} ${alignr}${tcp_portmon 1 32767 lservice 1}
\$color ${tcp_portmon 1 32767 rhost 2} ${alignr}${tcp_portmon 1 32767 lservice 2}
\${color white}Outbound ${alignr}Remote Service/Port$color
\$color ${tcp_portmon 32768 61000 rhost 0} ${alignr}${tcp_portmon 32768 61000 rservice 0}
\$color ${tcp_portmon 32768 61000 rhost 1} ${alignr}${tcp_portmon 32768 61000 rservice 1}
\$color ${tcp_portmon 32768 61000 rhost 2} ${alignr}${tcp_portmon 32768 61000 rservice 2}

\${color dodgerblue3}MEMORY & SWAP \${hr 2}\$color
\${color white}RAM $color  $alignr $memperc%   ${membar 6,170} $color
\${color white}Swap $color   $alignr $swapperc%   ${swapbar 6,170} $color

EOF
#--- Add to startup (each login)
file=/usr/local/bin/start-conky; [ -e "${file}" ] && cp -n $file{,.bkup}
cat <<EOF > "${file}" || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

[[ -z ${DISPLAY} ]] && export DISPLAY=:0.0
$(which timeout) 10 $(which killall) -q conky
$(which sleep) 15s
$(which conky) &
EOF

chmod -f 0500 "${file}"
mkdir -p ~/.config/autostart/
file=~/.config/autostart/conkyscript.desktop; [ -e "${file}" ] && cp -n $file{,.bkup}
cat <<EOF > "${file}" || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
[Desktop Entry]
Name=conky
Exec=/usr/local/bin/start-conky
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Type=Application
Comment=
EOF
