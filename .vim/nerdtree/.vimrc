" Nerdtree
let g:NERDTreeHijackNetrw = 0                                                  " close nerdtree on startup 
let g:NERDTreeWinPos = "right"                                                 " nerdtree on the right 
let NERDTreeWinSize = 50                                                       " nerdtree size 
let NERDTreeQuitOnOpen = 1                                                     " auto close nerdtree when opening a file 

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

function! NERDTreeFindWithInit()
  :execute "NERDTree" 
  :execute "wincmd p"
  :execute "NERDTreeFind"
endfunction

nnoremap <silent> <C-c> :call NERDTreeFindWithInit()<CR>

" Git plugin 
let g:NERDTreeGitStatusShowIgnored = 1                                         " show ignored status 
