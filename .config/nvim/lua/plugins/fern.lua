return {
  -- Tree viewer
  {
    -- Fern
    'lambdalisue/fern.vim',
    keys = {{'<C-f>', '<cmd>Fern . -drawer -toggle<CR>'}},
    config = function()
      vim.g['fern#default_hidden'] = 1
    end,
  },
}
