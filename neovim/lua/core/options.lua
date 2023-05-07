-- [[ Vim Settings ]]
-- vim.o: general settings
-- vim.wo: window-scoped options
-- vim.bo: buffer-scoped options
-- vim.g: global variables
-- vim.opt: global/window/buffer settings, vim.opt acts like :set

local opt = vim.opt
local g = vim.g

-- Set space as <leader> key
g.mapleader = ' '
g.maplocalleader = ' '

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }

-- Floating window popup menu for completion on command line
opt.pumblend = 10  -- popup blend
opt.pumheight = 10 -- popup height
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

opt.showmode = false                      -- use statusline instead
opt.showcmd = true
opt.cmdheight = 1                         -- height of the command bar
opt.number = true                         -- line number
opt.relativenumber = true                 -- relative line number
opt.hlsearch = true                       -- highlight on search (I mapped <esc> to :noh)
opt.incsearch = true                      -- make search act like search in modern browsers
opt.ignorecase = true                     -- ignore case when searching...
opt.smartcase = true                      -- ... unless there is a capital letter in the query
opt.showmatch = true                      -- show matching brackets
opt.mouse = 'a'                           -- enable mouse mode
opt.clipboard = 'unnamedplus'             -- sync with system clippboard
opt.hidden = true                         -- have buffers stay around
opt.updatetime = 1000                     -- faster update (default: 4000)
opt.scrolloff = 10                        -- always 10 lines below my cursor
opt.signcolumn = 'yes'                    -- sign column by default
opt.completeopt = 'menu,menuone,noselect' -- better completion
opt.termguicolors = true                  -- terminal gui colors
opt.timeout = true
opt.timeoutlen = 300                      -- time to wait for a mapped key sequence
opt.autowrite = true                      -- enable auto write
opt.confirm = true                        -- confirm before exit if modified
opt.formatoptions = "jcroqlnt"            -- tcqj
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
opt.splitbelow = true                     -- split below instead of above
opt.splitright = true                     -- split right instead of left
opt.spelllang = { "en" }
opt.belloff = "all"                       -- turn the bell off
-- opt.colorcolumn = "80"               -- color column

-- Cursorline highlighting control
opt.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- Tabs, indent
opt.autoindent = true
opt.cindent = true
opt.wrap = true -- line wraps

opt.tabstop = 4
opt.shiftround = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
-- opt.showbreak = string.rep(" ", 3) -- long lines wrap smartly
opt.showbreak = "↳ "
opt.linebreak = true
opt.smartindent = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

-- Swap, backup, undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
-- opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Fix markdown indentation settings
g.markdown_recommended_style = 0
