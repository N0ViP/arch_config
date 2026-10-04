-- Neovim Configuration - Cyberpunk Style
-- Matches Kitty, Hyprland, Waybar & btop aesthetic with transparency

-- Leader key must be set before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core configuration
require("config.options")
require("config.keymaps")

-- Apply custom Cyberpunk colorscheme
vim.cmd("colorscheme cyberpunk")

-- Autocommand to ensure transparent background is preserved across all buffers & plugins
local function enforce_transparency()
  local transparent_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "FoldColumn",
    "LineNr",
    "LineNrAbove",
    "LineNrBelow",
    "CursorLineNr",
    "EndOfBuffer",
    "VertSplit",
    "WinSeparator",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "NvimTreeNormal",
    "NvimTreeNormalNC",
    "NvimTreeEndOfBuffer",
    "NvimTreeWinSeparator",
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptNormal",
    "TelescopePromptBorder",
    "TelescopeResultsNormal",
    "TelescopeResultsBorder",
    "TelescopePreviewNormal",
    "TelescopePreviewBorder",
    "WhichKeyFloat",
    "WhichKeyBorder",
    "LazyNormal",
    "MasonNormal",
  }

  for _, name in ipairs(transparent_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    hl.bg = nil
    hl.ctermbg = nil
    vim.api.nvim_set_hl(0, name, hl)
  end
end

local cyber_augroup = vim.api.nvim_create_augroup("CyberpunkTransparency", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "UIEnter" }, {
  group = cyber_augroup,
  callback = enforce_transparency,
})

-- Initialize lazy.nvim and plugins
require("config.lazy")
