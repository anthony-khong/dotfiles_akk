###############################################################################
#                            Bundled Installations                            #
###############################################################################
function setup_python() {
    pip install --upgrade pip

    # Machine Learning
    pip install Theano
    echo "[global]" >> .theanorc
    echo "floatX = float32" >> .theanorc
    echo "" >> .theanorc
    echo "[nvcc]" >> .theanorc
    echo "fastmath = True" >> .theanorc
    conda install pydot

    # Others
    pip install Lasagne
    pip install fuzzywuzzy
    pip install ggplot
    pip install jedi
    pip install neovim
    pip install pdbpp
    pip install scikit-learn
    pip install selenium
    pip install speedtest-cli
    pip install splinter
    pip install tabulate
    pip install tqdm
    pip install youtube-dl

    # Tensorflow
    pip install --upgrade https://storage.googleapis.com/tensorflow/mac/tensorflow-0.8.0-py2-none-any.whl

    # XGB
    cd cmls
    git clone --recursive https://github.com/dmlc/xgboost
    if [ "$(uname)" == "Darwin" ]; then
        brew install gcc --without-multilib
        cp make/minimum.mk ./config.mk
    fi
    make -j4
}

function setup_dotfiles() {
    echo 'Cloning dotfiles repo...'
    git clone https://github.com/anthony-khong/dotfiles.git
    cd ~/dotfiles
    git submodule init
    git submodule update

    cd;
    source ~/dotfiles/bash/bash_shortcuts
    recreate_symbolic_links
}

###############################################################################
#                                  Installs                                   #
###############################################################################
if [ "$(uname)" == "Darwin" ]; then
    # Put dock to the left
    echo 'Setting up Mac...';

    # Xcode
    xcode-select --install

    # Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install caskroom/cask/brew-cask # No cask to install?

    # Essentials
    brew install wget
    brew install htop
    brew install pandoc
    # tlmgr install collection-fontsrecommended # This requires LaTex
    brew cask install karabiner
    brew cask install seil

    # Vim
    brew install macvim --override-system-vim
    brew linkapps

    # NeoVim
    brew tap neovim/neovim
    brew install --HEAD neovim

    # FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # Tmux
    brew install tmux

    # Ag
    brew install the_silver_searcher

    # R
    brew tap homebrew/science
    brew install r

    # Anaconda
    read -p "Install Anacanda now. Press [Enter] to continue..."
    sudo wget http://repo.continuum.io/archive/Anaconda2-4.0.0-MacOSX-x86_64.sh -O ~/Downloads/anaconda.sh
    sudo chmod +x anaconda.sh
    sudo bash anaconda.sh

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # TODO: Anaconda, Antivirus, CUDA, Chrome, Dropbox, RSudio, SSH, VLC, noip2.
    echo 'Setting up Linux...';

    # Essentials
    sudo apt-get update
    sudo apt-get install build-essential
    sudo apt-get install gnome-tweak-tool
    sudo apt-get install compizconfig-settings-manager compiz-plugins-extra
    sudo apt-get install htop
    sudo apt-get install lm-sensors

    # Xcape and Caps behaviour
    sudo apt-get install git gcc make pkg-config libx11-dev libxtst-dev libxi-dev
    git clone https://github.com/alols/xcape.git
    cd xcape
    make
    sudo make install

    setxkbmap -option 'caps:ctrl_modifier'
    xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'

    echo "\n" >> ~/.profile
    echo "# Mapping to make caps lock behave well" >> ~/.profile
    echo "setxkbmap -option 'caps:ctrl_modifier'" >> ~/.profile
    echo "xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'" >> ~/.profile

    # Git
    sudo apt-get update
    sudo apt-get install git

    # Vim with clipboard
    sudo apt-get update
    sudo apt-get install vim-gtk

    # NeoVim
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim

    # Latest Tmux
    sudo apt-get install -y python-software-properties software-properties-common
    sudo add-apt-repository -y ppa:pi-rho/dev
    sudo apt-get update
    sudo apt-get install -y tmux=2.0-1~ppa1~t

    # Pandoc
    sudo apt-get install haskell-platform
    cabal update
    cabal install pandoc

    # Spotify
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update
    sudo apt-get install spotify-client

    # R
    sudo apt-get update
    sudo apt-get install r-base

    # Ag
    sudo apt-get install silversearcher-ag

    # Anaconda
    sudo wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda-2.3.0-Linux-x86_64.sh
    sudo chmod +x Ana*
    sudo bash Ana*.sh
fi

setup_dotfiles
setup_python

setup_nvim
recreate_symbolic_links