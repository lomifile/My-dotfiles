return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-moon",
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
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      icons_enabled = true,
      theme = "tokyonight",
      options = {
        component_separator = "|",
        section_separators = {
          left = "█",
          right = "█",
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "█" },
            padding = {
              right = 1,
              left = 1,
            },
          },
        },
        lualine_b = { "diagnostics", "filename", "branch" },
        lualine_c = { "fileformat" },
        lualine_x = {},
        lualine_y = {
          "filetype",
          "progress",
        },
        lualine_z = {
          {
            "location",
            separator = {
              right = "█",
            },
            padding = {
              left = 2,
            },
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
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
}
