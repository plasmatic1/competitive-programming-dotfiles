# Setup Instructions

**Note: depending on the platform used for the git clone, it may add CRLF line endings everywhere and break alot of the configuration files.  Consider using dos2unix to fix things before copying anything over.**

# Section 0: Windows terminal and WSL
- Setup WSL using Ubuntu
	- Make sure everything is working
- Add defaults:         
	
```
	"defaults":
        {
            "useAcrylic" : true,
			"acrylicOpacity" : 0.65,
			"colorScheme": "Flatland"
        },
```

- Add scheme from https://atomcorp.github.io/themes/
	- Current theme ideas:
		- Flatland
		- Firewatch
- **Alternative**: Copy over `settings.json`

# Section 1: ZSH 

## install zsh
- run `sudo apt install zsh`
- run `chsh -shell $(which zsh)` # change shell to zsh

## install oh-my-zsh
- run `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` # install oh-my-zsh
- run `touch ~/.zshrc` # ??? idk if this is necessary
- Copy over proper zshrc

# Section 2: Vim

## Install vim basics
- run `sudo apt install vim-gnome`

## YouCompleteMe pre-setup
- run `sudo apt install cmake
- run `pip3 install future`

## VimRC
- copy over `~/.vimrc`
- copy over `~/.sub_cpp.py`
- run `chmod +x ~/.sub_cpp.py`

## Install vundle
- https://github.com/VundleVim/Vundle.vim#about
- Clone and copy required files (WIP: LINK)
- copy over correct vimrc
- run `vim +PluginInstall +qall` to auto install all plugins

## Python 3.7
- Run the following commands:
- `sudo apt update`
- `sudo apt install software-properties-common`
- `sudo add-apt-repository ppa:deadsnakes/ppa`
- `sudo apt install python3.7`
- `update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1`
- `sudo apt install python3.7-dev` for the python3.7 headers.  This is needed for YCM installation

## YouCompleteMe 
- run python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer
- copy over `.ycm_extra_conf.py` to `~/`

# Section 3: CP Tools

## CP Tools Console
- run `pip3 install cp-tools-console` (or equivalent)
	- Dev mode setup
		- `git clone https://github.com/plasmatic1/cp-tools-console`
		- `cd cp-tools-console`
		- `python3 setup.py develop`
- run `mkdir competitive && cd competitive`
- when starting: do `cd competitive && cpserv`

## Some extra tools

- run `mkdir ~/competitive`
- run `cp -r tools ~/competitive/
- run `cp .template.cpp ~/competitive/`

## Symlinks

- `ln -s /mnt/c/users/<name>/downloads downloads
- `ln -s /mnt/c/users/<name>/dropbox/competitive/extratemplates templates