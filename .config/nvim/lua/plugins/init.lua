require('packer').startup(function(use)
    use "wbthomason/packer.nvim"

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    -- Basic =========================================
    use "jiangmiao/auto-pairs"
    use "tpope/vim-commentary"
    use "windwp/nvim-ts-autotag"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    use 'dracula/vim'
    -- ===============================================

    -- LSP & Servers & Autocompletion ================
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/typescript.nvim'

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        config = config('mason')
    }

    use {
        "dcampos/nvim-snippy",
        config = config("snippy")
    }

    use({
        "hrsh7th/nvim-cmp", -- completion
        requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "dcampos/cmp-snippy",
                    "andersevenrud/cmp-tmux"},
        config = config("cmp")
    })
    -- ===============================================

    -- FZF & File Explorer
    use {
        "ibhagwan/fzf-lua",
        config = config('fzf')
    }

    use {
        "luukvbaal/nnn.nvim",
        config = config('nnn')
    }
    -- ===============================================

    -- Undo tree
    use {
        "simnalamburt/vim-mundo",
        config = config("mundo")
    }

    -- Treesitter ====================================
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter")
    })
    -- ===============================================
	
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = config('lualine')
	}
    -- ===============================================

	-- Git ===========================================
	use 'kdheepak/lazygit.nvim'
    -- ===============================================
end)
