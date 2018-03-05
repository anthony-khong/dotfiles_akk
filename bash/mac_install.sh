# Xcode
echo 'Setting up Xcode...'
xcode-select --install

# Homebrew
echo 'Setting up Homebrew...'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask # No cask to install?

# Essentials
brew install wget
brew install htop
brew install pandoc
brew install ssh-copy-id
brew cask install karabiner
brew cask install seil

# Vim
echo 'Setting up Vim...'
brew install macvim --override-system-vim
brew linkapps

# NeoVim
echo 'Setting up Neovim...'
brew install neovim/neovim/neovim

# FZF
echo 'Setting up FZF...'
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Tmux
echo 'Setting up Tmux...'
brew install tmux

# Ag
echo 'Setting up Ag...'
brew install the_silver_searcher

# R
echo 'Setting up R...'
brew tap homebrew/science
brew install r

# Anaconda
echo 'Setting up Anaconda...'
read -p "Install Anacanda now. Press [Enter] to continue..."
sudo wget https://repo.continuum.io/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh -O ~/Downloads/anaconda.sh
sudo chmod +x ~/Downloads/anaconda.sh
sudo bash ~/Downloads/anaconda.sh -b -p /opt/anaconda
rm ~/Downloads/anaconda.sh

# Setup dotfiles
echo 'Setting up dotfiles...'
cd ~/dotfiles
git submodule init
git submodule update

cd;
source ~/dotfiles/bash/bash_shortcuts
recreate_symbolic_links
source ~/.bash_profile

# Setup NeoVim
echo 'Installing NeoVim plugins...'
nvim +PlugInstall +qall
nvim +PlugUpdate +qall
nvim +PlugInstall +qall

# Setup Tmux
echo 'Installing Tmux plugins...'
~/.tmux/plugins/tpm/bin/install_plugins

# Setup Python
echo 'Install Python packages...'
bash ~/dotfiles/bash/pip_installs.sh

# Setup Scala, SBT, Spark
brew install scala
brew install sbt
cd ~/Downloads/
wget https://d3kbcqa49mib13.cloudfront.net/spark-2.2.0-bin-hadoop2.7.tgz
mv spark-2.2.0-bin-hadoop2.7 ~/opt/spark

# Install the following manually:
# Chrome, Dropbox, Texmaker, R, RStudio, Spotify, VLC, iTerm, Skype,
# Transmission, Air Display, Google Drive, iStat Menus, Kindle, Latex, Line,
# Mendeley, Private Internet Access, Sublime Text, Slack, Microsoft Office,
# BetterSnap, Karabiner-Elements, PIA, Alfred, PyPy
# Optional: OpenBLAS

