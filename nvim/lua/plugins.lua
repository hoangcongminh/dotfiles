vim.cmd [[packadd packer.nvim]]

vim.api.nvim_set_keymap('n','<leader>ps',"<cmd>PackerSync<cr>",{ noremap=true, silent=true })
vim.api.nvim_set_keymap('n','<leader>pc',"<cmd>PackerClean<cr>",{ noremap=true, silent=true })

return require('packer').startup(function()

use 'wbthomason/packer.nvim'

-- color Theme
use {'Mofiqul/vscode.nvim', branch = 'main'}

-- treesitter
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'
use 'p00f/nvim-ts-rainbow'

-- telescope
use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
}
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

-- floatTerm
use 'akinsho/toggleterm.nvim'

-- File and folder management
use 'kyazdani42/nvim-tree.lua'

-- git
use 'tpope/vim-fugitive'
use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
}

-- lualine & tabline
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
use {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'}
}

-- icons
use 'ryanoasis/vim-devicons'
use 'kyazdani42/nvim-web-devicons'

-- comment
use 'tpope/vim-commentary'

-- lsp
use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
}
use 'j-hui/fidget.nvim'

-- completion
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/nvim-cmp'

use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/vim-vsnip'
use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

-- snippets
use 'rafamadriz/friendly-snippets'

-- flutter
use 'Nash0x7E2/awesome-flutter-snippets'
use {"akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim",}
use 'dart-lang/dart-vim-plugin'

-- copilot
use 'github/copilot.vim'

-- other
use 'tpope/vim-sleuth'
use 'tpope/vim-sensible'
use 'tpope/vim-surround'
use {'norcalli/nvim-colorizer.lua', config = function() require'colorizer'.setup() end}
use {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup({disable_filetype = { "TelescopePrompt" , "vim" },}) end}
use {'mg979/vim-visual-multi', branch = 'master'}

end)
