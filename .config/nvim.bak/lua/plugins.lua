local execute = vim.api.nvim_command
local packer = nil
-- check if packer is installed (~/.local/share/nvim/site/pack)
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = install_path .. "/plugin/packer_compiled.lua"
local is_installed = vim.fn.empty(vim.fn.glob(install_path)) == 0

local function init()
  if not is_installed then
      if vim.fn.input("Install packer.nvim? (y for yes) ") == "y" then
          execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
          execute("packadd packer.nvim")
          print("Installed packer.nvim.")
          is_installed = 1
      end
  end

  if not is_installed then return end
  if packer == nil then
      packer = require('packer')
      packer.init({
          -- we don't want the compilation file in '~/.config/nvim'
          disable_commands = true,
          compile_path = compile_path
      })
  end

  local use = packer.use
  packer.reset()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Needed to load first
  use {'lewis6991/impatient.nvim'}
  use {'nvim-lua/plenary.nvim'}
  use {'kyazdani42/nvim-web-devicons'}

  -- Themes
  use {'bluz71/vim-nightfly-guicolors'}
  use {'folke/tokyonight.nvim'}

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', config = "require('plugins.treesitter')"}
  use {'nvim-treesitter/nvim-treesitter-textobjects', after = {'nvim-treesitter'}}
  use {'RRethy/nvim-treesitter-textsubjects', after = {'nvim-treesitter'}}
  use {'m-demare/hlargs.nvim', config = function() require('hlargs').setup() end}

  -- Telescope
  use {'nvim-telescope/telescope.nvim',
      config = "require('plugins.telescope')",
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim'}
      }
    }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'cljoly/telescope-repo.nvim'}

  -- LSP Base
  use {'neovim/nvim-lspconfig'}

  -- LSP Cmp
  use {'hrsh7th/nvim-cmp', event = 'InsertEnter', config = "require('plugins.cmp')"}
  use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp', after = 'cmp-nvim-lua'}
  use {'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-path', after = 'cmp-buffer'}
  use {'hrsh7th/cmp-cmdline', after = 'cmp-path'}
  use {'hrsh7th/cmp-calc', after = 'cmp-cmdline'}
  use {'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp', after = 'cmp-calc'}
  use {'David-Kunz/cmp-npm', after = 'cmp-tabnine', requires = 'nvim-lua/plenary.nvim', config = "require('plugins.cmp-npm')"}
  use {'saadparwaiz1/cmp_luasnip', after = 'cmp-npm'}

  -- LSP Addons
  use {'williamboman/nvim-lsp-installer', event = 'BufEnter', after = 'cmp-nvim-lsp'}
  use {'stevearc/dressing.nvim', requires = 'MunifTanjim/nui.nvim', config = "require('plugins.dressing')"}
  use {'onsails/lspkind-nvim'}
  use {'folke/lsp-trouble.nvim', config = "require('plugins.trouble')"}
  use {'nvim-lua/popup.nvim'}
  use {'SmiteshP/nvim-gps', config = "require('plugins.gps')", after = 'nvim-treesitter'}
  use {'jose-elias-alvarez/nvim-lsp-ts-utils', after = {'nvim-treesitter'}}

  -- General
  use {'numToStr/Comment.nvim', config = "require('plugins.comment')"}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-surround'}
  use {'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter'}
  use {'folke/todo-comments.nvim', config = "require('plugins.todo-comments')"}
  use {'ggandor/lightspeed.nvim'}
  use {'folke/which-key.nvim', config = "require('plugins.which-key')", event = "BufWinEnter"}
  use {'ecosse3/galaxyline.nvim', after = 'nvim-gps', config = "require('plugins.galaxyline')"}
  use {'antoinemadec/FixCursorHold.nvim'} -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use {'vuki656/package-info.nvim'}
  use {'nvim-pack/nvim-spectre'}

  -- Snippets & Language & Syntax
  use {'windwp/nvim-autopairs', after = {'nvim-treesitter', 'nvim-cmp'}, config = "require('plugins.autopairs')"}
  use {'p00f/nvim-ts-rainbow', after = {'nvim-treesitter'}}
  use {'lukas-reineke/indent-blankline.nvim', config = "require('plugins.indent')"}
  use {'norcalli/nvim-colorizer.lua', config = "require('plugins.colorizer')"}
  use {'L3MON4D3/LuaSnip', requires = {'rafamadriz/friendly-snippets'}, after = 'cmp_luasnip'}

  -- Nvim Tree / Rooter
  use {'kyazdani42/nvim-tree.lua', config = "require('plugins.tree')"}

  -- Debug
  -- TODO: Configure dap
  -- use {'rcarriga/nvim-dap-ui', requires = {"mfussenegger/nvim-dap"}}
  -- use {'mfussenegger/nvim-dap', config = "require('plugins.dap')"}

  -- Git
  use {'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('plugins.gitsigns')",
    event = "BufRead"
  }
  use {'sindrets/diffview.nvim'}
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins