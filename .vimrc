" -------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'tomtom/tcomment_vim'
Plugin 'valloric/youcompleteme'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()

" -------------------------------------------
" Custom Changes
" -------------------------------------------

" ===== General Stuff =====
syntax on

set nu rnu

" Source: https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Source: https://superuser.com/questions/4511/delete-space-expanded-tab-in-vim-with-one-keystroke
set softtabstop=4

" Macro define
let @f = "0i      \<C-c>j"

" ===== Remaps =====

" Tabs
:nnoremap <C-Right> :tabn<CR><LF>
:nnoremap <C-Left> :tabp<CR><LF>

" Clipboard
function! CopyFileToClipboard()
    execute ':w'
	execute ':w !clip.exe'
endfunction

if executable('clip.exe')
	nnoremap ;C :call CopyFileToClipboard()<CR><LF>
    nnoremap ;P :r !powershell.exe -command "Get-Clipboard"<CR><LF>
endif

" Building Code
function! BuildFile(extra_args)
    let spl = split(getline(1), ' ')
    if spl[0] != '//' && spl[0] != '#'
        echom 'Currently open file does not have an input file defined'
        return
    endif

    let i_file = join(spl[1:], ' ')
    let verbose_str = (g:cptools_verbose ? '--verbose ' : '') 

    execute ':w'
    execute '!./' . i_file . ' ' . @% . ' --pause-when-done ' . verbose_str . a:extra_args 
endfunction

:nnoremap <C-b> :call BuildFile('')<CR><LF>
:nnoremap <Esc>b :call BuildFile('--executor cpp-debug')<CR><LF>

command! Verbose :call ToggleVerbose()
let g:cptools_verbose = 0
function! ToggleVerbose()
    let g:cptools_verbose = 1 - g:cptools_verbose
    echom 'Verbose mode is now ' . (g:cptools_verbose ? 'ON' : 'OFF')
endfunction

" Substitutions
function! CompleteLine()
    if expand('%:e') != 'cpp'
        return
    endif

    let res = system('python3 ~/.sub_cpp.py ' . shellescape(getline('.')))
    echom 'got res "' . res . '"'

    call append(line('.') - 1, split(res, "\n"))
    normal! ddkk
    call feedkeys('A', 'n')
endfunction

:inoremap <C-k> <C-c>:call CompleteLine()<CR><LF>

" Changing cursor by mode
" Highlighting cursor

" ===== Plugin Related =====

" Vim-Easymotion highlight colours
" Source: https://stackoverflow.com/questions/6126871/easymotion-coloring-in-vim-with-solarized-theme
hi link EasyMotionShade Comment

" YouCompleteMe
" Source: https://github.com/l3nkz/ycmconf/blob/master/ycm_extra_conf.py (modified from source)
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:ycm_min_num_of_chars_for_completion = 0
let g:ycm_min_num_identifier_candidate_chars = 1
let g:ycm_max_num_candidates = 20
let g:ycm_autoclose_preview_window_after_completion = 1

" Airline Themes
let g:airline_theme='wombat'
