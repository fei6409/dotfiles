-- Generic LLM support
-- https://github.com/olimorris/codecompanion.nvim

local review_prompt = [[
Perform a comprehensive code review as a senior developer.
Maintain a professional, direct, and concise tone throughout the review.
Structure the response as follows:

1.  **Code Summary:** Provide a concise explanation of what the code does.

2.  **Bugs and Issues:** Identify bugs, security vulnerabilities, or logical
issues. For each problem, provide a brief explanation and a code example of the
fix. If no significant issues are found, explicitly state "No major bugs or
issues found."

3.  **Style and Readability:** Suggest improvements for style, naming,
readability, consistency, and best practices. If no significant style
improvements are needed, explicitly state "No major style improvements
suggested."
]]

return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    enabled = false,
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    keys = {
        {
            '<leader>cp',
            '<cmd>CodeCompanionActions<cr>',
            mode = { 'n', 'v' },
            desc = 'CodeCompanion: Open Action Palette',
        },
        {
            '<leader>cc',
            '<cmd>CodeCompanionChat Toggle<cr>',
            mode = { 'n', 'v' },
            desc = 'CodeCompanion: Toggle Chat',
        },
        {
            '<leader>cr',
            '<cmd>CodeCompanion /review<cr>',
            mode = { 'n', 'v' },
            desc = 'CodeCompanion: Review selected code',
        },
    },
    config = function()
        local adapter = 'copilot'

        if os.getenv('GEMINI_API_KEY') and os.getenv('GEMINI_URL') then adapter = 'gemini' end

        return require('codecompanion').setup {
            strategies = {
                chat = {
                    adapter = adapter,
                    tools = { opts = { default_tools = { 'files' } } },
                },
                inline = { adapter = adapter },
                cmd = { adapter = adapter },
            },
            adapters = {
                http = {
                    gemini = function()
                        return require('codecompanion.adapters').extend('gemini', {
                            env = {
                                -- read pd-ai-key from envvar
                                api_key = 'GEMINI_API_KEY',
                                url = 'GEMINI_URL',
                            },
                        })
                    end,
                },
            },
            display = {
                chat = {
                    window = {
                        position = 'right',
                    },
                    auto_scroll = true,
                    show_settings = true,
                },
            },
            prompt_library = {
                ['Review'] = {
                    strategy = 'chat',
                    description = 'Review selected code',
                    opts = {
                        is_default = true,
                        is_slash_cmd = true,
                        short_name = 'review',
                        auto_submit = false,
                        stop_context_insertion = true, -- prevent duplicated selected text
                    },
                    prompts = {
                        {
                            role = 'system',
                            content = review_prompt,
                        },
                        {
                            role = 'user',
                            content = function(context)
                                return string.format(
                                    'Review the code:\n\n```%s\n%s\n```\n\n',
                                    context.filetype,
                                    table.concat(context.lines, '\n')
                                )
                            end,
                            opts = { contains_code = true },
                        },
                    },
                },
                ['Apply'] = {
                    strategy = 'chat',
                    description = 'Apply changes to current buffer',
                    opts = {
                        is_slash_cmd = true,
                        short_name = 'apply',
                        auto_submit = false,
                    },
                    prompts = {
                        {
                            role = 'user',
                            content = 'apply the change in #{buffer}',
                        },
                    },
                },
            },
        }
    end,
}
