-- Optimized fuzzy file finder
-- https://github.com/dmtrKovalenko/fff.nvim
return {
    'dmtrKovalenko/fff.nvim',
    build = function()
        -- this will download prebuild binary or try to use existing rustup toolchain to build from source
        -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
        require('fff.download').download_or_build_binary()
    end,
    lazy = false, -- This plugin initializes itself lazily.
    keys = {
        {
            '<leader>sf',
            function() require('fff').find_files() end,
            desc = '[S]earch [F]iles (fff)',
        },
        {
            '<leader>sg',
            function() require('fff').live_grep() end,
            desc = '[S]earch [G]rep (fff)',
        },
        {
            '<leader>sz',
            function()
                require('fff').live_grep {
                    grep = {
                        modes = { 'fuzzy', 'plain' },
                    },
                }
            end,
            desc = '[S]earch Fu[Z]zy grep (fff)',
        },
        {
            '<leader>ss',
            function() require('fff').live_grep { query = vim.fn.expand('<cword>') } end,
            desc = '[S]earch current [S]tring (fff)',
        },
    },
}
