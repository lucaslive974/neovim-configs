local options = {
	formatters_by_ft = {
		cpp = { "clang-format" },
		c = { "clang-format" },
		lua = { "stylua" },
		css = { "prettier" },
		html = { "prettier" },
		python = { "ruff_fix", "ruff_format" },
	},

	format_on_save = false,
}

return options
