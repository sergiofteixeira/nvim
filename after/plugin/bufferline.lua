require("bufferline").setup({
    options = {
        indicator = { style = "icon", icon = "▎" },
        modified_icon = '●',
        show_buffer_icons = true,
        offsets = { {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center"
        } },
        diagnostics = "nvim_lsp",
    },
})
