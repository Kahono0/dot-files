require("theprimeagen")
require'lspconfig'.gopls.setup{}

require("elixir").setup({
  credo = {enable = false},
  elixirls = {enable = true},
})
