require('dashboard').setup({
    config = {
        week_header = {
            enable = true,
        },
        packages = { enable = false, },
        footer = {},
        shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'PackerSync', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
        },
    },
})
