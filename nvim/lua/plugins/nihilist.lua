return {

  -- Colorcheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        kreesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },

    -- Set colorscheme

    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "tokyonight-night",
      },
    },

    -- Telescope

    {
      "telescope.nvim",
      dependencies = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
        "nvim-telescope/telescope-file-browser.nvim",
      },
      keys = {
        {
          "<leader>fP",
          function()
            require("telescope.builtin").find_files({
              cwd = require("lazy.core.config").options.root,
            })
          end,
          desc = "Find Plugin File",
        },
        {
          ";f",
          function()
            local builtin = require("telescope.builtin")
            builtin.find_files({
              no_ignore = false,
              hidden = true,
            })
          end,
          desc = "Lists files in your current working directory, respects .gitignore",
        },
        {
          ";r",
          function()
            local builtin = require("telescope.builtin")
            builtin.live_grep()
          end,
          desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
        },
        {
          "\\\\",
          function()
            local builtin = require("telescope.builtin")
            builtin.buffers()
          end,
          desc = "Lists open buffers",
        },
        {
          ";t",
          function()
            local builtin = require("telescope.builtin")
            builtin.help_tags()
          end,
          desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
        },
        {
          ";;",
          function()
            local builtin = require("telescope.builtin")
            builtin.resume()
          end,
          desc = "Resume the previous telescope picker",
        },
        {
          ";e",
          function()
            local builtin = require("telescope.builtin")
            builtin.diagnostics()
          end,
          desc = "Lists Diagnostics for all open buffers or a specific buffer",
        },
        {
          ";s",
          function()
            local builtin = require("telescope.builtin")
            builtin.treesitter()
          end,
          desc = "Lists Function names, variables, from Treesitter",
        },
        {
          "sf",
          function()
            local telescope = require("telescope")

            local function telescope_buffer_dir()
              return vim.fn.expand("%:p:h")
            end

            telescope.extensions.file_browser.file_browser({
              path = "%:p:h",
              cwd = telescope_buffer_dir(),
              respect_gitignore = false,
              hidden = true,
              grouped = true,
              previewer = false,
              initial_mode = "normal",
              layout_config = { height = 40 },
            })
          end,
          desc = "Open File Browser with the path of the current buffer",
        },
      },
      config = function(_, opts)
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local fb_actions = require("telescope").extensions.file_browser.actions

        opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
          wrap_results = true,
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            n = {},
          },
        })
        opts.pickers = {
          diagnostics = {
            theme = "ivy",
            initial_mode = "normal",
            layout_config = {
              preview_cutoff = 9999,
            },
          },
        }
        opts.extensions = {
          file_browser = {
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              -- your custom insert mode mappings
              ["n"] = {
                -- your custom normal mode mappings
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
                ["<C-u>"] = function(prompt_bufnr)
                  for i = 1, 10 do
                    actions.move_selection_previous(prompt_bufnr)
                  end
                end,
                ["<C-d>"] = function(prompt_bufnr)
                  for i = 1, 10 do
                    actions.move_selection_next(prompt_bufnr)
                  end
                end,
                ["<PageUp>"] = actions.preview_scrolling_up,
                ["<PageDown>"] = actions.preview_scrolling_down,
              },
            },
          },
        }
        telescope.setup(opts)
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
      end,
    },
  },

  -- neo-tree config to include all files

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
      options = {
        component_separator = "|",
        section_separators = {
          left = "",
          right = "",
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "" },
            padding = {
              right = 1,
              left = 1,
            },
          },
        },
        lualine_b = { "filename", "branch" },
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
              right = "",
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
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- lua     -- opts = {     --   auto_brackets = { "python" }     -- }     --
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
          }),
          documentation = cmp.config.window.bordered(),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
          ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set select to false to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          fields = {
            "kind",
            "abbr",
            "menu",
          },
          format = function(entry, item)
            local icons = LazyVim.config.icons.kinds
            if icons[item.kind] then
              local strings = vim.split(item.kind, "%s", { trimempty = true })
              item.kind = " " .. icons[item.kind]
              item.menu = "    (" .. (strings[1] or "") .. ")"
            end

            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    main = "lazyvim.util.cmp",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable("npx") then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd([[Lazy load markdown-preview.nvim]])
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable("npx") then
        vim.g.mkdp_filetypes = { "markdown" }
      end
    end,
  },
}
