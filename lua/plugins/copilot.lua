-- Copilot support
-- https://github.com/zbirenbaum/copilot.lua
return {
    'zbirenbaum/copilot.lua',
    cmd = { 'Copilot' },
    build = ':Copilot auth',
    event = 'VeryLazy',
    opts = {
        suggestion = {
            auto_trigger = false,
            keymap = {
                next = '<M-]>',
                prev = '<M-[>',
            },
        },
        filetypes = {
            gitcommit = true,
            gitrebase = true,
            markdown = true,
        },
    },
}
