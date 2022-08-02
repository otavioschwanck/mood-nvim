local M = {}

function M.setup()
  vim.cmd('call timer_start(4000, {-> execute("call OpenCommand()") })')
  vim.cmd("PackerInstall")
  vim.cmd("PackerClean")
end

return M
