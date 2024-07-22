require('lualine').setup {
    colorscheme = "decay",
    options = {
        theme = 'auto',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { {
            'filename',
            file_status = true,
            path = 1
        } },
        lualine_d = { 'progress' },
        lualine_e = {
            { 'diagnostics',
                sources = { 'nvim_diagnostic', 'nvim_lsp' },
                sections = { 'error', 'warn', 'info', 'hint' },
                diagnostics_color = {
                    error = 'DiagnosticError',
                    warn  = 'DiagnosticWarn',
                    info  = 'DiagnosticInfo',
                    hint  = 'DiagnosticHint',
                },
                symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                colored = true,
                update_in_insert = true,
                always_visible = false,
            }
        }
    }
}
