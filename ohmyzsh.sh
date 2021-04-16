#!/bin/bash

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
