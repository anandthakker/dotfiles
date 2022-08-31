
local gh_themes = require('github-theme')

local THEMES = { 'dark_default', 'light_default', 'dark_colorblind', 'light_colorblind', 'dimmed', 'light', 'dark' }
local DARK_THEME = 'dark_default'
local LIGHT_THEME = 'light_colorblind'
local theme = DARK_THEME

gh_themes.setup({
  theme_style = theme,
  sidebars = { 'qf', 'terminal', 'packer' }
})

local function set_theme(t)
  gh_themes.setup({ theme_style = t })
end

vim.api.nvim_create_user_command('ToggleTheme', function ()
  if theme == DARK_THEME then theme = LIGHT_THEME else theme = LIGHT_THEME end
  set_theme(theme)
end, {})

vim.api.nvim_create_user_command('SetTheme', function (opts)
  set_theme(opts.args)
end, {
  nargs = 1,
  complete = function()
    return THEMES
  end
})

