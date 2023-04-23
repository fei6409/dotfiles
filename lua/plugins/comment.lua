-- commenter
return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup {
      toggler = { line = '\\', block = '<leader>\\' },
      opleader = { line = '\\', block = '<leader>\\' },
      mappings = { extra = false },
    }
    local ft = require('Comment.ft')
    ft.set('dts', ft.get('c'))
  end,
}
