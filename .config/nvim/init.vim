" NVIM CONFIG

" line numbers (relative)
set rnu
" line number (current)
set nu

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

" for the colorizer
set termguicolors

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

  " Show hex colors
  Plug 'norcalli/nvim-colorizer.lua'

  " explains what key to press
  Plug 'liuchengxu/vim-which-key'

  " Initialize plugin system
call plug#end()

" colorizer stuff
lua require'colorizer'.setup()

" whichkey shortcut
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" system clipboard
set clipboard+=unnamedplus
