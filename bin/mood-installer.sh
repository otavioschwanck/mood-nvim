#!/bin/bash
APT_PACKAGES=(sqlite3 libsqlite3-dev xclip python3-pip tmux)
NPM_PACKAGES=(neovim diagnostic-languageserver)
GEMS=(solargraph neovim bundler)
MOOD_GIT=(https://github.com/otavioschwanck/mood-nvim.git)
NVIM_DIR=".config/nvim"
NPM_DIR="/npm"
export LAZY_VER="0.35" # LAZYGIT VERSION
TODAY=(date +"%m-%d-%y")
#CHECKS

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
  MACHINE=${machine}
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
  brew install git-delta readline openssl zlib postgresql sqlite libffi ripgrep tmux tmuxinator alacritty bash
  brew link libpq --force
  install_tmux_package_manager
}

install_nvm () {
  echo "================= INSTALLING NVM ================="
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  source ~/$BASH_PROFILE
  nvm install --lts
  NVM_CHECK=true
  NPM_CHECK=true
}

install_nvim_ppa () {
  echo "================= INSTALLING NVIM with ppa:neovim-ppa/unstable ================="
  sudo apt remove neovim
  sudo add-apt-repository ppa:neovim-ppa/unstable -y
  sudo apt update -qq -y
  sudo apt install neovim -qq -y
  source ~/$BASH_PROFILE
  NVIM_CHECK=true
  NVIM_VERSION_CHECK=true
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
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/$BASH_PROFILE
  echo 'eval "$(rbenv init -)"' >> ~/$BASH_PROFILE
  source ~/$BASH_PROFILE
  echo "gem: --no-document" > ~/.gemrc
  prompt_ruby_versions
  for i in "${RUBY_VERSIONS[@]}"; do rbenv install $i -s; echo "Installed ruby version $i"; done
}

install_ruby_mac () {
  echo "================= INSTALLING RUBY ON MAC ================="
  brew install rbenv ruby-build
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
  cd; wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
  unzip -q -o FiraCode.zip -d ~/$FONTS_LIBRARY
  cd; rm FiraCode.zip
}

# Checks if everything is alright before installing
run_pre_check () {
  echo "================= Checking install environment ================="
  [ -d ~/.nvm ] && NVM_CHECK=true || NVM_CHECK=false
  [ -d ~/.npm ] && NPM_CHECK=true || NPM_CHECK=false
  GIT_SSH_COMMAND= git ls-remote -q $MOOD_GIT &> /dev/null
  [[ $? = 0 ]] && GIT_CHECK=true || GIT_CHECK=false
  type python3 >/dev/null 2>&1 && PYTHON3_CHECK=true || PYTHON3_CHECK=false
  type rvm >/dev/null 2>&1 && RVM_CHECK=true || RVM_CHECK=false
  type rbenv >/dev/null 2>&1 && RBENV_CHECK=true || RBENV_CHECK=false
  command -v nvim >/dev/null

  if [[ $? -ne 0 ]]; then
    NVIM_CHECK=false
  else
    NVIM_CHECK=true
    nvim_version=$(nvim --version | head -1 | grep -o '[0-9]\.[0-9]')

    if (( $(echo "$nvim_version < 0.8 " |bc -l) )); then
      NVIM_VERSION_CHECK=false
    else
      NVIM_VERSION_CHECK=true
    fi
  fi
  echo "Your system is running: $MACHINE"
  echo "Your bash profile is: $BASH_PROFILE"
  printf "%20s     %6s\n" "CHECK" "STATUS"
  check_color "NVIM is installed" "$NVIM_CHECK"
  check_color "NVIM ver. >= 0.8" "$NVIM_VERSION_CHECK"
  check_color "Access to Mood Repo" "$GIT_CHECK"
  check_color "NVM is installed" "$NVM_CHECK"
  check_color "NPM is installed" "$NPM_CHECK"
  check_color "Python3 is installed" "$PYTHON3_CHECK"
  check_color "RVM is installed" "$RVM_CHECK"
  check_color "Rbenv is installed" "$RBENV_CHECK"
}

# Checks if everything is alright before installing
run_post_check () {
  echo "================= Checking post installation environment ================="
  [ -d ~/.config/nvim ] && MOOD_CHECK=true || MOOD_CHECK=false
  [ -f ~/"$FONTS_LIBRARY/Fira Code Bold Nerd Font Complete.ttf" ] && FONTS_CHECK=true || FONTS_CHECK=false
  printf "%20s     %6s\n" "CHECK" "STATUS"
  check_color "Mood was installed" "$MOOD_CHECK"
  check_color "Fonts were installed" "$FONTS_CHECK"
}

# prints the values for the check routine table
check_color () {
  GREEN=$(tput setaf 2)
  RED=$(tput setaf 1)
  NC=$(tput sgr0)
  if [ $2 = true ]; then
    CHECK="${GREEN}YES${NC}"
  else
    CHECK="${RED}NO${NC}"
  fi
  printf "%20s     %6s\n" "$1" "${CHECK}"
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
}

install_nvim () {
  echo "================= INSTALLING NVIM ================="
  install_pip_with_python
  check_for_previous_nvim
  clone_nvim_repositories
  nvim --headless "+Lazy! sync" +qa
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

check_mandatory_parameters() {
  if [ "$NVIM_CHECK" = false ];then
    echo "It seems that Neovim is not installed, please install it with version >= 0.8 and run this script again."
    ask_question "Nvim PPA > 0.8" install_nvim_ppa
  fi

  if [ "$NVIM_VERSION_CHECK" = false ];then
    echo "It seems that your Neovim version is not compatible with this configuration, please make sure it's version is >= 0.8"
    ask_question "Nvim PPA > 0.8" install_nvim_ppa
  fi
  if [ "$GIT_CHECK" = false ]; then
    echo "Could not connect to MooD repo on Github, please make sure you have Git credentials to clone the repo: ${MOOD_GIT}"
  fi
  if [ "$NVM_CHECK" = false ]; then
    echo "NVM was not found on your system, please install it and run this script again."
    ask_question "NVM" install_nvm
  fi
  if [ "$NPM_CHECK" = false ]; then
    echo "NPM was not found on your system, please install it and run this script again."
  fi
  if [ "$PYTHON3_CHECK" = false ]; then
    echo "Python3 was not found on your system, please install it and run this script again."
  fi
  if [ "$NVIM_CHECK" = false ] || [ "$NVM_CHECK" = false ] || [ "$NVIM_VERSION_CHECK" = false ] || [ "$GIT_CHECK" = false ] || [ "$PYTHON3_CHECK" = false ]; then
    exit 1
  fi
}

get_machine_type
get_bash_profile
run_pre_check
check_mandatory_parameters


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
  echo "ulimit -S -n 200048 # Fix Lazy (Package Manager) for neovim" >> ~/$BASH_PROFILE
  ulimit -S -n 200048
}

# SCRIPT QUESTIONAIRE
case "${machine}" in
  Linux)     linux_workflow;;
  Mac)       mac_workflow;;
  *)         echo "OS not recognized"
esac


install_fonts
install_gems
install_nvim
run_post_check

echo "Script finished!"
