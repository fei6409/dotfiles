-- Optimized fuzzy file finder
-- https://github.com/dmtrKovalenko/fff
return {
    'dmtrKovalenko/fff',
    build = function()
        -- downloads a prebuilt binary or falls back to cargo build
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
            function() require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } } end,
            desc = '[S]earch Fu[Z]zy grep (fff)',
        },
        {
            '<leader>ss',
            function() require('fff').live_grep_under_cursor() end,
            mode = { 'n', 'x' },
            desc = '[S]earch current [S]tring (fff)',
        },
    },
}
