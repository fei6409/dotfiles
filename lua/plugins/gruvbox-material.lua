-- colorscheme
return {
  'sainnhe/gruvbox-material',
  -- make sure the colorscheme is loaded first since start plugins can
  -- possibly change existing highlight groups
  priority = 1000,
  init = function()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'mix'
    vim.g.gruvbox_material_better_performance = 1
    -- darker background color
    vim.g.gruvbox_material_colors_override = { bg0 = { '#080808', '232' } }
    vim.cmd.colorscheme('gruvbox-material')
  end,
  enabled = false,
}
