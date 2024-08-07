require("neo-tree").setup({
    source_selector = {
        winbar = true,
        statusline = false,
    },
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_modified_markers = true,
    enable_diagnostics = true,
    sort_case_insensitive = true,
    default_component_configs = {
        indent = {
            with_markers = true,
            with_expanders = true,
        },
        modified = {
            symbol = " ",
            highlight = "NeoTreeModified",
        },
        git_status = {
            symbols = {
                added = "",
                deleted = "",
                modified = "",
                renamed = "",
                untracked = "",
                ignored = "",
                unstaged = "",
                staged = "",
                conflict = "",
            },
        },
    },
    window = {
        position = "float",
        width = 35,
    },
    filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
                "node_modules",
            },
            never_show = {
                ".DS_Store",
                "thumbs.db",
            },
        },
    },
    event_handlers = {
        {
            event = "neo_tree_window_after_open",
            handler = function(args)
                if args.position == "left" or args.position == "right" then
                    vim.cmd("wincmd =")
                end
            end,
        },
        {
            event = "neo_tree_window_after_close",
            handler = function(args)
                if args.position == "left" or args.position == "right" then
                    vim.cmd("wincmd =")
                end
            end,
        },
    },
})
