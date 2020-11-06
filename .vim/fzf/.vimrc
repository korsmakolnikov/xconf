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

