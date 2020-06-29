#### Section 0: Windows terminal
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

#### Section 1: ZSH ####

# install zsh
- run `sudo apt install zsh`
- run `chsh -shell $(which zsh)` # change shell to zsh

# install oh-my-zsh
- run `sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` # install oh-my-zsh
- run `touch ~/.zshrc` # ??? idk if this is necessary
- Copy over proper zshrc

#### Section 2: Vim ####

# Install vim basics
- run `sudo apt install vim-gnome`

# YouCompleteMe pre-setup
- run `sudo apt install cmake
- run `pip3 install future`

# VimRC
- copy over `~/.vimrc`
- copy over `~/.sub_cpp.py`
- run `chmod +x ~/.sub_cpp.py`

# Install vundle
- https://github.com/VundleVim/Vundle.vim#about
- Clone and copy required files (WIP: LINK)
- copy over correct vimrc
- run `vim +PluginInstall +qall` to auto install all plugins

# YouCompleteMe 
- run python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer
- copy over `.ycm_extra_conf.py`

