

##### Location information
keyboardApple=false         # Using a Apple/Macintosh keyboard (non VM)?                [ --osx ]
keyboardLayout=""           # Set keyboard layout                                       [ --keyboard gb]
timezone=""                 # Set timezone location                                     [ --timezone Europe/London ]

##### Optional steps
burpFree=false              # Disable configuring Burp Suite (for Burp Pro users...)    [ --burp ]
hardenDNS=false             # Set static & lock DNS name server                         [ --dns ]
freezeDEB=false             # Disable updating certain packages (e.g. Metasploit)       [ --hold ]
openVAS=false               # Install & configure OpenVAS (not everyone wants it...)    [ --openvas ]
rolling=false               # Enable kali-rolling repos?                                [ --rolling ]

##### (Optional) Enable debug mode?
#set -x

##### (Cosmetic) Colour output
RED="\033[01;31m"      # Issues/Errors
GREEN="\033[01;32m"    # Success
YELLOW="\033[01;33m"   # Warnings/Information
BLUE="\033[01;34m"     # Heading
BOLD="\033[01;01m"     # Highlight
RESET="\033[00m"       # Normal

