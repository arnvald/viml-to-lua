return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- common
  use 'tpope/vim-fugitive' -- Git commands
  use 'vim-airline/vim-airline' -- powerline
  use 'vim-airline/vim-airline-themes'
  use 'rhysd/vim-grammarous' -- grammar check
  use 'andymass/vim-matchup' -- matching parens and more
  use 'bronson/vim-trailing-whitespace' -- highlight trailing spaces
  use 'rhysd/git-messenger.vim'
  use 'marko-cerovac/material.nvim' -- material theme

  use { 'lewis6991/gitsigns.nvim', -- git added/removed in sidebar + inline blame
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup({
        current_line_blame = false
      })
    end
  }

  -- general dev
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'tami5/lspsaga.nvim'
  use 'onsails/lspkind.nvim' -- icons in autocomplete source
  use 'hrsh7th/nvim-cmp' -- autocomplete engine (see autocomplete.lua)
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for cmp
  use 'hrsh7th/cmp-buffer' -- buffer source for cmp
  use 'hrsh7th/cmp-path' -- path source for cmp
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'scrooloose/nerdcommenter' -- commenting shortcuts

  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      disable = { "ruby" }
    }
  }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
      }
  )

  require'lspsaga'.init_lsp_saga {
    error_sign = '!',
    warn_sign = '^',
    hint_sign = '?',
    infor_sign = '~',
    border_style = "round",
    code_action_prompt = {
      enable = false
    }
  }

  -- search
  use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  use 'tpope/vim-eunuch' -- wrappers UNIX commands
  use 'tpope/vim-surround' -- surround characters shortcuts
  use 'tpope/vim-vinegar' -- file browser
  use 'kyazdani42/nvim-web-devicons' -- icons when searching

  -- testing
  use 'kassio/neoterm' -- terminal wrapper
  use 'janko-m/vim-test' -- testing commands

  -- javascript
  use { 'HerringtonDarkholme/yats.vim', ft = 'typescript' }
  use { 'posva/vim-vue' } -- Vue highlighting
  use 'othree/javascript-libraries-syntax.vim'

  -- python
  use { 'Vimjas/vim-python-pep8-indent', ft = 'python' }

  -- ruby
  use { 'tpope/vim-rails', ft = 'ruby' }
  use { 'ecomba/vim-ruby-refactoring', ft = 'ruby' }
  use { 'tpope/vim-haml', ft = 'ruby' }

  -- elixir
  use { 'elixir-lang/vim-elixir', ft = 'elixir' }
  use { 'mattreduce/vim-mix', ft = 'elixir' }
  use { 'slashmili/alchemist.vim', ft = 'elixir' }
end)
