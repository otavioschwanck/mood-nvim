return {
	{
		"windwp/nvim-spectre",
		event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
	},
}
