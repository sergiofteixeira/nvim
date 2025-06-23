return {
  "thigcampos/cupertino.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cupertino").setup({
      italics = {
        comments = false,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
        bufferline = false,
      },
    })
    vim.cmd.colorscheme "cupertino"
  end,
}
