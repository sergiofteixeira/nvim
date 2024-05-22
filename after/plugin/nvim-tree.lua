require 'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    --open_on_setup       = false,
    --ignore_ft_on_setup  = {},
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    diagnostics         = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open         = {
        cmd  = nil,
        args = {}
    },
    filters             = {
        dotfiles = false,
        custom = { "node_modules" }
    },
    git                 = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view                = {
        width = 30,
        --height = 30,
        side = 'left',
        number = false,
        relativenumber = false,
        signcolumn = "yes"
    },
    trash               = {
        cmd = "trash",
        require_confirm = true
    },
    actions             = {
        change_dir = {
            global = false,
        },
        open_file = {
            quit_on_open = false,
        }
    }
}
