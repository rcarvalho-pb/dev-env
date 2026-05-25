require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<C-n>"] = {
			function()
				-- Retornar true avisa ao Blink que nós "tratamos" a tecla,
				-- impedindo o Neovim de executar o comportamento nativo dele.
				return true
			end,
		},
		["<C-p>"] = {
			function()
				return true
			end,
		},
	},
	appearance = { nerd_font_variant = "mono" },
	-- completion = { menu = { auto_show = true } },
	completion = {
		-- Controla o menu principal de sugestões
		menu = {
			auto_show = true,
			border = "rounded",
		},

		-- PROTEÇÃO DA JANELA DE INFORMAÇÕES (DOCUMENTAÇÃO)
		documentation = {
			auto_show = true, -- Mostra a documentação automaticamente ao navegar
			auto_show_delay_ms = 50, -- Um微segundo de delay evita que o LSP cancele a janela
			update_delay_ms = 50, -- Suaviza a atualização das informações

			window = {
				border = "rounded", -- Mantém o visual arredondado do seu ecossistema
				max_width = 60,
				max_height = 20,
			},
		},
	},

	-- Evita conflitos se você usar assinaturas de função (LSP Signature Help)
	signature = {
		enabled = true,
		window = { border = "rounded" },
	},
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}
