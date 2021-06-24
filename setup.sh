#!/bin/bash

echo "Running setup of environment"

echo "Installing tmux"
sudo apt install tmux
pause

echo "Installing zsh"
sudo apt install zsh
chsh -shell $(which zsh)
pause

echo "Installing oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -s $PWD/.zshrc ~/.zshrc
pause

echo "Vim Setup"
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.sub_cpp.py ~/.sub_cpp.py
chmod +x ~/.sub_cpp.py
pause

echo "Install Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
pause

echo "YCM pre-setup"
sudo apt install cmake
sudo apt install python3-pip
pip3 install future
pause

echo "Install python version with YCM"
echo "Input the version (i.e. 3.9) or (n) to skip entirely"

read -r ver
if [[ "$ver"=="n" ]]; then
    echo "Skipping python version install"
else
    cmd="python$ver"
    echo "Installing $cmd..."

    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install $cmd
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/$cmd 1
    sudo apt install $cmd-dev
fi
pause

echo "Install YouCompleteMe"
python3 ~/.vim/bundle/youcompleteme/install.py --clangd-completer
ln -s $PWD/.ycm_extra_conf.py ~/.ycm_extra_conf.py
pause

echo "Install CP-Tools-Console"
echo "Input directory to install into: (i.e. ~/repos), or (n) to not install in dev mode and instead directly from PIP."
read -r dir
if [[ "$dir"=="n" ]]; then
    pip3 install cp-tools-console
else
    rdir=$(realpath $dir)
    git clone https://github.com/plasmatic1/cp-tools-console $rdir
    cd $rdir/cp-tools-console
    python3 setup.py develop
fi
pause

echo "Setup CP folder"
echo
echo "Input directory for where CP folder should be:"
read -r cpdir
rcpdir=$(realpath $cpdir)

mkdir $rcpdir
cp -r tools $rcpdir/

echo "Input directory to store templates repository:"
read -r templdir
rtempldir=$(realpath $templdir)

git clone https://github.com/plasmatic1/templates $rtempldir
ln -s $rtempldir/templates $rcpdir/templates

echo "Input downloads directory:"
read -r dldir
rdldir=$(realpath $dldir)
ln -s $rdldir $rcpdir/downloads

ln -s $PWD/push_config.sh $rcpdir/push_config.sh
