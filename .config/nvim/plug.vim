" Load vundle
set nocompatible
filetype off
set rtp+=~/dev/others/base16/templates/vim/

call plug#begin()

" Load plugins
" VIM enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak'
Plug 'jghauser/mkdir.nvim'
Plug 'townk/vim-autoclose' 
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'folke/which-key.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'kylechui/nvim-surround'
Plug 'ThePrimeagen/harpoon'
Plug 'hadronized/hop.nvim'

" GUI enhancements
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'RRethy/nvim-base16'
Plug 'nvim-lualine/lualine.nvim'
Plug 'stevearc/dressing.nvim'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'ruby-formatter/rufo-vim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'simrat39/rust-tools.nvim'
Plug 'scalameta/nvim-metals', {'branch': 'main'}
Plug 'elixir-tools/elixir-tools.nvim', {'tag': 'stable'}
Plug 'Olical/conjure'
Plug 'LhKipp/nvim-nu', {'do': ':TSInstall nu'}


" Formatting
Plug 'nvimtools/none-ls.nvim', {'branch': 'main'}

" Snippets
Plug 'L3MON4D3/LuaSnip', { 'tag': 'v1.2.1', 'do': 'make install_jsregexp' }
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" Code outline
Plug 'stevearc/aerial.nvim'

" Syntactic language support
Plug 'cespare/vim-toml', {'branch': 'main'}
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" File explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" Git
Plug 'tpope/vim-fugitive'
Plug 'f-person/git-blame.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Rich Presence
Plug 'andweeb/presence.nvim'

call plug#end()
