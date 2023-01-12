-- Neovide
if vim.g.neovide then
  --Put anything you want to happen only in Neovide here
  vim.cmd([[
    map! <C-S-v> <C-R>+
  ]])
end

