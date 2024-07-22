local decay = require("decay")

local opt = vim.opt
local cmd = vim.cmd

opt.background = "dark"

decay.setup({
    style = "default",

    -- enables italics in code keywords & comments.
    italics = {
        code = true,
        comments = true,
    },
})

cmd.colorscheme "decay"
