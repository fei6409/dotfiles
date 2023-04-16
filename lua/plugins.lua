return {
  -- colorscheme
  {
    'sainnhe/gruvbox-material',
    -- make sure the colorscheme is loaded first since start plugins can
    -- possibly change existing highlight groups
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'mix'
      vim.g.gruvbox_material_better_performance = 1
      -- darker background color
      vim.g.gruvbox_material_colors_override = { bg0={ '#080808', '232' } }
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy=true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'codedark',
          always_divide_middle = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding' },
          lualine_y = { 'filetype' },
          lualine_z = { 'progress', 'location' },
        },
        winbar = {
          lualine_a = { {
            'buffers',
            icons_enabled = false,
            symbols = { modified='*', alternate_file='' },
          }, },
        },
      }
    end,
  },
  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build='make' },
    },
    keys = {
      { '<C-s>', ':Telescope grep_string<CR>', desc='search for string under cursor' },
      { '<C-g>', ':Telescope live_grep<CR>', desc='live grep with ripgrep' },
      { '<C-f>', ':lua require("telescope-config").project_files()<CR>',
          desc='Fuzzy search files - use git_files if in git repo, or fall back to find_files' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = { height=0.95, width=0.9 },
          mappings = {
            -- Close Telescope directly (instead back to normal mode)
            i = { ['<esc>']='close' },
          },
        },
      }
      require('telescope').load_extension('fzf')
    end,
  },
  -- nvim tree-sitter interface and highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
      require('nvim-treesitter.configs').setup {
        -- the five listed parsers should always be installed
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
        auto_install = true,
        highlight = { enable=true },
      }
    end,
  },
  -- commenter
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        toggler = { line='\\', block='<leader>\\' },
        opleader = { line='\\', block='<leader>\\' },
        mappings = { extra=false },
      }
    end,
  },
  { 'neovim/nvim-lspconfig' },
}
