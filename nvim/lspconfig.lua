require("nvchad.configs.lspconfig").defaults()

local function on_attach(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	if not client.server_capabilities.signatureHelpProvider then
		vim.lsp.handlers["textDocument/signatureHelp"] = nil
	end
end

vim.lsp.config("*", {
	root_markers = { ".git", "CMakeLists.txt" },
	on_attach = on_attach,
})

vim.lsp.config.clangd = {
	cmd = {
		"clangd",
    "-j=4",
		"--clang-tidy",
		"--background-index",
		"--header-insertion=never",
		"--completion-style=detailed",
		"--function-arg-placeholders=0",
    "--pch-storage=disk"
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	init_options = {
		fallbackFlags = {
			"-std=c++26",
			"-Wall",
			"-Wextra",
			"-Wpedantic",
		},
	},
}

vim.lsp.config.cmake = {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	init_options = {
		buildDirectory = "build",
	},
}

vim.lsp.config.jsonls = {
	cmd = function(dispatchers, config)
		local cmd = "vscode-json-language-server"
		if (config or {}).root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end
		return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
	end,
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	settings = {
		json = {
			schemas = {
				{
					fileMatch = { "package.json", "*/package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
			},
			validate = { enable = true },
		},
	},
}

vim.lsp.config.basedpyright = {
	settings = {
		analysis = {
			-- Define o tipo de checagem (padrão é "standard", mas suas regras customizam isso)
			typeCheckingMode = "standard",

			-- Suas regras personalizadas traduzidas para a sintaxe do LSP (Lua)
			diagnosticSeverityOverrides = {
				reportConstantRedefinition = "none",
				reportMissingSuperCall = "none",
				reportMissingTypeArgument = "none",
				reportGeneralTypeIssues = "warning",
				reportUnknownVariableType = "none",
				reportUnknownParameterType = "none",
				reportUnknownMemberType = "none",
				reportUnknownArgumentType = "none",
				reportAny = "none",
				reportMissingParameterType = "none",
				reportUnusedParameter = "none",
				reportUnusedCallResult = "none",
				reportExplicitAny = "none",
				reportDeprecated = "none",
				reportUnusedImport = "none",
				reportUnannotatedClassAttribute = "none",
				reportImplicitOverride = "none",
				reportMissingTypeStubs = "none",
				reportUnknownLambdaType = "none",
				reportUnnecessaryComparison = "none",
				reportUnreachable = "none",
			},
		},
	},
}

local servers = { "html", "cssls", "clangd", "cmake", "basedpyright", "ts_ls", "tailwindcss", "jsonls" }
vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
