-- log-highlight
return {
    'fei6409/log-highlight.nvim',
    opts = {
        extension = 'log',
        filename = {
            'messages',
            'logcat',
            'syslog',
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
