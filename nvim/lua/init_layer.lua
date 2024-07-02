local m = {}

m.pack = "tangerine" or "packer" or "paq" or "lazy"
m.bootstrap = function(ref)
  local path
  local url = tostring(url or '')
  local name = url:gsub(".*/", "")
  if m.pack == "lazy" then
    path = vim.fn.stdpath("data") .. "/lazy/" .. name
    vim.opt.rtp:prepend(path)
  else
    path = vim.fn.stdpath("data") .. "/site/pack/" .. m.pack .. "/start/" .. name
  end

  if vim.fn.isdirectory(path) == 0 then
    print(name .. ": installing in data dir...")

    vim.fn.system { "git", "clone", url, path }
    if ref then
      vim.fn.system { "git", "-C", path, "checkout", ref }
    end

    vim.cmd "redraw"
    print(name .. ": finished installing")
  end

  return m
end

m.init_with_package_manager = function()
end

m.init_transpiler = function()
  require 'tangerine'.setup {
    compiler = {
      verbose = false,
      hooks = { "onsave", "oninit" }
    }
  }
end

return m
