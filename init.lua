require("theprimeagen")
require'lspconfig'.gopls.setup{}
require'lspconfig'.pyright.setup{}

 require'lspconfig'.templ.setup{}
 require'lspconfig'.html.setup({
     on_attach = on_attach,
     capabilities = capabilities,
     filetypes = { "html", "templ" },
 })
require'lspconfig'.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    settings = {
      tailwindCSS = {
        includeLanguages = {
          templ = "html",
        },
      },
    },
})

require'lspconfig'.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            folders = {},
        }
    },
  default_component_configs = {
    icon = {
      folder_empty = "󰜌",
      folder_empty_open = "󰜌",
    },
    git_status = {
      symbols = {
        renamed   = "󰁕",
        unstaged  = "󰄱",
      },
    },
  },
  document_symbols = {
    kinds = {
      File = { icon = "󰈙", hl = "Tag" },
      Namespace = { icon = "󰌗", hl = "Include" },
      Package = { icon = "󰏖", hl = "Label" },
      Class = { icon = "󰌗", hl = "Include" },
      Property = { icon = "󰆧", hl = "@property" },
      Enum = { icon = "󰒻", hl = "@number" },
      Function = { icon = "󰊕", hl = "Function" },
      String = { icon = "󰀬", hl = "String" },
      Number = { icon = "󰎠", hl = "Number" },
      Array = { icon = "󰅪", hl = "Type" },
      Object = { icon = "󰅩", hl = "Type" },
      Key = { icon = "󰌋", hl = "" },
      Struct = { icon = "󰌗", hl = "Type" },
      Operator = { icon = "󰆕", hl = "Operator" },
      TypeParameter = { icon = "󰊄", hl = "Type" },
      StaticMethod = { icon = '󰠄 ', hl = 'Function' },
    }
  },
  -- Add this section only if you've configured source selector.
  source_selector = {
    sources = {
      { source = "filesystem", display_name = " 󰉓 Files " },
      { source = "git_status", display_name = " 󰊢 Git " },
    },
  },
  -- Other options ...
})
--
 local templ_format = function()
     local bufnr = vim.api.nvim_get_current_buf()
     local filename = vim.api.nvim_buf_get_name(bufnr)
     local cmd = "templ fmt " .. vim.fn.shellescape(filename)
--
     vim.fn.jobstart(cmd, {
         on_exit = function()
             -- Reload the buffer only if it's still the current buffer
             if vim.api.nvim_get_current_buf() == bufnr then
                 vim.cmd('e!')
             end
         end,
     })
 end
--
 vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = templ_format })
