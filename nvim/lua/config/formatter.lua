-- note, requires prettier to be installed globally
-- npm install -g prettier
require "formatter".setup {
  filetype = {
    typescriptreact = {
      function()
        return {
          exe = "npx prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')
        }
      end
    },
    typescript = {
      function()
        return {
          exe = "npx prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')
        }
      end
    },
    javascript = {
      function()
        return {
          exe = "npx prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')
        }
      end
    },
    javascriptreact = {
      function()
        return {
          exe = "npx prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')
        }
      end
    },
    json = {
      function()
        return {
          exe = "npx prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    },
    lua = {
      -- luafmt
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    },
    rust = {
      -- rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    markdown = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
          stdin = true
        }
      end
    }
  }
}

vim.api.nvim_set_keymap("n", "<leader>`", ":Format<CR>", {noremap = true})
