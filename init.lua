-- setup user files
local not_ok = {}

local function setup(path)
  local ok, res = pcall(require(path).setup)

  if not(ok) then
    table.insert(not_ok, path)

    if os.getenv("DEBUG") == "true" then
      print("[WARN] [" .. path .. "]: " .. res)
    end
  end
end

setup('mood-scripts.install-config')

pcall(require, 'impatient')

-- vim script functions
setup('helpers.vim-functions')
setup('helpers.term-functions')

setup('core.plugins')

if #not_ok == 0 then
  setup('core.autocmds')
end

setup('core.set')
setup('core.globals')
setup('core.mappings')

-- mood
setup('mood-scripts.quick-consult')

-- plugins
setup('plugins.telescope')
setup('plugins.tree-sitter')
setup('plugins.autopairs')
setup('plugins.yanky')
setup('plugins.dashboard_plugin')
setup('plugins.lualine')
setup('plugins.ctrlsf')

-- user
pcall(require, 'user.lsp')
pcall(require, 'user.config')
pcall(require, 'user.keybindings')

setup('plugins.nvim-tree')

-- startup
setup('core.start')

if #not_ok > 0 then
  print("Some Error happening when loading neovim: \n")
  print("Try to restart Neovim.  If the error persist:\n1 - Run :PackerInstall\n2 - Run :UpdateMood\n3 - Try to reinstall neovim.\n4 - Create an issue to help to fix\n5 - run neovim with DEBUG=true nvim")
  print("Modules with errors: ")

  for i = 1, #not_ok, 1 do
    print(" - " .. not_ok[i])
  end
end
