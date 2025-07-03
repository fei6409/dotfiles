-- File explorer
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    cmds = 'NeoTree',
    keys = {
        { '<leader>t', '<cmd>Neotree toggle<cr>', desc = 'Toggle Neotree window' },
    },
    opts = {
        close_if_last_window = true,
        filesystem = {
            follow_current_file = { enabled = true },
        },
        default_component_configs = {
            symlink_target = { enabled = true },
        },
    },
}
