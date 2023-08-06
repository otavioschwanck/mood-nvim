local util = require("formatter.util")

local function rubocop()
	return {
		exe = "bundle",
		args = {
			"exec",
			"rubocop",
			"-A",
			"--stdin",
			"foo.rb",
			"--format",
			"files",
			"--stderr",
		},
		stdin = true,
	}
end

return rubocop
