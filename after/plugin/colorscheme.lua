require("gruvbox").setup({
    --contrast = "soft",
    contrast = "",
    terminal_colors = false,
    undercurl = false,
    underline = false,
    bold = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
    },
})
vim.cmd("set background=dark")
vim.cmd("colorscheme gruvbox")
