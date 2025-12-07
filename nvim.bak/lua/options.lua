require "nvchad.options"

local opt = vim.opt

if vim.fn.has "win32" == 1 then
  vim.opt.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
  vim.opt.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  vim.opt.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | %{ "$_" } | tee %s; exit $LastExitCode'
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

--- Common
-- NvChad 默认只设置高亮当前行的行号，这里把整行也高亮了
opt.cursorlineopt = "both"

-- 相对行号主要是方便数行数，这样 `dd` 这种命令会容易用一些
opt.relativenumber = true

-- 显示特殊字符，比如尾随空格和 Tab
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- 启用 break indent，这个选项的意思是当一行过长触发自动换行时，会给换行前面添加一点缩进，更容易识别
opt.breakindent = true

-- 替换文本时展示一个单独的预览窗口，显示替换了哪几行
-- 这选项默认是 "nosplit"，也就是不展示这个预览窗口
-- opt.inccommand = "split"

-- 用来控制你滚动时上下至少要在视图里保留多少行
opt.scrolloff = 10

vim.o.guifont = "Fira code"

-- OSC 52设置
--- Enable OSC 52 for copying to system clipboard in SSH
-- See: https://github.com/neovim/neovim/issues/28611#issuecomment-2147744670
if os.getenv "SSH_TTY" then
  vim.g.clipboard = {
    name = "OSC 52",
    -- Try to use OSC 52 escape sequences to copy to system clipboard
    -- It should not break anything if it’s not supported
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    -- Disable paste since it does not work in some terminals,
    -- i.e., xterm.js (many app based on Web tech use this)
    paste = {
      ["+"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
      ["*"] = function(lines)
        return vim.split(vim.fn.getreg '"', "\n")
      end,
    },
  }
end
