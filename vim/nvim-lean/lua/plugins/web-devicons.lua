return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup {
      override = {
        Makefile = {
          icon = "",
          color = "#428850",
          name = "Makefile",
        },
        sql = {
          icon = "",
          color = "#cbcb41",
          name = "sql",
        },
        cs = {
          icon = "󰌛",
          color = "#019833",
          name = "Cs",
        },
        sln = {
          icon = "",
          color = "#e37933",
          name = "Sln",
        },
        csproj = {
          icon = "",
          color = "#7160e8",
          name = "Csproj",
        },
        njk = {
          icon = "",
          color = "#e44d26",
          cterm_color = "196",
          name = "Nunchucks",
        },
        liquid = {
          icon = "",
          color = "#e44d26",
          cterm_color = "196",
          name = "Liquid",
        }
      }
    }
  end
}
