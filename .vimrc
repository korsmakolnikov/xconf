call plug#begin('~/.vim/bundle')
" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } |
  \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Color schemes
Plug 'blueshirts/darcula'

" Multicursor
Plug 'terryma/vim-multiple-cursors'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'

" undotree
Plug 'mbbill/undotree'                                                         " print a tree of undo

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" bufexplorer
Plug 'jlanzarotta/bufexplorer'

" goyo
Plug 'junegunn/goyo.vim'                                                       " disctraction free mode :Goyo, turn off by :Goyo!

" git
Plug 'airblade/vim-gitgutter'                                                  " print changes on left of line numbers
Plug 'zivyangll/git-blame.vim'                                                 " print blame in command bar
Plug 'tpope/vim-fugitive'

" docker
Plug 'ekalinin/Dockerfile.vim'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }                         " haskell language server client

" elixir
Plug 'elixir-editors/vim-elixir'                                               " elixir plug in
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" javascript
" Plug 'mxw/vim-jsx', { 'for': 'javascript' }                                    " vim-jsx and vim-javascript fix js highlightind
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Rust
Plug 'rust-lang/rust.vim'

" elm
Plug 'elmcast/elm-vim'

" gleam
Plug 'gleam-lang/gleam.vim'

" Erlang
Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-erlang/vim-erlang-skeletons'

" graphql
Plug 'jparise/vim-graphql'

" snippet
Plug 'honza/vim-snippets'
Plug 'neoclide/coc-snippets'

" orgmode
Plug 'jceb/vim-orgmode'

call plug#end()

"COLORSCHEME
colorscheme darcula 
if &term =~ 'xterm-kitty'
  set t_ut=
endif

" BASIC
syntax enable
set number

" Clipboard
set clipboard=unnamed

" Load local .vimrc
set exrc

" Required for operations modifying multiple buffers like rename.
set hidden

" Cursor configuration 
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" command line
set cmdheight=2

" Editor configuration
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab
" Fix backspace
set bs=2

" Fix E418
set fileformat=unix

" consent to move freely in the page even if there are no spaces
set virtualedit=all 

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" COC
let elsp_path = $ELSP
call coc#config("elixir.pathToElixirLS", elsp_path . "/language_server.sh")
" call coc#config("elixirLS.dialyzerEnabled", "false") fa crashare lsp...

" nerdtree
" close nerdtree on startup
let g:NERDTreeHijackNetrw = 0

" nerdtree on the right
let g:NERDTreeWinPos = "right"

" nerdtree size
let NERDTreeWinSize = 50

" auto close nerdtree when opening a file
let NERDTreeQuitOnOpen = 1

autocmd VimEnter * NERDTree | wincmd p | NERDTreeClose

" automatically quit if nerdtree is the only windows
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" prevent other buffer to replace nerdtree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

function! IsNerdTreeEnabled()
  return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

function! ToggleNerdTree()
  :if IsNerdTreeEnabled()
  :execute "NERDTreeClose" | echom "close nerdtree"
  :else
  :execute "NERDTree" | echom "toggle nerdtree"
  :endif
endfunction

nnoremap <silent> <C-c> :NERDTreeFind<CR>

" git plugin 
" show ignored status
let g:NERDTreeGitStatusShowIgnored = 1 

" end nerdtree

" AIRLINE
" Airline configuration
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
" end airline

"VIM GO
let g:go_def_mapping_enabled = 0
let g:go_auto_sameids = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 1
let g:go_fmt_autosave = 0
let g:go_test_show_name=1
let g:go_code_completion_enabled=0
let g:go_updatetime = 150
let g:go_jump_to_error = 1

autocmd FileType go setlocal shiftwidth=8 tabstop=8

" HIE configuration 
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

" RUST
let g:rustfmt_autosave = 1

" autoformat on save
autocmd BufWritePre *.rs :call CocAction('format') 
autocmd BufWritePre *.exs :call CocAction('format')
autocmd BufWritePre *.ex :call CocAction('format') 
autocmd BufWritePre *.go :call CocAction('format') 
autocmd BufWritePre *.erl :call CocAction('format')  
autocmd BufWritePre *.hrl :call CocAction('format') 

"
" Mapping (keep EOF)
"
"
" leader
let mapleader = ","

" BUFFERS
nnoremap <silent> <TAB> :bn<CR> :redraw<CR>
nnoremap <silent> <S-TAB> :bp<CR> :redraw<CR>

" tab in visual/selection mode
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" MyPoweryank
function Poweryank() range
  echo 'copy to system clipboard'
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| xclip -selection clipboard')
  endfunction
" end poweryank
"
" Copy to system clipboard
xnoremap <C-y> :call Poweryank()<cr> 

" coc
" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
imap <C-l> <Plug>(coc-snippets-expand)
" tab for completition
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" enable mouse scrolling of documentation
set mouse=a
" end coc
"
" bufexplorer
" end bufexplorer

" undotree 
" end undotree

" fzf
function! QuickSearch () 
  let currentWord = expand("<cword>")
  :execute "Rg ". currentWord
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ""
    endif

    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -range SearchSelection :call RipgrepFzf(substitute(@*,"\n"," ","g"), 0)  

nnoremap <silent> <C-f> :call QuickSearch()<CR>
nnoremap <silent><Leader>/ :call RipgrepFzf("", 0)<CR>
vmap <silent><Leader>/ <Esc>:RG <C-R>=<SID>getVisualSelection()<CR><CR>

" end fzf
"
" vim-go
" TODO map only in go
autocmd FileType go noremap <Leader>b :GoDebugBreakpoint<CR>
autocmd FileType go noremap <Leader>s :GoDebugStart<CR>
autocmd FileType go noremap <Leader>t :GoDebugTest<CR>
autocmd FileType go noremap <Leader>gg :GoDebugRestart<CR>
autocmd FileType go noremap <Leader>G :GoDebugContinue<CR>
autocmd FileType go noremap <Leader>q :GoDebugStop<CR>
autocmd FileType go noremap <Leader>e :GoDebugStep<CR>
autocmd FileType go noremap <Leader>w :GoDebugStepout<CR>
autocmd FileType go noremap <Leader>p :GoDebugPrint
autocmd FileType go noremap <Leader>fs :GoFillStruct<CR>
autocmd FileType go noremap <Leader>k :GoKeyify<CR>
autocmd FileType go noremap <Leader>r :GoIfErr<CR>

" buffer 
" path copy 
:command! -nargs=1 FileNameYank execute ':silent !echo '.<q-args>.' | xclip -selection clipboard' | execute ':redraw!'
:nmap <silent> by :FileNameYank %<CR>
" close 
nnoremap <Leader>bd :bd<CR>


" FUNCTION KEYS
nnoremap <silent> <F2> :call ToggleNerdTree()<CR>
nnoremap <silent> <F3> :call BufExplorer()<CR>
nnoremap <Leader>. :Buffers<CR>
nnoremap <F5> :History<CR>
nnoremap <Leader><Leader> :GFiles<CR>
nnoremap <F7> :Marks<CR>
nnoremap <F8> :BLines<CR>
nnoremap <F9> :Files<CR>
nnoremap <S-F8> :Lines<CR>
vmap <F10> :SSel<CR>
nnoremap <silent> <F11> :UndotreeToggle<cr>
nnoremap <silent> <F12> :execute "e ~/.vimrc"<CR>
nnoremap <silent> <S-F12> :execute "source ~/.vimrc"<CR>

" Sort lines
vmap <silent> ls :'<,'>sort u<CR>
vmap <silent> lus :'<,'>sort! u<CR>
