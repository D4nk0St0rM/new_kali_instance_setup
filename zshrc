export TERM="xterm-256color"                                                                                                                                                      
set -g status-fg  green                                                                                                                                                           
set -g status-bg  black                                                                                                                                                           
set -g default-terminal 'screen-256color'                                                                                                                                         
                                                                                                                                                                                  
                                                                                                                                                                                  
# If you come from bash you might have to change your $PATH.                                                                                                                      
# export PATH=$HOME/bin:/usr/local/bin:$PATH                                                                                                                                      
                                                                                                                                                                                  
# Path to your oh-my-zsh installation.                                                                                                                                            
export ZSH=$HOME/.oh-my-zsh                                                                                                                                                       
                                                                                                                                                                                  
# Set name of the theme to load --- if set to "random", it will                                                                                                                   
# load a random theme each time oh-my-zsh is loaded, in which case,                                                                                                               
# to know which specific one was loaded, run: echo $RANDOM_THEME                                                                                                                  
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes                                                                                                                              
#ZSH_THEME="robbyrussell"                                                                                                                                                         
#ZSH_THEME="agnoster"                                                                                                                                                             
POWERLEVEL9K_MODE='awesome-fontconfig'                                                                                                                                            
ZSH_THEME="powerlevel9k/powerlevel9k"                                                                                                                                             
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3                                                                                                                                                 
POWERLEVEL9K_SHORTEN_DELIMITER=".."                                                                                                                                               
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_left"                                                                                                                                
#POWERLEVEL9K_VPN_IP_INTERFACE='(tun.*|inet.*)'                                                                                                                                   
#POWERLEVEL9K_VPN_IP_BACKGROUND="red"                                                                                                                                             
#POWERLEVEL9K_VPN_IP_FOREGROUND="white"                                                                                                                                           
#POWERLEVEL9K_VPN_IP_SHOW_ALL=true                                                                                                                                                
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)                                                                                                                               
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)                                                                                                                                       
POWERLEVEL9K_PROMPT_ON_NEWLINE=true                                                                                                                                               
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true                                                                                                                                              
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"                                                                                                                                    
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
                                                                                                              
plugins=(                                                                                                                                                                         
        git                                                                                                                                                                       
        zsh-syntax-highlighting                                                                                                                                                   
        zsh-autosuggestions                                                                                                                                                       
)                                                                                                                                                                                 
                                                                                                                                                                                  
source $ZSH/oh-my-zsh.sh                                                                                                                                                          
                                                                                                                                                                                  
HISTFILE=~/.zsh_history                                                                                                                                                           
HISTSIZE=1000000                                                                                                                                                                  
SAVEHIST=2000000                                                                                                                                                                  
                                                                                                                         
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

 export EDITOR='vim'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'



#export PATH="$PATH:[NEW_DIRECTORY]/bin"
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ ls; }

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

alias myip="curl http://ipecho.net/plain; echo"
alias clear="clear && ls"
