if not pcall(require, "colorbuddy") then
  return
end

rawset(require("colorbuddy").styles, "italic", require("colorbuddy").styles.none)

require("colorbuddy").colorscheme "gruvbuddy"
require("colorizer").setup()

vim.opt.termguicolors = true

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("@variable", c.superwhite, nil)

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

Group.new("TSPunctBracket", c.orange:light():light())

Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

Group.new("pythonTSType", c.red)
Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)

Group.new("typescriptTSConstructor", g.pythonTSType)
Group.new("typescriptTSProperty", c.blue)

Group.new("TSTitle", c.blue)

-- the text with characters or something like that...
Group.new("InjectedLanguage", nil, g.Normal.bg:dark())

Group.new("LspParameter", nil, nil, s.italic)
Group.new("LspDeprecated", nil, nil, s.strikethrough)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

-- Group.new("VirtNonText", c.yellow:light():light(), nil, s.italic)
Group.new("VirtNonText", c.gray3:dark(), nil, s.italic)

Group.new("TreesitterContext", nil, g.Normal.bg:light())
Group.new("TreesitterContextLineNumber", c.blue)
-- hi TreesitterContextBottom gui=underline guisp=Grey
-- Group.new("TreesitterContextBottom", nil, nil, s.underline)

Group.new("@property", c.blue)
Group.new("@punctuation.bracket.rapper", c.gray3, nil, s.none)
Group.new("@rapper_argument", c.red, nil, s.italic)
Group.new("@rapper_return", c.orange:light(), nil, s.italic)

-- Group.new("@function.call.lua"
vim.cmd [[highlight link @function.call.lua LuaFunctionCall]]
vim.cmd [[highlight Normal guibg=none]]
vim.cmd [[highlight LineNr guibg=none]]
vim.cmd [[highlight SignColumn guibg=none]]
vim.cmd([[highlight NvimTreeWinSeparator guibg=#1c1e24 guifg=#1c1e24]])
vim.cmd([[highlight WinSeparator guibg=none]])
