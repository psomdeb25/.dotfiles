set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

"" Activate (by uncommenting) this only if you are using Vim. DO NOT USE for neovim 
" source ~/.vim/vimrc

" Vimrc files are stored in the .vim directory but that is typically only used 
" by Classic ViM. NeoViM uses init.vim which is stored in a separate 
" directory. In my case it is ~/.config/nvim

" Author: from Bram Moolenaar and modified by Somdeb Paul 

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype plugin on 		" required 

set number
set relativenumber
set autoindent  "always set autoindenting on
set mouse
set showcmd		" display incomplete commands
set nowrap		" turns off text wrapping
set spell 		" turns on spell check for all files
set encoding=utf-8

syntax on

" autocmd BufNewFile,BufRead *.txt,*.html,README set spell "turns 
" on spell check only for specified files
"
set ruler		" show the cursor position all the time

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sample settings for vim-r-plugin and screen.vim
" Installation 
"       - Place plugin file under ~/.vim/
"       - To activate help, type in vim :helptags ~/.vim/doc
"       - Place the following vim conf lines in .vimrc
" Usage
"       - Read intro/help in vim with :h vim-r-plugin or :h screen.txt
"       - To initialize vim/R session, start screen/tmux, open some *.R file in vim and then hit F2 key
"       - Object/omni completion command CTRL-X CTRL-O
"       - To update object list for omni completion, run :RUpdateObjList
" added softtabstop and expandtab, changed shiftwidth from 8.  
" start R with F2 key

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" set folding scheme; more on this see: 
" http://www.dgp.toronto.edu/~mjmcguff/learn/vim/folding.txt
" http://vim.dindinx.net/orig/usr_28.txt
"set foldcolumn=0 " if set to > 1 together with 'set number', then the copy&paste of screen will include the line numbers
"highlight Folded ctermfg=yellow ctermbg=blue  	
" highlight  works only when colorscheme is uncommented
"set foldmethod=indent
"hi FoldColumn ctermbg=NONE

" This is an alternative that also works in block mode, but the 
" deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

"disable writing mode
set noshowmode
set formatoptions=tacqwn


"Plugin Manager - Vundle.vim
" Set the runtime path to include Vundle and initialise
set rtp+=~/.vim/bundle/Vundle.vim
" All the plugins will be downloaded under this directory 
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Declare the list of plugins.
Plugin 'Nequo/vim-allomancer'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'lervag/vimtex'
Plugin 'Shougo/deoplete.nvim'
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'rose-pine/neovim'
" List ends here. Plugins become visible to vim after this. 
call vundle#end()

"" PLUGIN CUSTOMIZATIONS

" Using the airline powerline fonts
let g:airline_powerline_fonts = 1

" See docstrings for folded code
let g:SimpylFold_docstring_preview=1

" Make Python code look pretty
let python_highlight_all=1
syntax on

" Proper PEP8 indenting for Python
au BufNewFile,BufRead *.py set tabstop=4 set softtabstop=4 set shiftwidth=4 set textwidth=79 set expandtab set autoindent set fileformat=unix

" This is necessary for VimTeX to load properly. The "indent" is optional
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements") for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

"" Use deoplete
let g:deoplete#enable_at_startup = 1

"" Make neovim transparent
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

"" Customize Rose-pine color palette
lua << EOF
require("rose-pine").setup()
vim.cmd("colorscheme rose-pine")
EOF
