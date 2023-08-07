local util = require("formatter.util")

local function rubocop()
	return {
		exe = "bundle",
		args = {
			"exec",
			"rubocop",
			"-A",
			"--stdin",
			util.escape_path(util.get_current_buffer_file_path()),
			"--format",
			"files",
			"--stderr",
		},
		stdin = true,
	}
end

return rubocop
