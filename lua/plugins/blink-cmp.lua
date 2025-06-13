-- Completion Engine (new)
-- https://github.com/saghen/blink.cmp

return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
        appearance = { nerd_font_variant = 'mono' },
        keymap = {
            preset = 'default',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            ['<Up>'] = { 'fallback' },
            ['<Down>'] = { 'fallback' },
        },
        cmdline = {
            keymap = { preset = 'inherit' },
            completion = { menu = { auto_show = true } },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            min_keyword_length = 3,
        },
        completion = {
            list = {
                selection = { preselect = false, auto_insert = true },
                max_items = 20,
            },
            documentation = { auto_show = true },
        },
        signature = { enabled = true },
    },
}
