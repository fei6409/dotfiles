-- Log filetype highlighting
-- https://github.com/fei6409/log-highlight.nvim
return {
    'fei6409/log-highlight.nvim',
    -- event = 'VeryLazy',
    opts = {
        extension = 'log',
        filename = {
            'syslog',
            'chrome',
        },
        pattern = {
            '%/var%/log%/.*',
            'console%-ramoops.*',
            'messages.*',
            'logcat.*',
            'log.*%.txt',
            '.*%.LATEST',
            '.*%.PREVIOUS',
            '.*%.previous',
        },
    },
}
