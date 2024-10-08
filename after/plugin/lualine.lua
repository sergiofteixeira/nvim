local navic = require("nvim-navic")
local lint_progress = function()
    local linters = require("lint").get_running()
    if #linters == 0 then
        return "󰦕"
    end
    return "󱉶 " .. table.concat(linters, ", ")
end
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = "rose-pine",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
            {
                function()
                    return navic.get_location()
                end,
                cond = function()
                    return navic.is_available()
                end
            },
        },
        lualine_x = {},
        lualine_y = { lint_progress },
        lualine_z = { "fileformat", "filetype" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
}
