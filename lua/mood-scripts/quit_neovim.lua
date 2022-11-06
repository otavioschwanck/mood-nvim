local filter = vim.tbl_filter

local function quit_neovim()
  local term = require('tmux-awesome-manager')

  local keyset = {}
  local n = 0

  for k, v in pairs(vim.g.tmux_open_terms) do
    n = n + 1
    keyset[n] = k
  end

  if n > 0 then
    local response = vim.fn.input("There is some terminals open.  Close then before exit? y/n  ")

    if response == 'y' or response == 's' or response == 'Y' then
      term.kill_all_terms()
    end
  end
end

return quit_neovim
