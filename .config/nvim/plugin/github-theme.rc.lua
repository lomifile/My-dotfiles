local status, n = pcall(require, 'github-theme')
if (not status) then return end

n.setup({
  theme_style = "dark_default",
  comment_style = "italic",
  keyword_style = "italic",
  function_style = "italic",
  variable_style = "italic",
  dark_sidebar = false,
})
