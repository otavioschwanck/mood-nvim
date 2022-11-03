#!/bin/bash
APT_PACKAGES=(sqlite3 libsqlite3-dev neovim xclip python3-pip tmux)
NPM_PACKAGES=(neovim diagnostic-languageserver)
GEMS=(solargraph neovim bundler)
MOOD_GIT=(git@github.com:otavioschwanck/mood-nvim.git)
PACKER_GIT=(https://github.com/wbthomason/packer.nvim)
NVIM_DIR=".config/nvim"
PACKER_DIR=".local/share/nvim/site/pack/packer/start/packer.nvim"
export LAZY_VER="0.35" # LAZYGIT VERSION
TODAY=(date +"%m-%d-%y")

cd ~/

get_bash_profile () {
  if test -f ~/.zshrc; then
    BASH_PROFILE=(.zshrc)
  else
    BASH_PROFILE=(.bashrc)
  fi
}
get_machine_type () {
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
  esac
  echo "Proceeding instalation for OS ${machine}"
}

ask_question () {
  echo "Do you wish to install $1?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) echo "Installing $1";$2;break;;
      No ) echo "Not installing $1";break;;
    esac
  done
}

# Install tmux stuff
install_tmux_package_manager() {
  echo "================= INSTALLING TMUX STUFF ==============="
  if [ -d ~/.tmux/plugins/tpm ]; then
    echo "~/.tmux/plugins/tpm folder already exists, skipping installation of tpm."
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

# Install base packages
install_packages_linux () {
  echo "================= INSTALLING PACKAGES ================="
  sudo apt-get -qq update
  sudo apt-get -qq install ${APT_PACKAGES[*]} -y
  sudo npm install -s -g ${NPM_PACKAGES[*]} -y
  install_tmux_package_manager
}

install_packages_mac () {
  echo "================= INSTALLING PACKAGES ================="
  brew install readline openssl zlib postgresql sqlite ruby-build rbenv libffi ripgrep tmux tmuxinator alacritty bash
  brew link libpq --force
  install_tmux_package_manager
}

prompt_ruby_versions () {
  echo "Which ruby versions would you like to install? Use spaces to install more than one"
  echo "Example: 2.7.1 3.0.1 3.1.1"
  echo "Leave blank to not install any"
  IFS= read -rp 'Ruby Verions: ' USER_RUBY_INPUT
  IFS=' '
  read -a RUBY_VERSIONS <<< "$USER_RUBY_INPUT"
}

install_ruby_linux () {
  echo "================= INSTALLING RUBY ================="
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
  git clone https://github.com/rbenv/ruby-build.git
  cat ruby-build/install.sh
  PREFIX=/usr/local sudo ./ruby-build/install.sh
  echo "gem: --no-document" > ~/.gemrc
  prompt_ruby_versions
  for i in "${RUBY_VERSIONS[@]}"; do rbenv install $i -s; echo "Installed ruby version $i"; done
}

install_ruby_mac () {
  echo "================= INSTALLING RUBY ON MAC ================="
  echo "gem: --no-document" > ~/.gemrc
  prompt_ruby_versions
  for i in "${RUBY_VERSIONS[@]}"; do rbenv install $i -s; echo "Installed ruby version $i"; done
}

install_fonts () {
  echo "================= INSTALLING FONTS ================="
  if [ -d ~/$FONTS_LIBRARY ]; then
    echo "Fonts folder located, proceeding installing fonts"
  else
    mkdir ~/$FONTS_LIBRARY
  fi
  cd; wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
  unzip -q -o JetBrainsMono.zip -d ~/$FONTS_LIBRARY
  cd; rm JetBrainsMono.zip
}

install_pip_with_python () {
  if [ "$(which python3)" = "" ]
  then
    echo "Python3 not found, will look for Python"
    python -m pip install neovim-remote pynvim --quiet
  else
    echo "Python3 found, began installing pip"
    python3 -m pip install neovim-remote pynvim --quiet
  fi
}

check_for_previous_nvim () {
  if [ -d "$NVIM_DIR" ]; then
    echo "We found an already installed nvim on your computer!"
    mv ~/.config/nvim ~/.config/nvim-mood-backup-"$TODAY"
    echo "The files were moved to .config/nvim-mood-backup"
    echo "Now installing mood nvim from main branch."
  fi
}

clone_nvim_repositories () {
  git clone --quiet $MOOD_GIT ~/.config/nvim
  git config --global push.default current

  if [ -d "$PACKER_DIR" ]; then
    cd ~/.local/share/nvim/site/pack/packer/start/packer.nvim; git reset --quiet --hard HEAD; git pull; cd
  else
    git clone --quiet --depth 1 $PACKER_GIT ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  fi
}

install_nvim () {
  echo "================= INSTALLING NVIM ================="
  install_pip_with_python
  check_for_previous_nvim
  clone_nvim_repositories
  nvim +PackerSync
}

install_gems () {
  echo "================= INSTALLING GEMS ================="
  if [ "$(which rbenv)" = "" ]
  then
    echo "Rbenv not found"
  else
    cd ~/.rbenv/versions/; RUBY_VERSION=(*);rbenv local "$RUBY_VERSION"; rbenv global "$RUBY_VERSION"; cd
    echo "Ruby version $RUBY_VERSION was set as global"
    echo 'eval "$(rbenv init -)"' >> ~/$BASH_PROFILE
    eval "$(rbenv init -)"
    rbenv local $RUBY_VERSION
  fi
  for i in $GEMS; do gem install $i; done
}

install_lazygit_linux () {
  echo "================= INSTALLING LAZY GIT ================="
  wget -q -O lazygit.tgz https://github.com/jesseduffield/lazygit/releases/download/v${LAZY_VER}/lazygit_${LAZY_VER}_Linux_x86_64.tar.gz
  tar xf lazygit.tgz
  sudo mv lazygit /usr/local/bin/
}

install_lazygit_mac () {
  echo "================= INSTALLING LAZY GIT ================="
  brew install jesseduffield/lazygit/lazygit
  brew install lazygit
}

linux_workflow () {
  FONTS_LIBRARY=".fonts"
  ask_question "base packages for neovim" install_packages_linux
  ask_question "Ruby on Rails with Rbenv" install_ruby_linux
  ask_question "LazyGit" install_lazygit_linux
}

mac_workflow () {
  FONTS_LIBRARY="/Library/Fonts"
  ask_question "base packages for neovim" install_packages_mac
  ask_question "Ruby on Rails with Rbenv" install_ruby_mac
  ask_question "LazyGit" install_lazygit_mac
  echo "ulimit -S -n 200048 # Fix Packer for neovim" >> ~/$BASH_PROFILE
  ulimit -S -n 200048
}

# SCRIPT QUESTIONAIRE
get_machine_type
get_bash_profile
case "${machine}" in
  Linux)     linux_workflow;;
  Mac)       mac_workflow;;
  *)         echo "OS not recognized"
esac

install_fonts
install_gems
install_nvim

echo "Script finished!"
