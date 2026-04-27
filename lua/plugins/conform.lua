return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      terraform = { "tofu_fmt" },
      hcl = { "tofu_fmt" },
      tf = { "tofu_fmt" },
      tfvars = { "tofu_fmt" },
      lua = { "stylua" },
      go = { "goimports", "gofumpt" },
      nix = { "nixfmt" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
