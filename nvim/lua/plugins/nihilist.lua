return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local actions = fzf.actions
      return {
        files = {
          cwd_prompt = false,
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
  },
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  { "EdenEast/nightfox.nvim" },
}
