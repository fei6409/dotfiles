return {
    'fei6409/log-highlight.nvim',
    config = function()
        require('log-highlight').setup {
            extension = 'log',
            filename = {
                'messages',
                'logcat',
                'syslog',
            },
            pattern = {
                '/var/log/.*',
                'messages%..*',
                '.*%.LATEST',
                '.*%.PREVIOUS',
                '.*%.previous',
            },
        }
    end,
}
