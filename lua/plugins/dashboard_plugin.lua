return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[ ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { key = "SPC h l", icon = "󰉙 ", desc = " Load Session", action = 'lua require("persistence").load() ' },
            { key = "SPC tab", icon = " ", desc = " Git Status", action = "Telescope git_status " },
            { key = "SPC h m", icon = "󰑶 ", desc = " Mason (Manage LSP / Linters)", action = "Mason" },
            { key = "SPC f p", icon = " ", desc = " User Settings", action = "lua require('mood-scripts.open-files').open_dotfiles()" },
            { key = "SPC h h", icon = " ", desc = " Open Handbook (docs)", action = "e " .. vim.fn.fnamemodify(vim.fn.expand("$MYVIMRC"), ":h") .. "/handbook.md " },
            { key = "SPC h T", icon = "ﲉ ", desc = " Open Tutorial for mooD", action = 'lua require("tutorial").start() ' },
            { key = "SPC h u", icon = " ", desc = " Update mooD", action = "UpdateMood" },
            { key = "SPC q q", icon = " ", desc = " Quit", action = "qa" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
