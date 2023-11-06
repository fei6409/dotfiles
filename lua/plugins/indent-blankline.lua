-- visual indentation guide
return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        -- vim.cmd [[highlight Gray guibg=#181818 gui=nocombine]]
        -- vim.cmd [[highlight Black guibg=#0d0c0c gui=nocombine]]
        local monochrome = {
            'MonochromeLight',
            'MonochromeDark',
        }

        local rainbow = {
            'RainbowYellow',
            'RainbowRed',
            'RainbowCyan',
            'RainbowViolet',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowBlue',
        }

        local hooks = require 'ibl.hooks'
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, 'MonochromeLight', { bg = '#202020' })
            vim.api.nvim_set_hl(0, 'MonochromeDark', { bg = '#0D0C0C' })
            vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
            vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
            vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
            vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
            vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
            vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
            vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        end)

        require('ibl').setup {
            indent = {
                highlight = rainbow,
            },
            whitespace = {
                highlight = monochrome,
                remove_blankline_trail = false,
            },
            scope = { enabled = false },
        }
    end,
}
