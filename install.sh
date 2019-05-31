#!/bin/sh

test_installed() {
  name=$1
  command -v $name > /dev/null 2>&1 || { echo "$name not properly installed" && exit 0; }
}

pushd $(dirname "$0")

sudo apt-get -y install git curl

test_installed git
test_installed curl

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp ./zshrc $HOME/.zshrc
cp ./vimrc $HOME/.vimrc
cp ./tmux.conf $HOME/.tmux.conf

echo "Installing powerlevel9k"
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k

echo "Installing Powerline font"
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p $HOME/.local/share/fonts
mkdir -p $HOME/.config/fontconfig/conf.d
mv PowerlineSymbols.otf $HOME/.local/share/fonts/
mv 10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/
fc-cache -vf $HOME/.local/share/fonts/

echo "Installing zsh-syntax-lighlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing unversal-ctags"
git clone https://github.com/universal-ctags/ctags.git
sudo apt-get -y install autoconf automake pkg-config
pushd ctags
./autogen.sh && ./configure && make && make install
popd

echo "Installing silver searcher (ag)"
sudo apt-get -y install silversearcher-ag

echo "Installing colordiff"
sudo apt-get -y install colordiff

echo "Install the following option packages by your own: "
echo "ripgrep:  https://github.com/BurntSushi/ripgrep"
echo "diff-so-fancy:  https://github.com/so-fancy/diff-so-fancy"
echo "autojump:  https://github.com/wting/autojump"

popd
