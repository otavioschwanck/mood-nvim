-- LSP --------------------------------------------
-- Your Language server protocol stuff
---------------------------------------------------

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vs-snippets" } })

-- Plugins that we will use to setup LSP
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Setup Mason
require("mason").setup()

-- Configure your servers.
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"lua_ls",
		"jsonls",
		"solidity",
		"yamlls",
		"jsonls", -- Don't install solargraph with mason, it sucks.
	},
})

-- Your formatters. (Comment this to disable autoformatters)
require("formatter").setup({
	logging = false,
	filetype = {
		ruby = { require("mood-scripts.formatter_rubocop") }, -- Format with rubocop -A instead normal.
		javascript = { require("formatter.filetypes.javascript").prettier },
		typescript = { require("formatter.filetypes.typescript").prettier },
		javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
		typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
		lua = { require("formatter.filetypes.lua").stylua },
	},
})

-- when LSP os connceted, this function is called.
local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr }

	local bind = vim.keymap.set

	bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	bind("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
	bind("n", "gI", "<cmd>Telescope lsp_implementations<cr>", opts)
	bind("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)
	bind("n", "K", vim.lsp.buf.hover, opts)
end

-- Add our on_attach for mason installed LSP.
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = lsp_capabilities,
		})
	end,
})

vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" } -- Dont select first item

lspconfig["solidity"].setup({ -- setup solidity (remove if you don't use)
	on_attach = on_attach,
	settings = {
		solidity = {
			includePath = "",
			remapping = { ["@OpenZeppelin/"] = "dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/" },
		},
	},
})

lspconfig["solargraph"].setup( -- setup solargraph (Don't install it with mason, it sucks)
	{
		on_attach = on_attach,
		settings = {
			solargraph = {
				formatting = false,
				useBundler = true,
				diagnostics = true, -- lsp diagnostics are slow
			},
		},
	}
)

local sources = {
	{ name = "path" }, -- cmp sources
	{ keyword_length = 2, name = "nvim_lsp" },
	{ name = "buffer", option = { get_bufnrs = require("utils.valid_listed_buffers") } },
	{ name = "luasnip", keyword_length = 2 },
	{ name = "calc" },
}

local autocomplete_mappings = { -- autocomplete mappings
	["<Tab>"] = cmp.mapping.select_next_item({ select = true }, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping.select_prev_item({ select = true }, { "i", "s" }),
	["<CR>"] = cmp.mapping.confirm(),
	["<C-e>"] = cmp.mapping.abort(),
	["<C-n>"] = cmp.mapping(function(fallback)
		if luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump(1)
		end
	end, { "i", "s" }),
	["<C-p>"] = cmp.mapping(function(fallback)
		if luasnip.locally_jumpable() then
			luasnip.jump(-1)
		end
	end, { "i", "s" }),
	["<BS>"] = cmp.mapping(function(fallback)
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Del>", true, true, true), "x")
		luasnip.jump(1)
	end, { "s" }),
	["<C-u>"] = cmp.mapping.scroll_docs(-4),
	["<C-d>"] = cmp.mapping.scroll_docs(4),
}

local border_opts = {
	border = { { "╭" }, { "─" }, { "╮" }, { "│" }, { "╯" }, { "─" }, { "╰" }, { "│" } },
	winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CmpSel,Search:None,NormalFloat:Normal",
	scrollbar = false,
}

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border_opts.border,
	winhighlight = border_opts.winhighlight,
	close_events = { "BufHidden", "InsertLeave" },
})

vim.diagnostic.config({
	float = border_opts,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)

local icons = require("mood-scripts.icons")

cmp.setup({
	mapping = autocomplete_mappings,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		documentation = border_opts,
		completion = border_opts,
	},
	sources = sources,
	formatting = {
		fields = { "abbr", "menu", "kind" },
		format = function(entry, item)
			local icon = icons[item.kind] or icons[entry.source.name]

			item.menu = icon

			return item
		end,
	},
})

-- Fix C-n and C-p for cmdline
local cmdline_mappings = cmp.mapping.preset.cmdline()

cmdline_mappings["<C-P>"] = nil
cmdline_mappings["<C-N>"] = nil

cmp.setup.cmdline("/", {
	mapping = cmdline_mappings,
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmdline_mappings,
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		if vim.g.format_on_save == true then
			vim.cmd("FormatWrite")
		end
	end,
})

-- Our typescript utils plugin. See the commands with SPC m on a javascript/typescript file.
require("typescript").setup({ server = { on_attach = on_attach } })
