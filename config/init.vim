" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

if !exists('g:vscode')
"" Initialize plugin system
"call plug#begin('~/.local/share/nvim/plugged')
"" Colourschemes
""Plug 'joshdick/onedark.vim'
""Plug 'arcticicestudio/nord-vim'
""" LANGUAGE SERVER
"Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
""" LINTING
""Plug 'w0rp/ale'
""" FUZZY FILE SEARCH
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"Plug 'mhinz/vim-grepper'
"Plug 'ap/vim-buftabline'
"" Haskell
"Plug 'neovimhaskell/haskell-vim'
"" Java / kotlin
"Plug 'beeender/Comrade'
"Plug 'udalov/kotlin-vim'
"call plug#end()

" -----------------------------------------------------------------------------
" Keybindings
" -----------------------------------------------------------------------------

" Base64
"<leader>btoa: convert to base64
"<leader>atob: convert from base64

" Tabs (buffers)
"alt+j: previous buffer
"alt+k: next buffer

" Commentary
"gc: toggle comments

" Sneak (two character find)
"s: sneak instantly
"z: sneak as motion

" Find
nnoremap <c-p> :FZF<cr>
nnoremap <M-k> :bnext<CR>
nnoremap <M-j> :bprev<CR>
nnoremap <M-n> :enew<CR>
nnoremap <M-q> :bdelete<CR>

" Refactor
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf  <Plug>(coc-fix-current)
" Gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Tools
"nmap gs <plug>(GrepperOperator)
"xmap gs <plug>(GrepperOperator)
" Escape to get out of insert mode in terminals
tnoremap <Esc> <C-\><C-n> 
nnoremap <silent> K :call <SID>show_documentation()<CR>
" nmap ]e :ALENext -error<cr>
" nmap [e :ALEPrevious -error<cr>
"nnoremap <leader>fu :action FindUsages<cr>
"nnoremap <leader>su :action ShowUsages<cr>
nnoremap <leader>fp :Grepper -tool rg<cr> |" Find in Path (kinda broken)
nnoremap <leader>fb :Grepper -tool rg -buffers<cr> |" Find in Buffers (kinda broken)
"nnoremap <leader>ga :action GotoAction<cr>
"nnoremap <leader>gc :action GotoClass<cr>
nnoremap <leader>gf :FZF<cr> |" Goto File
"nnoremap <leader>gs :action GotoSymbol<cr>
"nnoremap <leader>sh :action ActivateTerminalToolWindow<cr>
nnoremap <leader>F :call CocAction('format')<CR>

" Split movement
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" -----------------------------------------------------------------------------
" Configuration
" -----------------------------------------------------------------------------

" Indent without losing selection
vnoremap > >gv^
vnoremap < <gv^

let g:sneak#streak = 1
" Optional. The default behaviour should work for most users.
let g:grepper               = {}
let g:grepper.tools         = ['git', 'ag', 'rg']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0

" Colorscheme
packadd! onedark-vim
colorscheme onedark

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Fuzzy finder
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Hide buffers instead of closing them when opening new files
set hidden

" Tab completion
set wildmode=longest,list 

" Use system clipboard
set clipboard+=unnamedplus

" Spaces & Tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType haskell setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType nix setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json syntax match Comment +\/\/.\+$+

else

nnoremap <M-k> :Tabnext<CR>
xnoremap <M-k> :Tabnext<CR>
nnoremap <M-j> :Tabprev<CR>
xnoremap <M-j> :Tabprev<CR>
nnoremap <M-q> :Tabclose<CR>
xnoremap <M-q> :Tabclose<CR>

endif
