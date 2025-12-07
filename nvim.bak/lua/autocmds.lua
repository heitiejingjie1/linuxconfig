require "nvchad.autocmds"
require("lspconfig").clangd.setup {
  cmd = { "clangd" },
}
