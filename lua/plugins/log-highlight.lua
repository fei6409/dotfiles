-- Log filetype highlighting
-- https://github.com/fei6409/log-highlight.nvim
return {
    'fei6409/log-highlight.nvim',
    -- event = 'VeryLazy',
    opts = {
        extension = 'log',
        filename = {
            'messages',
            'logcat',
            'syslog',
            'chrome',
        },
        pattern = {
            '/var/log/.*',
            'console-.*',
            'messages.*',
            '.*%.LATEST',
            '.*%.PREVIOUS',
            '.*%.previous',
        },
    },
}
