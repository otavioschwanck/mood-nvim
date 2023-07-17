local M = {}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.require_ask_delete_if_fails(module, file_path, example_path)
  local ok, err = pcall(require, module)

  if not ok then
    vim.notify(
    "Looks like an error happens while loading your " ..
    module ..
    ".\n\nThis could be some plugin beign removed from mood\n The Error:\n " ..
    err .. "\n\n1 - Recreate default\n2 - Open File\n3 - Ignore", vim.log.levels.ERROR)

    local input = vim.fn.input("What do you want to do? (1/2/3): ")

    if input == "1" then
      vim.fn.system("cp " .. file_path .. " " .. file_path .. ".bak")
      vim.fn.system("rm " .. file_path)
      vim.fn.system("cp " .. example_path .. " " .. file_path)

      vim.notify("Recreated default config file.  Your old file is in " .. file_path .. ".bak", vim.log.levels.INFO)

      require(module)

      local open_input = vim.fn.input("Do you want to open the file? (y/n): ")

      if open_input == "y" then
        vim.cmd("edit " .. file_path .. ".bak")
        vim.cmd(t("norm! <C-w>v"))
        vim.cmd("edit " .. file_path)
      end
    elseif input == "2" then
      vim.cmd("edit " .. file_path)
    end
  end
end

return M
