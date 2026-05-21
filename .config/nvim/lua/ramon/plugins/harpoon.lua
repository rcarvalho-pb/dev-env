local ok, harpoon = pcall(require, "harpoon")
if not ok then return end

-- 1. Se o Neovim carregou o Harpoon 2 (Branch Correta)
if harpoon.setup and not harpoon.get_mark_config then
	harpoon:setup({
		settings = {
			save_on_toggle = true,
			sync_on_ui_close = true,
			key = function() return vim.loop.cwd() end,
		},
	})
else
	-- 2. SE O NEOVIM TEIMOU EM CARREGAR O HARPOON V1 (A Causa do Bug)
	-- Nós aplicamos uma vacina na metatabela global para autodestruir a chave intrusa
	local harpoon_get_mark_config = harpoon.get_mark_config
	if harpoon_get_mark_config then
		local config = harpoon_get_mark_config()
		if config and type(config) == "table" then
			-- Blindagem via Metatabela: impede QUALQUER plugin de injetar a função maldita aqui
			setmetatable(config, {
				__newindex = function(t, k, v)
					if k == "refresh_projects_b4update" then
						return -- Ignora silenciosamente e joga no lixo
					end
					rawset(t, k, v)
				end
			})
			-- Garante que se ela já estiver lá agora, seja pulverizada
			config.refresh_projects_b4update = nil
		end
	end
end

-- Keymaps universais (funcionam tanto no v1 quanto no v2)
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>ha", function()
	if harpoon.ui then -- Harpoon 2
		harpoon:list():add()
	else -- Harpoon 1
		require("harpoon.mark").add_file()
	end
	print("📌 Arquivo fisgado!")
end, opts)

vim.keymap.set("n", "<leader>he", function()
	if harpoon.ui and harpoon.ui.toggle_quick_menu then -- Harpoon 2
		harpoon.ui:toggle_quick_menu(harpoon:list())
	else -- Harpoon 1
		require("harpoon.ui").toggle_quick_menu()
	end
end, opts)

vim.keymap.set("n", "<leader>1", function()
	if harpoon.ui then harpoon:list():select(1) else require("harpoon.ui").nav_file(1) end
end, opts)

vim.keymap.set("n", "<leader>2", function()
	if harpoon.ui then harpoon:list():select(2) else require("harpoon.ui").nav_file(2) end
end, opts)
