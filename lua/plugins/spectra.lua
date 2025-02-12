return {
  {
    "windwp/nvim-spectre",
    event = "VeryLazy",
    config = function()
      local args = {}
      local is_mac = vim.loop.os_uname().sysname == "Darwin"

      if is_mac then
        args = {
          replace_engine = {
            ["sed"] = {
              cmd = "sed",
              args = {
                "-i",
                "",
                "-E",
              }
            },
          }
        }
      end

      require("spectre").setup({})
    end,
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
