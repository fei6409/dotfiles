return {
  -- colorscheme
  {
    'rebelot/kanagawa.nvim',
    -- make sure the colorscheme is loaded first since start plugins can
    -- possibly change existing highlight groups
    priority = 1000,
    init = function()
      require('kanagawa').setup {
        colors = {
          theme = {
            wave = {
              ui = { bg='#0d0c0c' },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          -- magic overrides!
          return {
            -- borderless Telescope
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
      }
      vim.cmd.colorscheme('kanagawa')
    end,
  },
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'material',
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
      { '<C-d>', ':Telescope live_grep<CR>', desc='live grep with ripgrep' },
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
  -- coc.nvim
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      vim.g.coc_global_extensions = {
        'coc-clangd',
        'coc-json',
        'coc-lua',
        'coc-pyright',
        'coc-sh',
        'coc-yaml',
      }

      -- Some servers have issues with backup files, see #649
      vim.opt.backup = false
      vim.opt.writebackup = false
      -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
      -- delays and poor user experience
      vim.opt.updatetime = 500
      -- Always show the signcolumn, otherwise it would shift the text each time
      -- diagnostics appeared/became resolved
      vim.opt.signcolumn = 'yes'

      local keyset = vim.keymap.set
      -- Use Tab for trigger completion with characters ahead and navigate
      -- NOTE: There's always a completion item selected by default, you may
      -- want to enable no select by setting `"suggest.noselect": true` in your
      -- configuration file
      -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped
      -- by other plugins before putting this into your config
      local opts = {silent=true, noremap=true, expr=true, replace_keycodes=false}
      keyset('i', '<TAB>',   [[coc#pum#visible() ? coc#pum#next(1) : '<TAB>']], opts)
      keyset('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : '' ]], opts)

      -- GoTo code navigation
      keyset('n', 'gd', '<Plug>(coc-definition)')
      keyset('n', 'gy', '<Plug>(coc-type-definition')
      keyset('n', 'gi', '<Plug>(coc-implementation)')
      keyset('n', 'gr', '<Plug>(coc-references)')

      opts = {silent = true, nowait = true}
      -- Remap keys for apply code actions at the cursor position.
      keyset('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)', opts)
      -- Remap keys for apply code actions affect whole buffer.
      keyset('n', '<leader>as', '<Plug>(coc-codeaction-source)', opts)
      -- Remap keys for applying codeActions to the current buffer
      keyset('n', '<leader>ac', '<Plug>(coc-codeaction)', opts)
      -- Apply the most preferred quickfix action on the current line
      keyset('n', '<leader>qf', '<Plug>(coc-fix-current)', opts)
      -- Remap keys for apply refactor code actions.
      keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)")
    end
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
      local ft = require('Comment.ft')
      ft.set('dts', ft.get('c'))
    end,
  },
  -- surrounder
  {
    'kylechui/nvim-surround',
    version = '^v2',
    config = function()
      require("nvim-surround").setup {
        -- `ys` is too far :p
        keymaps = {
          normal = 'ts',
          normal_cur = 'tss',
          normal_line = 'tS',
          normal_cur_line = 'tSS',
        },
      }
    end,
  },
  -- mainly for the git blame feature
  {
    'tpope/vim-fugitive',
    keys = {
      -- o    jump to patch or blob in horizontal split
      -- -    reblame at commit
      -- ~    reblame at nth ancestor
      -- P    reblame at nth parent
      { '<leader>b', ':Git blame<CR>' },
    },
  },
  -- which-key.nvim
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end,
  },
  -- log highlighting, TODO: rewrite in lua?
  { 'mtdl9/vim-log-highlighting' },

  -- Disabled --

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
    enabled = false,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').clangd.setup {}
    end,
    enabled = false,
  },
  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("bufferline").setup {
        options = {
          modified_icon = '*',
          diagnostics = 'coc',
          show_buffer_icons = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          max_name_length = 5,
        },
        highlights = {
          buffer_selected = { italic=false },
          diagnostic_selected = { italic=false },
        },
      }
    end,
    enabled = false,
  },
}
