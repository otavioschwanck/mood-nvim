vim.g.copilot_no_tab_map = true

local not_ok = {}

local function setup(path)
  local ok, res = pcall(require(path).setup)

  if not (ok) then
    table.insert(not_ok, path)

    if os.getenv("DEBUG") == "true" then
      print("[WARN] [" .. path .. "]: " .. res)
    end
  end

  return ok
end

vim.g.mapleader = " "

setup('mood-scripts.install-config')

-- vim script functions
setup('helpers.vim-functions')
setup('helpers.term-functions')

setup('core.plugins')

if #not_ok == 0 then
  setup('core.autocmds')
end


setup('core.set')
setup('core.globals')
-- mood
setup('mood-scripts.quick-consult')

-- startup
setup('core.start')

if #not_ok > 0 then
  print("Some Error happening when loading neovim: \n")
  print("Try to restart Neovim.  If the error persist:\n1 - Run :Lazy install\n2 - Run :UpdateMood\n3 - Try to reinstall neovim.\n4 - Create an issue to help to fix\n5 - run neovim with DEBUG=true nvim")
  print("Modules with errors: ")

  for i = 1, #not_ok, 1 do
    print(" - " .. not_ok[i])
  end
end

pcall(require, 'user.after_start')
