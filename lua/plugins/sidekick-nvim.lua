-- Sidepane with AI CLI
-- https://github.com/folke/sidekick.nvim
return {
    'folke/sidekick.nvim',
    event = 'VeryLazy',
    enabled = false,
    opts = {
        -- Next Edit Suggestions needs Copilot
        nes = { enabled = false },
        cli = {
            mux = {
                backend = 'tmux',
                enabled = true,
            },
            prompts = {
                fix = 'Fix typo or grammar issues of {this}',
            },
        },
    },
    keys = {
        {
            '<C-.>',
            function() require('sidekick.cli').focus { filter = { installed = true } } end,
            desc = 'Sidekick: Focus',
            mode = { 'n', 't', 'i', 'x' },
        },
        {
            '<leader>ag',
            function() require('sidekick.cli').toggle { name = 'gemini', focus = true } end,
            desc = 'Sidekick: Toggle Gemini',
        },
        {
            '<leader>aa',
            function() require('sidekick.cli').toggle { filter = { installed = true } } end,
            desc = 'Sidekick: Toggle CLI',
        },
        {
            '<leader>as',
            function() require('sidekick.cli').select { filter = { installed = true } } end,
            desc = 'Sidekick: Select CLI',
        },
        {
            '<leader>ad',
            function() require('sidekick.cli').close() end,
            desc = 'Sidekick: Detach a CLI Session',
        },
        {
            '<leader>at',
            function() require('sidekick.cli').send { msg = '{this}' } end,
            mode = { 'x', 'n' },
            desc = 'Sidekick: Send This',
        },
        {
            '<leader>af',
            function() require('sidekick.cli').send { msg = '{file}' } end,
            desc = 'Sidekick: Send File',
        },
        {
            '<leader>av',
            function() require('sidekick.cli').send { msg = '{selection}' } end,
            mode = { 'x' },
            desc = 'Sidekick: Send Visual Selection',
        },
        {
            '<leader>ap',
            function() require('sidekick.cli').prompt() end,
            mode = { 'n', 'x' },
            desc = 'Sidekick: Select Prompt',
        },
    },
}
