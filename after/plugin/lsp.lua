local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "[o", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[p", function() vim.diagnostic.setqflist() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- if vim.lsp.inlay_hint then
  --   vim.lsp.inlay_hint.enable(true, { 0 })
  -- end

  if vim.lsp.inlay_hint then
    vim.keymap.set("n", "<leader>L",
    function()
      print("Toggle Inlay Hints")
      if vim.lsp.inlay_hint.is_enabled({})
        then vim.lsp.inlay_hint.enable(false, { bufnr })
      else vim.lsp.inlay_hint.enable(true, { bufnr })
      end
    end)
  end
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- require('orgmode').setup_ts_grammar()
--
-- require('orgmode').setup({
--   org_agenda_files = {'~/org/*'},
--   org_default_notes_file = '~/org/refile.org',
-- })

-- require('mason-lspconfig').setup({
--     handlers = {
--         lsp.default_setup,
--         pylsp = function ()
--             require('lspconfig').pylsp.setup({
--                 autostart=true,
--             })
--         end,
--         ruff_lsp = function ()
--             require('lspconfig').ruff_lsp.setup({
--                 autostart=false,
--             })
--         end,
--         pyright = function ()
--             require('lspconfig').pyright.setup({
--                 autostart=false,
--             })
--         end,
--     }
-- })
