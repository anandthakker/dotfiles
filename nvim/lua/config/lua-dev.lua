
local lspconfig = require("lspconfig")
local luadev = require("lua-dev").setup({
  cmd= {}
})
lspconfig.lua_ls.setup(luadev)
