call plug#begin('~/.vim/bundle')
" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } |
  \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Color schemes
Plug 'blueshirts/darcula'

" Multicursor
Plug 'terryma/vim-multiple-cursors'

" OSC52 (kitty clipboard)
Plug 'greymd/oscyank.vim'

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
Plug 'airblade/vim-gitgutter'                                                " print changes on left of line numbers
Plug 'tpope/vim-fugitive'

" docker
Plug 'ekalinin/Dockerfile.vim'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }                         " haskell language server client

" elm
Plug 'elmcast/elm-vim'

" elixir
Plug 'elixir-editors/vim-elixir'                                               " elixir plug in
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" gleam
Plug 'gleam-lang/gleam.vim'

" Erlang
Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-erlang/vim-erlang-skeletons'

" javascript
" Plug 'mxw/vim-jsx', { 'for': 'javascript' }                                    " vim-jsx and vim-javascript fix js highlightind
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Rust
" Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}

" graphql
Plug 'jparise/vim-graphql'

" snippet
Plug 'honza/vim-snippets'
Plug 'neoclide/coc-snippets'

" orgmode
Plug 'jceb/vim-orgmode'

call plug#end()

" GLOBAL FUNCTIONS 
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

" COLORSCHEME
colorscheme darcula 
if &term =~ 'xterm-kitty'
  set t_ut=
endif

" Basic
syntax enable                                                                  " enable syntax 
set number                                                                     " enable line numbers
set colorcolumn=80                                                             " set vertical column at 80
set exrc                                                                       " Load local .vimrc
set hidden                                                                     " Required for operations modifying multiple buffers like rename. 
set guicursor+=n-v-c:blinkon0                                                  " Cursor configuration  
set guicursor+=i:blinkwait10
set cmdheight=2                                                                " command line height 
set tabstop=2                                                                  " tab size 
set shiftwidth=2
set expandtab                                                                  " On pressing tab, insert spaces 
set bs=2                                                                       " Fix backspace 
set fileformat=unix                                                            " Fix E418
set virtualedit=all                                                            " consent to move freely in the page even if there are no spaces 
set updatetime=50                                                              " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable 
                                                                               " delays and poor user experience. 
" ELSP interpolation
function! ParseToolFile()
  let tool_file_path = "./.tool-versions"
  if filereadable(tool_file_path)
    let tool_file = readfile(tool_file_path)
    for line in tool_file
      if line =~ '^elixir.*$'
        let elsp_path = $HOME . '/' . substitute(line, 'elixir\s', '\.elsp-', '')
        call coc#config("elixir.pathToElixirLS", elsp_path . "/language_server.sh")
      endif
    endfor
  endif
endfunction
autocmd VimEnter * call ParseToolFile()

" Coc
set mouse=a                                                                    " enable mouse scrolling of Coc documentation 
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" call coc#config("elmLS.trace.server", "verbose") did not work
" call coc#config("elixirLS.dialyzerEnabled", "false") cousing crash 

" Nerdtree
let g:NERDTreeHijackNetrw = 0                                                  " close nerdtree on startup 
let g:NERDTreeWinPos = "right"                                                 " nerdtree on the right 
let NERDTreeWinSize = 50                                                       " nerdtree size 
let NERDTreeQuitOnOpen = 1                                                     " auto close nerdtree when opening a file 
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

" Git plugin 
let g:NERDTreeGitStatusShowIgnored = 1                                         " show ignored status 

" Airline configuration
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1

" Languages integration
autocmd BufWritePre *.rs :call CocAction('format')                             " Autoformat on save 
autocmd BufWritePre *.exs :call CocAction('format')
autocmd BufWritePre *.ex :call CocAction('format') 
autocmd BufWritePre *.go :call CocAction('format') 
autocmd BufWritePre *.erl :call CocAction('format')  
autocmd BufWritePre *.hrl :call CocAction('format') 
autocmd BufWritePre *.elm :call CocAction('format') 

" Elm
au BufRead,BufNewFile *.elm set filetype=elm | syntax on

" Golang
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

" Haskell HIE configuration 
let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

" Rust
let g:rustfmt_autosave = 1

" Mapping 
let mapleader = ","                                                            " leader 
xnoremap <Tab> >gv |                                                           " Tab in visual/selection mode 
xnoremap <S-Tab> <gv
noremap <C-y> :Oscyank<cr> |                                                   " Copy to system clipboard 

" Buffer section
nnoremap <silent> <TAB> :bn<CR> :redraw<CR>
nnoremap <silent> <S-TAB> :bp<CR> :redraw<CR>
function! FileNameYank()
  let @" = expand("%")
  :execute "OscyankRegister"
endfunction
:command! FileNameYank call FileNameYank()                                     " buffer path copy 
:nmap <silent><Leader>fy :FileNameYank<CR>
nnoremap <silent><Leader>bd :bd<CR> |                                          " close buffer 
nnoremap <silent><Leader>bK :bufdo bd<CR> |                                    " close all buffer
"TODO leader bD to close all buffer but the currently opened

" Coc section
function! s:show_documentation()                                               
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>|                       " Use K to show documentation in preview window.  
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
imap <C-l> <Plug>(coc-snippets-expand)
                                                                               " Tab completition
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Fzf/RipGrep
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

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -range SearchSelection :call RipgrepFzf(substitute(@*,"\n"," ","g"), 0)  
nnoremap <silent> <C-f> :call QuickSearch()<CR>
nnoremap <silent><Leader>/ :call RipgrepFzf("", 0)<CR>
vmap <silent><Leader>/ <Esc>:RG <C-R>=<SID>getVisualSelection()<CR><CR>

" Navigation section
nnoremap <silent> <F2> :call ToggleNerdTree()<CR>
nnoremap <silent> <F3> :call BufExplorer()<CR>
nnoremap <Leader>. :History<CR>
nnoremap <Leader><Leader> :Buffers<CR>
nnoremap <Leader><Space> :GFiles<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>L :Lines<CR>
nnoremap <Leader>u :UndotreeToggle<cr>
nnoremap <silent> <F12> :execute "e ~/.vimrc"<CR>
nnoremap <silent> <S-F12> :execute "source ~/.vimrc"<CR>

" Sort lines
vmap <silent><Leader>s :'<,'>sort u<CR>
vmap <silent><Leader>us :'<,'>sort! u<CR>
