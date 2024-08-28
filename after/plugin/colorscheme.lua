require('kanagawa').setup({
    compile = true,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = true,
    terminalColors = true,
    theme = "dragon"
})

vim.cmd("colorscheme kanagawa")
