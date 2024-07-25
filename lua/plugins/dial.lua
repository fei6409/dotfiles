-- Enhanced increment/decrement
return {
    'monaqa/dial.nvim',
    config = function()
        local augend = require 'dial.augend'
        require('dial.config').augends:register_group {
            default = {
                augend.constant.alias.bool,
                augend.constant.new { elements = { 'let', 'const' } },
                augend.date.alias['%Y-%m-%d'],
                augend.date.alias['%Y/%m/%d'],
                augend.integer.alias.binary,
                augend.integer.alias.decimal_int,
                augend.integer.alias.hex,
                augend.semver.alias.semver,
            },
        }
    end,
    keys = {
        {
            '<C-a>',
            function()
                return require('dial.map').inc_normal()
            end,
            expr = true,
            desc = 'Increment',
        },
        {
            '<C-x>',
            function()
                return require('dial.map').dec_normal()
            end,
            expr = true,
            desc = 'Decrement',
        },
    },
}
