return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local bg0 = "#1b1b1b"
    require("gruvbox").setup({
      contrast = "hard",
      overrides = {
        GruvboxBg0 = { fg = bg0 },
        SignColumn = { bg = bg0 },
        GruvboxRedSign = { bg = bg0 },
        GruvboxYellowSign = { bg = bg0 },
        GruvboxGreenSign = { bg = bg0 },
        GruvboxAquaSign = { bg = bg0 },
        GruvboxOrangeSign = { bg = bg0 },
        GruvboxPurpleSign = { bg = bg0 },
        GruvboxBlueSign = { bg = bg0 },
        Normal = { bg = bg0 },
      },
      undercurl = true,
      underline = true,
      bold = false,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = false,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      palette_overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    --vim.cmd([[colorscheme gruvbox]])
  end
}
