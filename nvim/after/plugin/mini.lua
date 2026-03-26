require('mini.files').setup({
  -- Custom internal mappings
  mappings = {
    go_in       = 'L', -- Standard "go in" (slow, stays open)
    go_in_plus  = 'l', -- "Go in" and close if it's a file (fast)
    go_out      = 'H', -- Standard "go out"
    go_out_plus = 'h', -- "Go out" and close (if you prefer)
  },
  windows = {
    preview = true, -- Turn on preview to see file content while browsing
    width_focus = 25,
    width_preview = 80,
  },
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id

    -- Функция-хелпер для синхронизации
    local sync = function()
      vim.cmd('stopinsert') -- Выходим из режима вставки, если мы там
      require('mini.files').synchronize()
    end

    -- В NORMAL моде: Enter — применить изменения
    vim.keymap.set('n', '<CR>', sync, { buffer = buf_id, desc = "Apply changes" })

    -- В INSERT моде:
    -- <CR> (Enter) — просто перенос строки (пишем список дальше)
    -- <C-CR> (Ctrl+Enter) — применить изменения сразу из режима вставки
    vim.keymap.set('i', '<C-CR>', sync, { buffer = buf_id, desc = "Apply and exit" })

    -- Если твой терминал поддерживает Shift+Enter (как <S-CR>):
    vim.keymap.set('i', '<S-CR>', sync, { buffer = buf_id, desc = "Apply and exit" })
  end,
})

require('mini.pairs').setup()
