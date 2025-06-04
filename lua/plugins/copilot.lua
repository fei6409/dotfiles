-- Copilot support
-- https://github.com/zbirenbaum/copilot.lua
return {
    'zbirenbaum/copilot.lua',
    cmd = { 'Copilot' },
    event = 'VeryLazy',
    keys = {
        -- { '<leader>cp', '<cmd>Copilot panel<CR>', desc = 'Open Copilot panel' },
    },
    opts = {
        suggestion = {
            keymap = {
                accept = '<C-CR>',
            },
        },
        filetypes = {
            gitcommit = true,
            gitrebase = true,
        },
    },
}
