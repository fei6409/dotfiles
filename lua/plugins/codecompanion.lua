-- Generic LLM support
-- https://github.com/olimorris/codecompanion.nvim

return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    version = '^19.0.0',
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
    },
    config = function()
        local adapter = 'copilot'

        if os.getenv('GEMINI_API_KEY') and os.getenv('GEMINI_URL') then adapter = 'gemini' end

        return require('codecompanion').setup {
            interactions = {
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
                            schema = {
                                model = { default = 'gemini-3-flash-preview' },
                            },
                        })
                    end,
                },
            },
            rules = {
                gemini = {
                    description = 'Common Gemini Markdown files',
                    files = {
                        '~/.gemini/GEMINI.md',
                        '~/.gemini/BEHAVIOR.md',
                        '~/.gemini/EXPERTISE.md',
                        '~/.gemini/WORKFLOW.md',
                    },
                },
                opts = { chat = { autoload = { 'default', 'gemini' } } },
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
        }
    end,
}
