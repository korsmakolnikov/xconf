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
autocmd FileType go noremap <Leader>gr :GoRun<CR>

