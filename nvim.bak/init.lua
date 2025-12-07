vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- 自定义的lazy.nvim安装路径
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- 如果 lazy.nvim 不存在，则通过 Git 克隆它到指定路径
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- 将 lazy.nvim 的安装路径添加到 Neovim 的运行时路径中，以便 Neovim 能找到它
vim.opt.rtp:prepend(lazypath)

-- 这里引入的文件就是 `lua/configs/lazy.lua`，它包含了 lazy.nvim 的一些基本配置
local lazy_config = require "configs.lazy"

-- 加载插件
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
