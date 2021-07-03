if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.cache/dein')

" Let dein manage dein
call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('vim-scripts/vim-auto-save')
call dein#add('altercation/vim-colors-solarized')
call dein#add('lifepillar/vim-solarized8')
call dein#add('tomtom/tcomment_vim')
call dein#add('Yggdroot/indentLine')
call dein#add('vim-airline/vim-airline')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('scrooloose/nerdtree')
call dein#add('osyo-manga/vim-anzu')
call dein#add('autozimu/LanguageClient-neovim', {
  \ 'rev': 'next',
  \ 'build': 'bash install.sh',
  \ })
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/echodoc.vim')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('airblade/vim-gitgutter')
call dein#add('mattn/vim-goimports')
" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable
set number
" let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
colorscheme solarized8

" If you want to install not installed plugins on startup.
"if dein#check_install()
" call dein#install('altercation/vim-colors-solarized')
call dein#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
call dein#add('junegunn/fzf.vim')
"endif


set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
" set expandtab
set encoding=utf-8
set showmatch
set shortmess-=S
set cursorline
set ignorecase
set smartcase
set hlsearch
set whichwrap=b,s,h,l,<,>,[,],~
set clipboard+=unnamed,autoselect
setlocal spell spelllang=en_us


"-------------------------------------------------------------------------------
" Restore the last cursor position.
"-------------------------------------------------------------------------------
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif


"-------------------------------------------------------------------------------
" mapleader
"-------------------------------------------------------------------------------
let mapleader = ','


"-------------------------------------------------------------------------------
" fzf
"-------------------------------------------------------------------------------
set rtp+=/goinfre/$USER/.brew/opt/fzf
nnoremap <Leader>f :FZF<CR>
let $FZF_DEFAULT_OPTS = '--preview "bat --style=numbers --color=always --line-range :500 {}"'
nnoremap <silent> <Leader>r :<C-u>silent call <SID>find_rip_grep()<CR>

function! s:find_rip_grep() abort
    call fzf#vim#grep(
        \   'rg --ignore-file ~/.ignore --column --line-number --no-heading --hidden --smart-case .+',
        \   1,
        \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
        \   0,
        \ )
endfunction


"-------------------------------------------------------------------------------
" aut_save
"-------------------------------------------------------------------------------
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0


"-------------------------------------------------------------------------------
" vim-table-mode
"-------------------------------------------------------------------------------
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
    \ <SID>isAtStartOfLine('\|\|') ?
    \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
    \ <SID>isAtStartOfLine('__') ?
    \ '<c-o>:silent! TableModeDisable<cr>' : '__'

let g:table_mode_corner = '|'


"-------------------------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------------------------
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>n :NERDTreeToggle<CR>


"-------------------------------------------------------------------------------
" Show zenkaku spaces
"-------------------------------------------------------------------------------
function! ZenkakuSpace()
        highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
    endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif


"-------------------------------------------------------------------------------
" vim-anzu
"-------------------------------------------------------------------------------
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" statusline
set statusline=%{anzu#search_status()}
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif


"-------------------------------------------------------------------------------
" LanguageClient-neovim: LSP client
" gopls: LSP server
"-------------------------------------------------------------------------------
" Launch gopls when Go files are in use
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()

nmap <F5> <Plug>(lcn-menu)
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>


"-------------------------------------------------------------------------------
" deoplete
"-------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1


"-------------------------------------------------------------------------------
" echodoc
"-------------------------------------------------------------------------------
" Or, you could use neovim's floating text feature.
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'
" let g:echodoc#type = 'popup'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu


"----------------------------------------------------------
" ultisnips
"----------------------------------------------------------
let g:UltiSnipsUsePythonVersion    = 3
let g:UltiSnipsEditSplit           = 'normal'
let g:UltiSnipsSnippetDirectories  = ['~/.cache/dein/repos/github.com/honza/vim-snippets/UltiSnips']
let g:UltiSnipsEnableSnipMate      = 0
let g:UltiSnipsExpandTrigger       = '<c-k>'
let g:UltiSnipsJumpForwardTrigger  = '<c-f>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
command! SNIP UltiSnipsEdit
