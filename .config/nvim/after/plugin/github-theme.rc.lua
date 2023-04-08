--[[ local status, theme = pcall(require, 'github-theme')
if (not status) then return end

theme.setup({
  theme_style = "dark",
  comment_style = "italic",
  keyword_style = "italic",
  function_style = "italic",
  variable_style = "italic",
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = { hint = "orange", error = "#ff0000" },
  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
      DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
      -- this will remove the highlight groups
      TSField = {},
    }
  end
}) ]]
local status, theme = pcall(require, 'material')
if (not status) then return end

theme.setup({
  contrast = {
    terminal = true,             -- Enable contrast for the built-in terminal
    sidebars = true,             -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
    floating_windows = true,     -- Enable contrast for floating windows
    cursor_line = true,          -- Enable darker background for the cursor line
    non_current_windows = false, -- Enable darker background for non-current windows
    filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
  },
  styles = {
    -- Give comments style such as bold, italic, underline etc.
    comments = { italic = true },
    strings = { bold = true },
    keywords = { --[[ underline = true ]] italic = true },
    functions = { --[[ bold = true, undercurl = true ]] italic = true },
    variables = { italic = true },
    operators = {},
    types = { italic = true },
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    "gitsigns",
    "lspsaga",
    "nvim-web-devicons",
    "telescope",
  },
  disable = {
    colored_cursor = true, -- Disable the colored cursor
    borders = false,       -- Disable borders between verticaly split windows
    background = false,    -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
    term_colors = false,   -- Prevent the theme from setting terminal colors
    eob_lines = false      -- Hide the end-of-buffer lines
  },
  high_visibility = {
    lighter = false,         -- Enable higher contrast text for lighter style
    darker = false           -- Enable higher contrast text for darker style
  },
  lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
  async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)
  custom_colors = nil,       -- If you want to everride the default colors, set this to a function
  custom_highlights = {},
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
