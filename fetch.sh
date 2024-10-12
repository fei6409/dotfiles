if ! sudo -l >/dev/null 2>&1; then
  echo $'\e[1;31mNo sudo permission.\e[m'
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo $'\e[1;33mInstalling Git...\e[m'
  sudo apt-get -y install git
fi

git clone --filter=blob:none https://github.com/fei6409/dotfiles.git ~/dotfiles
if ! cd ~/dotfiles; then
    echo $'\e[1;31mDotfiles does not exist.\e[m'
    exit 1
fi
git remote set-url --push origin git@github.com:fei6409/dotfiles.git

./install
