require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = false,
    enable_diagnostics = false,
    window = {
        position = "float",
        width = 35,
    },
    filesystem = {
        filtered_items = {
            always_show = {
                ".github",
            },
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
    },
})
