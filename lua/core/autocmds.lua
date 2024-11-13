local M = {}

function M.setup()
  vim.g.exiting = false
  vim.g.scheduled_save_session = false

  local autocommands = {
    {
      { "FileType" },
      { "qf" },
      function()
        vim.cmd("map <buffer> dd :RemoveQFItem<CR>")
      end,
    },
    {
      { "VimLeavePre" },
      { "*" },
      function()
        vim.g.exiting = true
      end,
    },
    {
      { "FileType" },
      { "TelescopePrompt" },
      function()
        vim.cmd("setlocal nocursorline")
      end,
    },
    {
      { "BufWritePre" },
      { "*" },
      function()
        vim.cmd('call mkdir(expand("<afile>:p:h"), "p")')
      end,
    },
    {
      { "BufReadPost", "BufDelete" },
      { "*" },
      function(ft)
        require("mood-scripts.auto-save-session").save_session(ft)
      end,
    },
  }

  for i = 1, #autocommands, 1 do
    vim.api.nvim_create_autocmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
  end

  vim.api.nvim_create_autocmd("BufRead", {
    pattern = "*.norg",
    command = "norm zR",
  })

  local function augroup(name)
    return vim.api.nvim_create_augroup("otavioschwanck_" .. name, { clear = true })
  end

  -- Check if we need to reload the file when it changed
  vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
  })

  -- resize splits if window got resized
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  })

  -- go to last loc when opening a buffer
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "qf",
      "help",
      "man",
      "notify",
      "lspinfo",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "PlenaryTestPopup",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
      vim.api.nvim_buf_call(ctx.buf, function()
        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
      end)
    end,
  })

  -- wrap and check for spell in text filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })
end

return M
