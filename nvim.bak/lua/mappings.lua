require "nvchad.mappings"

-- common
local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
-- 将ESC映射为JK
map("i", "jk", "<ESC>")
-- 保存文件
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "file save" })
-- 撤销文件
-- map({ "n", "i", "v" }, "<C-z>", "<cmd> undo <cr>", { desc = "history undo" })
-- 重做
map({ "n", "i", "v" }, "<C-y>", "<cmd> redo <cr>", { desc = "history redo" })

-- 注释/撤销注释
map("n", "<C-_>", "gcc", { desc = "comment toggle", remap = true })
map("i", "<C-_>", "<Esc>gcc^i", { desc = "comment toggle", remap = true })
map("v", "<C-_>", "gc", { desc = "comment toggle", remap = true })

-- 文件模糊搜索
map({ "n", "i", "v" }, "<C-f>", function()
  if vim.bo.filetype == "TelescopePrompt" then
    vim.cmd "q!"
  else
    vim.cmd "Telescope current_buffer_fuzzy_find"
  end
end, { desc = "search search in current buffer" })

-- 项目模糊搜索
map({ "n", "i", "v" }, "<A-f>", function()
  if vim.bo.filetype == "TelescopePrompt" then
    vim.cmd "q!"
  else
    vim.cmd "Telescope live_grep"
  end
end, { desc = "search search across project" })

-- 呼出终端
map({ "n", "i", "v", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggle vertical term" })
map({ "n", "i", "v", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggle horizontal term" })
map({ "n", "i", "v", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- LSP
-- 等同于 `K`
map("n", "gb", "<C-o>", { desc = "jump jump back" })
map("n", "gh", vim.lsp.buf.hover, { desc = "LSP hover" })
--.呼出诊断信息
map("n", "ge", vim.diagnostic.open_float, { desc = "LSP show diagnostics" })
-- 呼出代码操作
map({ "n", "i", "v" }, "<A-.>", vim.lsp.buf.code_action, { desc = "LSP code action" })
-- 重命名
map({ "n", "i", "v" }, "<F2>", function()
  if vim.bo.filetype == "NvimTree" then
    -- 如果在文件浏览器中，调用 NvimTree 的重命名功能
    require("nvim-tree.api").fs.rename()
  else
    require "nvchad.lsp.renamer"()
  end
end, { desc = "LSP rename" }) -- 重命名符号，等同于 NvChad 的快捷键 `<leader>ra`
-- 跳转到定义，等同于 `gd`
map({ "n", "i", "v" }, "<F12>", vim.lsp.buf.definition, { desc = "LSP rename" })
