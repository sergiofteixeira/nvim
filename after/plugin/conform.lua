require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
        nix = { "nixfmt" },
        javascript = { { "prettierd", "prettier" } },
        python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
                return { "ruff_format" }
            else
                return { "isort", "black" }
            end
        end,
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
