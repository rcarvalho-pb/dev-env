-- Destaca o texto copiado por um instante (feedback visual do yank)
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Destacar texto copiado",
  group = vim.api.nvim_create_augroup("user-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Remove espaços em branco no fim da linha ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remover trailing whitespace ao salvar",
  group = vim.api.nvim_create_augroup("user-trim-whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Volta para a última posição do cursor ao reabrir um arquivo
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restaurar última posição do cursor",
  group = vim.api.nvim_create_augroup("user-last-loc", { clear = true }),
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
