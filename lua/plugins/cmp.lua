-- completion engine
-- setup reference: https://youtu.be/_DnmphIwnjo
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        -- for LuaSnip
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    event = 'VeryLazy',
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup {
            mapping = {
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
                ['<CR>'] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and luasnip.expandable() then
                            luasnip.expand()
                        elseif cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false, })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
            },
            sources = cmp.config.sources {
                -- the order matters!
                { name = 'nvim_lsp', max_item_count = 20 },
                { name = 'path' },
                { name = 'luasnip' },
                { name = 'buffer',   keyword_length = 3 },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            experimental = {
                native_menu = false,
            },
        }
    end,
}
