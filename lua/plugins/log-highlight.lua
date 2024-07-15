-- log-highlight
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
            'messages%..*',
            'messages-.*',
            '.*%.LATEST',
            '.*%.PREVIOUS',
            '.*%.previous',
        },
    },
}
