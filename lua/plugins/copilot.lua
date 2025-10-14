-- Copilot support
-- https://github.com/zbirenbaum/copilot.lua
return {
    'zbirenbaum/copilot.lua',
    cmd = { 'Copilot' },
    build = ':Copilot auth',
    event = 'VeryLazy',
    commit = '4725916b1e08',
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
            jjdescription = true,
            markdown = true,
        },
    },
}
