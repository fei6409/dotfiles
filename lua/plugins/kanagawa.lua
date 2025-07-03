-- Colorscheme
-- https://github.com/rebelot/kanagawa.nvim
return {
    'rebelot/kanagawa.nvim',
    -- make sure the colorscheme is loaded first since start plugins can
    -- possibly change existing highlight groups
    priority = 1000,
    opts = {
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
                TelescopeTitle = { fg = theme.ui.special, bold = true },
                TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                TelescopePromptBorder = { bg = theme.ui.bg_p1, fg = theme.ui.nontext },
                TelescopeResultsNormal = { bg = theme.ui.bg_m1, fg = theme.ui.fg_dim },
                TelescopeResultsBorder = { bg = theme.ui.bg_m1, fg = theme.ui.nontext },
                TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.nontext },
            }
        end,
    },
    init = function() vim.cmd.colorscheme('kanagawa') end,
}
