local M = {}

function M.setup()
  vim.g.ctrlsf_mapping = {
    open    = { "<CR>", "o" },
    openb   = "O",
    split   = "<C-O>",
    vsplit  = "",
    tab     = "t",
    tabb    = "T",
    popen   = "p",
    popenf  = "P",
    quit    = "q",
    next    = "<C-J>",
    prev    = "<C-K>",
    nfile   = "<C-N>",
    pfile   = "<C-P>",
    pquit   = "q",
    loclist = "",
    chgmode = "<TAB>",
    stop    = "<C-C>",
  }
end

return M
