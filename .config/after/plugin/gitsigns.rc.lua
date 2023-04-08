local status, gitsigns = pcall(require, "gitsigns")
--[[ local keymap = vim.keymap ]]
if (not status) then return end

gitsigns.setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  --[[ keymap({ 'n', 'v' }, 'hu', gitsigns.undo_stage_hunk),
  keymap({ 'n', 'v' }, 'hr', ':Gitsigns reset_hunk<CR>'),
  keymap('n', '<leader>hu', gitsigns.undo_stage_hunk), ]]
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}
