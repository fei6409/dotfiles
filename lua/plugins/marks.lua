-- Better Vim mark interaction
-- https://github.com/chentoast/marks.nvim
return {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {
        refresh_interval = 1000,
    },
    -- Keymaps:
    -- mx              Set mark x
    -- dmx             Delete mark x
    -- m;              Toggle the next available mark at the current line
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
}
