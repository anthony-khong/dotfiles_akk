#! /bin/bash
export USER="ubuntu"
export HOME="/home/ubuntu"
export INSTALL_LOG="$HOME/.startup.log"
sudo chown $USER $INSTALL_LOG

echo "Installing essential apps with apt-get..." >> $INSTALL_LOG
sudo apt-get update && sudo apt-get install -y \
    build-essential \
    apt-transport-https \
    ca-certificates \
    clang \
    curl \
    entr \
    git \
    libssl-dev \
    make \
    pandoc \
    software-properties-common \
    tmux \
    unzip \
    xclip

echo "Installing mosh..." >> $INSTALL_LOG
sudo apt-get install -y mosh

echo "Installing Docker..." >> $INSTALL_LOG
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update && sudo apt-get install -y docker-ce

echo "Installing ZSH..." >> $INSTALL_LOG
sudo apt-get update && sudo apt-get install -y zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
sudo chsh -s /usr/bin/zsh $USER
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo chown -R $USER $HOME/.oh-my-zsh/cache

echo "Installing Miniconda..." >> $INSTALL_LOG
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
sudo bash ~/miniconda.sh -b -p /opt/anaconda && sudo rm ~/miniconda.sh
sudo chown -R $USER /opt/anaconda/
export PATH="/opt/anaconda/bin:$PATH"
pip install --upgrade pip

echo "Configuring dotfiles..." >> $INSTALL_LOG
sudo chown -R $USER dotfiles
cd $HOME/dotfiles \
    && git submodule init \
    && git submodule update \
    && cd $HOME \
    && /bin/bash -c "source ~/dotfiles/bash/bashrc" \
    && /bin/bash $HOME/dotfiles/bash/recreate_symbolic_links

echo "Installing Java..." >> $INSTALL_LOG
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt update && sudo apt install -y adoptopenjdk-11-openj9

echo "Installing Clojure..." >> $INSTALL_LOG
curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh
chmod +x linux-install-1.10.1.536.sh
sudo ./linux-install-1.10.1.536.sh

echo "Installing Lein..." >> $INSTALL_LOG
curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /opt/
chmod a+x /opt/lein
sudo mkdir -p $HOME/.lein \
    && sudo chown $USER /opt/lein \
    && sudo chown -R $USER $HOME/.lein

echo "Installing Neovim + dependencies..." >> $INSTALL_LOG
pip install --upgrade neovim jedi google-api-python-client pyflakes mypy msgpack pynvim
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > $HOME/nvim.appimage
sudo mv $HOME/nvim.appimage /usr/local/bin/nvim
chmod +x /usr/local/bin/nvim
/bin/bash $HOME/dotfiles/tmux/tpm/scripts/install_plugins.sh
nvim +PlugInstall +qall || true
sudo chown -R $USER $HOME/.local || true

echo "Installing Ripgrep..." >> $INSTALL_LOG
sudo curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb && sudo rm ripgrep_0.10.0_amd64.deb

echo "Installing Tmate..." >> $INSTALL_LOG
curl -LO https://github.com/tmate-io/tmate/releases/download/2.2.1/tmate-2.2.1-static-linux-amd64.tar.gz
sudo tar -xvf tmate-2.2.1-static-linux-amd64.tar.gz
sudo mv tmate-2.2.1-static-linux-amd64/tmate /usr/bin
sudo rm -rf tmate-2.2.1-static-linux-amd64
sudo rm tmate-2.2.1-static-linux-amd64.tar.gz

echo "Setting up permissions and Docker..." >> $INSTALL_LOG
cd $HOME/dotfiles \
    && git checkout . \
    && cd $HOME
sudo usermod -a -G docker $USER
sudo usermod -aG sudo $USER

echo "Creating 32G of swap file..." >> $INSTALL_LOG
sudo fallocate -l 32G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "Installing Parinfer..." >> $INSTALL_LOG
curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
cd ~/dotfiles/vim/plugged/parinfer-rust \
    && make install \
    && cargo build --release \
    && cargo install --force \
    && cd $HOME

echo "Setup complete!" >> $INSTALL_LOG
