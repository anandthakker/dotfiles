
local gh_themes = require('github-theme')

local THEMES = { 'dark_default', 'light_default', 'dark_colorblind', 'light_colorblind', 'dimmed', 'light', 'dark' }
local DARK_THEME = 'dark_default'
local LIGHT_THEME = 'light_default'
local theme = DARK_THEME

local function setup(t)
  print("Current theme "..theme)
  theme = t;
  gh_themes.setup({
    theme_style = t,
    sidebars = { 'qf', 'terminal', 'packer' },
    transparent = false
  })
end

setup(theme)

vim.api.nvim_create_user_command('ToggleTheme', function ()
  if theme == DARK_THEME then theme = LIGHT_THEME else theme = DARK_THEME end
  setup(theme)
end, {})

vim.api.nvim_create_user_command('SetTheme', function (opts)
  setup(opts.args)
end, {
  nargs = 1,
  complete = function()
    return THEMES
  end
})

