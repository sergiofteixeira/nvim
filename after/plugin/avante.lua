require('img-clip').setup({
    event = "VeryLazy",
    opts = {
        default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
                insert_mode = true,
            },
        },
    },
})
require('copilot').setup({
})
require('render-markdown').setup({
    opts = {
        file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
})

require('avante').setup({
})

