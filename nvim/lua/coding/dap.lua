-- DAP debug
vim.keymap.set("n", "<F5>", require 'dap'.continue, { buffer = bufnr })
-- nnoremap <silent> <F9> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_out()<CR>
vim.keymap.set("n", "<Leader>b", require 'dap'.toggle_breakpoint, { buffer = bufnr })
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb',
}

dap.configurations.env = function()
  local variables = {}
  for k, v in pairs(vim.fn.environ()) do
    table.insert(variables, string.format("%s=%s", k, v))
  end
  return variables
end

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dapui").setup()
vim.keymap.set("n", "<M-k>", require 'dapui'.eval, { buffer = bufnr })
dap.listeners.after.event_initialized["dapui_config"] = function()
  require 'dapui'.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  require 'dapui'.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  require 'dapui'.close()
end
