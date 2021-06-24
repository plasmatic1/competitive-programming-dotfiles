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

After this, alternatively you may just run the setup.sh script

# Section 1: Shell Setup

## install tmux
- run `sudo apt install tmux`

## install zsh
- run `sudo apt install zsh`
- run `chsh -shell $(which zsh)` # change shell to zsh

_Note that on linux systems, you will need to log out and back in for the shell to change_

## install oh-my-zsh
- run `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` # install oh-my-zsh
- Copy over proper zshrc, best practice is probably to make a hard link

# Section 2: Vim

## VimRC
- copy over `~/.vimrc`
- copy over `~/.sub_cpp.py`
- run `chmod +x ~/.sub_cpp.py`

## Install vundle
- https://github.com/VundleVim/Vundle.vim#about
- Clone and copy required files (WIP: LINK)
- run `vim +PluginInstall +qall` to auto install all plugins

## YouCompleteMe pre-setup
- run `sudo apt install cmake
- run `pip3 install future`

## Python 3.7 (or any other python version)

_Note that if another python version is desired, the steps can be replaced for any other python version.  However, running update-alternatives to change the source of python3 may fail on unix systems and make it impossible to start the terminal normally._

- Run the following commands:
- `sudo apt update`
- `sudo apt install software-properties-common`
- `sudo add-apt-repository ppa:deadsnakes/ppa`
- `sudo apt install python3.7`
- `update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1`
- `sudo apt install python3.7-dev` for the python3.7 headers.  This is needed for YCM installation

## YouCompleteMe 
- run `python3 ~/.vim/bundle/youcompleteme/install.py --clangd-completer`
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

## Cloning templates

- run `git clone https://github.com/plasmatic1/templates`
