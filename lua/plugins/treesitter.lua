return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  main = "nvim-treesitter",
  config = function()
    local parsers = {
      "javascript",
      "typescript",
      "lua",
      "python",
      "go",
      "terraform",
      "hcl",
    }

    local installed = require("nvim-treesitter.config").get_installed()
    local missing = vim.iter(parsers)
      :filter(function(parser)
        return not vim.tbl_contains(installed, parser)
      end)
      :totable()

    if #missing > 0 then
      require("nvim-treesitter").install(missing)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
