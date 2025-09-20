-- Remember the initial directory when first opening fern
local fern_root_dir = nil

return {
  -- Tree viewer
  {
    -- Fern
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/nerdfont.vim',
    },
    keys = {
      {'<C-f>', function()
        -- If fern_root_dir is not set, determine it from current context
        if not fern_root_dir then
          local current_path = vim.fn.expand('%:p')
          if current_path ~= '' then
            if vim.fn.isdirectory(current_path) == 1 then
              fern_root_dir = current_path
            else
              fern_root_dir = vim.fn.expand('%:p:h')
            end
          else
            fern_root_dir = vim.fn.getcwd()
          end
        end

        -- Check if fern drawer is already open
        local fern_open = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buftype = vim.api.nvim_buf_get_option(buf, 'filetype')
          if buftype == 'fern' then
            fern_open = true
            -- Focus the fern window
            vim.api.nvim_set_current_win(win)
            break
          end
        end

        -- If fern is not open, open it
        if not fern_open then
          vim.cmd('Fern ' .. fern_root_dir .. ' -drawer')
        end
      end},
    },
    config = function()
      vim.g['fern#default_hidden'] = 1
      
      -- Enable nerdfont renderer for icons
      vim.g['fern#renderer'] = 'nerdfont'

      -- Disable control character display in fern buffer  
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fern',
        callback = function()
          vim.opt_local.list = false
          vim.opt_local.listchars = ""
          vim.opt_local.conceallevel = 3
          vim.opt_local.concealcursor = "nvic"
          
          -- Hide control characters with syntax highlighting
          vim.cmd([[syntax match FernControlChar /\^\w/ conceal]])
          vim.cmd([[syntax match FernControlChar /\^_/ conceal]])
        end,
      })
    end,
  },
}
