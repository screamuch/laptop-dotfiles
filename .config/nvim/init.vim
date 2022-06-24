" NVIM CONFIG

" line numbers (relative)
set rnu

" line wrapping
set wrap

" enable mouse
set mouse=a

" indentation with spaces (2)
set expandtab
set tabstop=2

" << and >> keybindings
set shiftwidth=2

" Window Navigation with Ctrl-[hjkl]
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" vimplug config (specify directory?)
call plug#begin()
  " The default plugin directory will be as follows:
  "   - Vim (Linux/macOS): '~/.vim/plugged'
  "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
  " You can specify a custom plugin directory by passing it as the argument
  "   - e.g. `call plug#begin('~/.vim/plugged')`
  "   - Avoid using standard Vim directory names like 'plugin'

  " Plugs go right below
  " Make sure you use single quotes

  " better syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " Nerdtree
  Plug 'scrooloose/NERDTree'

  " autopairs for brackets
  Plug 'jiangmiao/auto-pairs'

  " github light theme
  Plug 'romgrk/github-light.vim'

  " lightline bottom bar
  Plug 'itchyny/lightline.vim'

  " Conquer of completion or whatever the fuck it's called
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
 
  " comment shortcuts
  Plug 'preservim/nerdcommenter' 

  " Initialize plugin system
call plug#end()

