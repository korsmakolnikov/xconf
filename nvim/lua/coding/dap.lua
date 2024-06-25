-- :fennel:1719609746
local dap = require("dap")
dap.adapters.lldb = {command = "/usr/bin/lldb-vscode", name = "lldb", type = "executable"}
dap.configurations.env = function()
  local variables = {}
  for k, v in pairs(vim.fn.environ()) do
    table.insert(variables, string.format("%s=%s", k, v))
  end
  return variables
end
local function _1_()
  return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/"), "file")
end
dap.configurations.cpp = {{args = {}, cwd = "${workspaceFolder}", name = "Launch", program = _1_, request = "launch", type = "lldb", stopOnEntry = false}}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
require("dapui").setup()
dap.listeners.after.event_initialized.dapui_config = function()
  return require("dapui").open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  return require("dapui").close()
end
dap.listeners.before.event_exited.dapui_config = function()
  return require("dapui").close()
end
require("dap-vscode-js").setup({adapters = {"chrome", "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", "node", "chrome"}})
local js_based_languages = {"typescript", "javascript", "typescriptreact"}
for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {{cwd = "${workspaceFolder}", name = "Launch file", program = "${file}", request = "launch", type = "pwa-node"}, {cwd = "${workspaceFolder}", name = "Attach", processId = require("dap.utils").pick_process, request = "attach", type = "pwa-node"}, {name = "Start Chrome with \"localhost\"", request = "launch", type = "pwa-chrome", url = "http://localhost:3000", userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir", webRoot = "${workspaceFolder}"}}
end
return nil