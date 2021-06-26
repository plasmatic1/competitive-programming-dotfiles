#!/bin/bash

function pause() {
    read -s -n 1 -p "Press any key to continue . . ."
    echo ""
}

echo "Running setup of environment"

echo
echo "Installing tmux..."
pause
sudo apt install tmux

echo
echo "Installing zsh..."
pause
sudo apt install zsh
chsh -shell $(which zsh)

echo
echo "Installing oh-my-zsh..."
pause
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -f -s $PWD/.zshrc ~/.zshrc

echo
echo "Vim Setup..."
pause
sudo apt install vim-gtk3  # Gotta have that sweet sweet xterm support
ln -f -s $PWD/.vimrc ~/.vimrc
ln -f -s $PWD/.sub_cpp.py ~/.sub_cpp.py
chmod +x ~/.sub_cpp.py

echo
echo "Install Vundle..."
pause
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo
echo "YCM pre-setup"
pause
sudo apt install cmake
sudo apt install python3-pip
pip3 install future

echo
echo "Install python version for YCM..."
echo "Input the version to install (i.e. 3.9) or (n) to skip entirely (use python version used by python3 command):"

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

echo
echo "Install YouCompleteMe..."
pause
python3 ~/.vim/bundle/youcompleteme/install.py --clangd-completer
ln -f -s $PWD/.ycm_extra_conf.py ~/.ycm_extra_conf.py

echo
echo "Install CP-Tools-Console..."
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

echo
echo "Setup CP folder..."
echo
echo "Input directory for where CP folder should be:"
read -r cpdir
rcpdir=$(realpath $cpdir)

mkdir $rcpdir
cp -f -r tools $rcpdir/

echo "Input directory to store templates repository:"
read -r templdir
rtempldir=$(realpath $templdir)

git clone https://github.com/plasmatic1/templates $rtempldir
ln -f -s $rtempldir/templates $rcpdir/templates

echo "Input downloads directory:"
read -r dldir
rdldir=$(realpath $dldir)
ln -f -s $rdldir $rcpdir/downloads

ln -f -s $PWD/push_config.sh $rcpdir/push_config.sh
