-- Neovim options tailored for Cyberpunk Rice
local opt = vim.opt

-- Appearance & Transparency
opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true
opt.signcolumn = "yes"
opt.fillchars = {
  eob = " ",       -- Suppress '~' on empty lines for clean transparent aesthetic
  vert = "│",
  horiz = "─",
  fold = " ",
  diff = "╱",
}

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4

-- Tabs & Indentation (tabstop=4, automatic indentation on new line)
opt.tabstop = 4         -- Number of spaces that a <Tab> in the file counts for
opt.softtabstop = 4     -- Number of spaces that a <Tab> counts for while editing
opt.shiftwidth = 4      -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true    -- Use spaces instead of tab characters
opt.autoindent = true   -- Automatically indent new lines to match previous line
opt.smartindent = true  -- Smart auto-indenting when starting a new line
opt.cindent = false     -- Disable rigid C-indenting so custom/single-statement loops indent freely
opt.smarttab = true     -- Insert 'shiftwidth' spaces when pressing <Tab> at beginning of line
opt.copyindent = true   -- Copy the structure of existing lines' indent
opt.preserveindent = true -- Preserve existing indent structure

-- Smart keywords that automatically indent the next line
opt.cinwords = "if,else,while,do,for,switch,def,class,elif,except,finally,try,with,function,then,case,default,struct,enum,type,interface"

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor & Mouse
opt.mouse = "a"
opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor"

-- System Integration
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance & Ergonomics
opt.updatetime = 200
opt.timeoutlen = 300
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Window transparency blends
opt.pumblend = 0
opt.winblend = 0

-- Ensure tabstop=4 and autoindent apply to all files and filetypes without being overridden
local indent_augroup = vim.api.nvim_create_augroup("CyberpunkTabIndent", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufNewFile" }, {
  group = indent_augroup,
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = true
    vim.opt_local.cindent = false
    vim.opt_local.indentexpr = ""
  end,
})
