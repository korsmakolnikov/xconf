
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

