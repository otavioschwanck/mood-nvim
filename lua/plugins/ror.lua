local M = {}

function M.setup()
  require("ror").setup({
    test = {
      message = {
        file = "Running test file",
        line = "Running single test"
      },
      coverage = {
        up = "DiffAdd",
        down = "DiffDelete",
      },
      notification = {
        timeout = 5000
      },
      pass_icon = "✅",
      fail_icon = "❌"
    }
  })
end

return M
