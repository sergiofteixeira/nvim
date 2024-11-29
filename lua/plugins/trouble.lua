return {
  'folke/trouble.nvim',
  config = function()
    require("trouble").setup {
      mode = "workspace_diagnostics",
      position = "bottom",
      height = 15,
      padding = false,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = { "o" },
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM" },
        open_folds = { "zR" },
        toggle_fold = { "za" },
      },
      auto_jump = {},
      use_diagnostic_signs = true,
    }
  end
}
