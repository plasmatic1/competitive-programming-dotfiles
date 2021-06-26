# Setup Instructions

**Note: depending on the platform used for the git clone, it may add CRLF line endings everywhere and break alot of the configuration files.  Consider using dos2unix to fix things before copying anything over.**

Note that this file differs from the setup script in some ways, such as:

- Setup script is only for Linux, so Section 0 will not apply
- Instead of copying files such as `.zshrc`, `.vimrc`, etc., symlinks are used to 'sync' the files
- The setup script also adds some of the 'extra' links, namely some configuration and files within the `competitive/` folder.  This includes, but is not limited to:
    - A `.template.cpp` code template for C++ (from `plasmatic1/templates`)
    - A `push_config.sh` script that will export configuration data to subfolders for various categories of problems (i.e. by judge)
    - A `tools/` folder with some scripts for data-based contests such as FHC
    - Symlinks to `plasmatic1/templates` and the downloads folder on your machine

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

- `sudo apt install tmux`

## install zsh

- `sudo apt install zsh`

_Note that on Linux systems, you may need to log out and back in for the shell to change._

## install oh-my-zsh

- `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` # install oh-my-zsh
- Copy over `.zshrc` from the repository to `~`.  A link can be used instead

# Section 2: Vim

## Python 3.7 (or any other python version)

_Note that if another python version is desired, the steps can be replaced for any other python version.  However, running update-alternatives to change the source of python3 may fail on unix systems and make it impossible to start the terminal normally._

- Run the following commands:
- `sudo apt update`
- `sudo apt install software-properties-common`
- `sudo add-apt-repository ppa:deadsnakes/ppa`
- `sudo apt install python3.7`
- `update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1`
- `sudo apt install python3.7-dev` for the python3.7 headers.  This is needed for YCM installation

## VimRC

- Copy over `.vimrc` from the repository to `~`.  A link can be used instead
- Copy over `.sub_cpp.py` from the repository to `~`.  A link can be used instead
- Copy over `~/.sub_cpp.py`
- `chmod +x ~/.sub_cpp.py`

## Install vundle

- https://github.com/VundleVim/Vundle.vim#about
- Clone and copy required files (WIP: LINK)
- `vim +PluginInstall +qall` to auto install all plugins

## YouCompleteMe pre-setup

- `sudo apt install cmake
- `pip3 install future`

## YouCompleteMe 

- `python3 ~/.vim/bundle/youcompleteme/install.py --clangd-completer`
- Copy over `.ycm_extra_conf.py` from the repository to `~`.  A link can be used instead

# Section 3: CP Tools

## CP Tools Console

- `pip3 install cp-tools-console` (or install in dev mode)
	- Dev mode setup
		- `git clone https://github.com/plasmatic1/cp-tools-console`
		- `cd cp-tools-console`
		- `python3 setup.py develop`
- `mkdir competitive && cd competitive`
- when starting: do `cd competitive && cpserv`

## Some extra tools

- `mkdir ~/competitive`
- `cp -r tools ~/competitive/`.  Alternatively, use a symlink
- It is also suggested to create a symlink to the downloads folder, which may help with moving around data files

## Cloning templates

- `git clone https://github.com/plasmatic1/templates`
- You can also create a symlink from the clone location to the competitive folder
