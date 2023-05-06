-- colorscheme
return {
  'rebelot/kanagawa.nvim',
  -- make sure the colorscheme is loaded first since start plugins can
  -- possibly change existing highlight groups
  priority = 1000,
  init = function()
    require('kanagawa').setup {
      colors = {
        theme = {
          wave = {
            ui = { bg = '#0d0c0c' },
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
  -- enabled = false,
}
