-- Surrounding actions (parenthesis, quotes, etc.)
-- https://github.com/echasnovski/mini.surround
return {
    'echasnovski/mini.surround',
    keys = function(_, keys)
        -- Populate the keys based on the user's options
        local opts = require('mini.surround').config
        local mappings = {
            { opts.mappings.add, desc = 'Surround: Add', mode = { 'n', 'v' } },
            { opts.mappings.delete, desc = 'Surround: Delete' },
            { opts.mappings.find, desc = 'Surround: Find Right' },
            { opts.mappings.find_left, desc = 'Surround: Find Left' },
            { opts.mappings.highlight, desc = 'Surround: Highlight' },
            { opts.mappings.replace, desc = 'Surround: Replace' },
        }
        mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)
        return vim.list_extend(mappings, keys)
    end,
    opts = {
        mappings = {
            add = "<leader>'a", -- Add surrounding in Normal and Visual modes
            delete = "<leader>'d", -- Delete surrounding
            find = "<leader>'f", -- Find surrounding (to the right)
            find_left = "<leader>'F", -- Find surrounding (to the left)
            highlight = "<leader>'h", -- Highlight surrounding
            replace = "<leader>'r", -- Replace surrounding
        },
    },
}
