-- Generic LLM support
-- https://github.com/olimorris/codecompanion.nvim
return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    keys = {
        {
            '<leader>cp',
            '<cmd>CodeCompanionActions<CR>',
            mode = { 'n', 'v' },
            desc = 'CodeCompanion: Open Action Palette',
        },
        {
            '<leader>cc',
            '<cmd>CodeCompanionChat Toggle<CR>',
            mode = { 'n', 'v' },
            desc = 'CodeCompanion: Toggle Chat',
        },
        {
            '<leader>ca',
            '<cmd>CodeCompanionChat Add<CR>',
            mode = 'v',
            desc = 'CodeCompanion: Add Selected Text to Chat',
        },
    },
    opts = {
        strategies = {
            -- chat = { adapter = 'gemini' },
            -- inline = { adapter = 'gemini' },
            -- cmd = { adapter = 'gemini' },
        },
        display = {
            chat = {
                window = {
                    position = 'right',
                },
                auto_scroll = false,
            },
        },
        prompt_library = {
            ['Review'] = {
                strategy = 'chat',
                description = 'Review the selected code.',
                opts = {
                    mode = { 'v' },
                    is_default = true,
                    is_slash_cmd = true,
                    short_name = 'review',
                    auto_submit = false,
                    stop_context_insertion = true, -- prevent duplicated selected text
                },
                prompts = {
                    {
                        role = 'system',
                        content = function(context)
                            return 'Review the provided code as a senior developer of '
                                .. context.filetype
                                .. '. Return concise explanations and codeblock examples if needed.'
                        end,
                    },
                    {
                        role = 'user',
                        content = function(context)
                            local text =
                                require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)

                            return 'Please review the following code:\n\n```'
                                .. context.filetype
                                .. '\n'
                                .. text
                                .. '\n```\n\n'
                        end,
                        opts = { contains_code = true },
                    },
                },
            },
        },
    },
}
