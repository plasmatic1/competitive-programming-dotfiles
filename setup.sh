#!/bin/bash

function pause() {
    read -s -n 1 -p "Press any key to continue..."
    echo ""
}

echo "Running setup of environment"
echo "NOTE: Currently, if a directory needs to be specified, it must exist already or else the script will fail"
echo "NOTE 2: Paths that use ~ to specify user home dir. will not work"

echo
echo "Installing tmux..."
pause
sudo apt install tmux

echo
echo "Installing zsh..."
echo "Note: The next step after this (installing oh-my-zsh) will ask to change your default shell to zsh.  It is suggested"
pause
sudo apt install zsh

echo
echo "Installing oh-my-zsh..."
echo "Note: You will need to type \"exit\" after oh-my-zsh installs to quit out of the newly created zsh process"
pause
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -f -s $PWD/.zshrc ~/.zshrc

echo
echo "Install python version for You-Complete-Me..."
echo "Input the version to install (i.e. 3.9) or (n) to skip entirely (use python version used by python3 command):"
echo "NOTE: This will reconfigure your python3 update-alternatives and add a new alternative with priority 0.  Pick \"n\" if you do not want this to happen."

read -r ver
if [[ "$ver" == "n" ]]; then
    echo "Skipping python version install"
else
    cmd="python$ver"
    echo "Installing $cmd..."

    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install $cmd
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/$cmd 0
    sudo apt install $cmd-dev
fi
pause

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
echo "Install YouCompleteMe..."
pause
python3 ~/.vim/bundle/youcompleteme/install.py --clangd-completer
ln -f -s $PWD/.ycm_extra_conf.py ~/.ycm_extra_conf.py

echo
echo "Install CP-Tools-Console..."
echo "Input directory to clone repository into: (i.e. if .../repos is specified, the repository will be under .../repos/cp-tools-console), or (n) to not install in dev mode and instead directly from PIP."
read -r dir
echo
if [[ "$dir" == "n" ]]; then
    echo "Installing cp-tools-console from pip"
    pip3 install cp-tools-console
else
    echo "Installing cp-tools-console from repository"
    rdir=$(realpath $dir)
    sudo rm -r -f $rdir/cp-tools-console
    git clone https://github.com/plasmatic1/cp-tools-console $rdir/cp-tools-console

    olddir=$PWD
    cd $rdir/cp-tools-console
    sudo python3 $rdir/cp-tools-console/setup.py develop
    cd $olddir
fi
pause

echo
echo "Setup CP folder..."
echo
echo "Input directory for where CP folder should be:"
read -r cpdir
echo
echo "Input directory to clone templates repository into: (i.e. if .../repos is specified, the repository will be under .../repos/templates)"
read -r templdir
echo
echo "Input downloads directory:"
read -r dldir
echo

rcpdir=$(realpath $cpdir)
rtempldir=$(realpath $templdir)
rdldir=$(realpath $dldir)

echo "Cloning templates repo"
sudo rm -r -f $rtempldir/templates
git clone https://github.com/plasmatic1/templates $rtempldir/templates

echo
echo "Making links to competitive programming folder"
ln -f -s $PWD/tools $rcpdir/tools
# ln -f -s $PWD/.cptools $rcpdir/.cptools  # Currently has not been added yet :(
ln -f -s $PWD/push_config.sh $rcpdir/push_config.sh
ln -f -s $rtempldir/templates $rcpdir/templates
ln -f -s $rdldir $rcpdir/downloads

echo
echo "Note that a system restart may be needed for some changes to apply"
