return {
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require("lspconfig").gopls.setup {}
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline", 
      "hrsh7th/cmp-path", 
      "hrsh7th/cmp-nvim-lsp", 
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      { "l3mon4d3/luasnip", version = "v2.*", build = "make install_jsregexp" },
    },
    config = function ()
      local cmp = require("cmp")

      cmp.setup {
        preselect = "none",

        snippet = {
          expand = function (args)
            require("luasnip").lsp_expand(args.body)
          end
        },

        -- Code editing
        mapping = {
          ["<C-j>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ["<C-k>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ["<PageDown>"] = cmp.mapping.scroll_docs(4),
          ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        },

        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
          { name = "path" },
        })
      }

      -- Text search
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = {
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<PageDown>"] = cmp.mapping.scroll_docs(4),
          ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
        },
        sources = cmp.config.sources({
          { name = "buffer" },
        })
      })

      -- Command execution
      cmp.setup.cmdline({ ":" }, {
        mapping = {
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<PageDown>"] = cmp.mapping.scroll_docs(4),
          ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
        },
        sources = cmp.config.sources({
          { name = "path", option = { trailing_slash = false, label_trailing_slash = true } }
        }, {
          { name = "cmdline" }
        })
      })
    end
  }
}
