-- Packer.nvim
-- Bootstrap Packer.nvim if it doesn't exist
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.api.nvim_command "packadd packer.nvim"
end
vim.cmd [[packadd packer.nvim]]
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require("packer").startup(
  {
    function(use)
      -- Let Packer manage itself
      use {"wbthomason/packer.nvim", opt = true}

      -- Make it easier to navigate between tmux and vim panes
      use "christoomey/vim-tmux-navigator"

      -- Trim whitespace on save
      use "ntpeters/vim-better-whitespace"

      -- navigation / grep
      use "junegunn/fzf.vim"
      -- use {
      --   'nvim-telescope/telescope.nvim',
      --   requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
      -- }
      use 'ThePrimeagen/harpoon'

      -- grep
      use "mhinz/vim-grepper"

      -- For statusline
      use {
        "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
        after = "github-nvim-theme",
        config = function ()
          require 'config/lualine'
        end
      }

      -- Git
      -- use "mhinz/vim-signify"
      use {
        "lewis6991/gitsigns.nvim",
        requires = {
          "nvim-lua/plenary.nvim"
        }
      }

      -- git, github
      use "tpope/vim-fugitive"
      use "tpope/vim-rhubarb"

      -- netrw
      use "tpope/vim-vinegar"

      -- vim enhancements (motion, repeatability)
      use "tpope/vim-commentary"
      use "tpope/vim-abolish"
      use "tpope/vim-repeat"
      use "tpope/vim-surround"

      -- Neovim motions on speed!
      use {
        "phaazon/hop.nvim",
        branch = 'v2',
        config = function()
          require("hop").setup {}
        end
      }

      -- For showing the actual color of the hex value
      use "norcalli/nvim-colorizer.lua"

      -- Themes
      use "nanotech/jellybeans.vim"
      use "projekt0n/github-nvim-theme"

      -- Neovim LSP
      use "neovim/nvim-lspconfig"

      -- show signatures of functions as you type
      use {
        "ray-x/lsp_signature.nvim"
      }

      -- for using prettier / eslint
      use "mhartington/formatter.nvim"

      -- Neovim Completion
      use {
        "hrsh7th/nvim-cmp",
        requires = {
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "saadparwaiz1/cmp_luasnip",
          "L3MON4D3/LuaSnip"
          -- "hrsh7th/vim-vsnip",
          -- "hrsh7th/vim-vsnip-integ",
          -- "hrsh7th/cmp-nvim-lua",
          -- "hrsh7th/cmp-vsnip",
        }
      }

      use 'mfussenegger/nvim-jdtls'

      -- use {
      --   "ms-jpq/coq_nvim",
      --   branch = "coq"
      -- }

      -- use {
      --   "ms-jpq/coq.artifacts",
      --   branch = "artifacts"
      -- }

      -- use {
      --   "ms-jpq/coq.thirdparty",
      --   branch = "3p"
      -- }

      -- Treesitter config
      use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
      }

      -- Treesitter for movement / selection
      -- use {
      --   "~/src/nvim-treesitter-textobjects",
      --   as = "nvim-treesitter/nvim-treesitter-textobjects"
      -- }
      use "nvim-treesitter/nvim-treesitter-textobjects"

      use "nvim-treesitter/playground"

      use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
          require("trouble").setup {
          }
        end
      }

    end
  }
)
