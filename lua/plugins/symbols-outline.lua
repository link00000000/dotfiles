local keymap = require("utils.keymap")

local M = {}

local function config ()
    local symbols_outline = require("symbols-outline")
    local codicons = require('codicons')

    -- From barbecue/theme/default.lua
    local function get_highlight (name)
      local highlight = vim.api.nvim_get_hl_by_name(name, true)
      setmetatable(highlight, {
        __index = function(self, key)
          if key == "bg" then return self.background end
          if key == "fg" then return self.foreground end

          return nil
        end,
      })

      return highlight
    end

    vim.api.nvim_set_hl(0, "SymbolsOutlineFile",            { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineModule",          { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineNamespace",       { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlinePackage",         { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineClass",           { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineMethod",          { fg = get_highlight("Function").fg    })
    vim.api.nvim_set_hl(0, "SymbolsOutlineProperty",        { fg = get_highlight("Identifier").fg  })
    vim.api.nvim_set_hl(0, "SymbolsOutlineField",           { fg = get_highlight("Identifier").fg  })
    vim.api.nvim_set_hl(0, "SymbolsOutlineConstructor",     { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineEnum",            { fg = get_highlight("Type").fg        })
    vim.api.nvim_set_hl(0, "SymbolsOutlineInterface",       { fg = get_highlight("Type").fg        })
    vim.api.nvim_set_hl(0, "SymbolsOutlineFunction",        { fg = get_highlight("Function").fg    })
    vim.api.nvim_set_hl(0, "SymbolsOutlineVariable",        { fg = get_highlight("Identifier").fg  })
    vim.api.nvim_set_hl(0, "SymbolsOutlineConstant",        { fg = get_highlight("Constant").fg    })
    vim.api.nvim_set_hl(0, "SymbolsOutlineString",          { fg = get_highlight("String").fg      })
    vim.api.nvim_set_hl(0, "SymbolsOutlineNumber",          { fg = get_highlight("Number").fg      })
    vim.api.nvim_set_hl(0, "SymbolsOutlineBoolean",         { fg = get_highlight("Boolean").fg     })
    vim.api.nvim_set_hl(0, "SymbolsOutlineArray",           { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineObject",          { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineKey",             { fg = get_highlight("Identifier").fg  })
    vim.api.nvim_set_hl(0, "SymbolsOutlineNull",            { fg = get_highlight("Special").fg     })
    vim.api.nvim_set_hl(0, "SymbolsOutlineEnumMember",      { fg = get_highlight("Identifier").fg  })
    vim.api.nvim_set_hl(0, "SymbolsOutlineStruct",          { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineEvent",           { fg = get_highlight("Type").fg        })
    vim.api.nvim_set_hl(0, "SymbolsOutlineOperator",        { fg = get_highlight("Operator").fg    })
    vim.api.nvim_set_hl(0, "SymbolsOutlineTypeParameter",   { fg = get_highlight("Type").fg        })
    vim.api.nvim_set_hl(0, "SymbolsOutlineComponent",       { fg = get_highlight("Structure").fg   })
    vim.api.nvim_set_hl(0, "SymbolsOutlineFragment",        { fg = get_highlight("Structure").fg   })

    symbols_outline.setup({
        fold_all = "<S-h>",
        unfold_all = "<S-l>",
        symbols = {
            File =              { icon = codicons.get('symbol-file'),         hl = "SymbolsOutlineFile"             },
            Module =            { icon = codicons.get('symbol-namespace'),    hl = "SymbolsOutlineModule"           },
            Namespace =         { icon = codicons.get('symbol-namespace'),    hl = "SymbolsOutlineNamespace"        },
            Package =           { icon = codicons.get('package'),             hl = "SymbolsOutlinePackage"          },
            Class =             { icon = codicons.get('symbol-class'),        hl = "SymbolsOutlineClass"            },
            Method =            { icon = codicons.get('symbol-method'),       hl = "SymbolsOutlineMethod"           },
            Property =          { icon = codicons.get('symbol-property'),     hl = "SymbolsOutlineProperty"         },
            Field =             { icon = codicons.get('symbol-field'),        hl = "SymbolsOutlineField"            },
            Constructor =       { icon = codicons.get('symbol-class'),        hl = "SymbolsOutlineConstructor"      },
            Enum =              { icon = codicons.get('symbol-enum'),         hl = "SymbolsOutlineEnum"             },
            Interface =         { icon = codicons.get('symbol-interface'),    hl = "SymbolsOutlineInterface"        },
            Function =          { icon = codicons.get('symbol-method'),       hl = "SymbolsOutlineFunction"         },
            Variable =          { icon = codicons.get('symbol-variable'),     hl = "SymbolsOutlineVariable"         },
            Constant =          { icon = codicons.get('symbol-constant'),     hl = "SymbolsOutlineConstant"         },
            String =            { icon = codicons.get('symbol-string'),       hl = "SymbolsOutlineString"           },
            Number =            { icon = codicons.get('symbol-numeric'),      hl = "SymbolsOutlineNumber"           },
            Boolean =           { icon = codicons.get('symbol-boolean'),      hl = "SymbolsOutlineBoolean"          },
            Array =             { icon = codicons.get('symbol-array'),        hl = "SymbolsOutlineArray"            },
            Object =            { icon = codicons.get('symbol-namespace'),    hl = "SymbolsOutlineObject"           },
            Key =               { icon = codicons.get('symbol-key'),          hl = "SymbolsOutlineKey"              },
            Null =              { icon = codicons.get('circle-slash'),        hl = "SymbolsOutlineNull"             },
            EnumMember =        { icon = codicons.get('symbol-enum-member'),  hl = "SymbolsOutlineEnumMember"       },
            Struct =            { icon = codicons.get('symbol-structure'),    hl = "SymbolsOutlineStruct"           },
            Event =             { icon = codicons.get('symbol-event'),        hl = "SymbolsOutlineEvent"            },
            Operator =          { icon = codicons.get('symbol-operator'),     hl = "SymbolsOutlineOperator"         },
            TypeParameter =     { icon = codicons.get('symbol-parameter'),    hl = "SymbolsOutlineTypeParameter"    },
            Component =         { icon = codicons.get('code'),                hl = "SymbolsOutlineComponent"        },
            Fragment =          { icon = codicons.get('code'),                hl = "SymbolsOutlineFragment"         },
        },
    })
end

M.toggle_symbol_outline = function ()
    local symbols_outline = require("symbols-outline")

    symbols_outline.toggle_outline()
end

M.spec = {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    config = config,
    dependencies = {
        require("plugins.codicons").spec
    },
    keys = { keymap.normal.lazy("<Leader>oo", M.toggle_symbol_outline, { desc = "Toggle symbol outline" }) },
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" }
}

return M
