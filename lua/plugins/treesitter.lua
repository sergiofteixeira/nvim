return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "javascript",
      "typescript",
      "lua",
      "python",
      "go",
      "terraform",
      "hcl",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
}
