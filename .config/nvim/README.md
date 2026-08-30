# Configuração Neovim 0.12.4

## Como instalar

1. Faça backup da config atual, se existir:
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```
2. Copie a pasta `nvim/` deste pacote para `~/.config/nvim`.
3. Abra o `nvim`. O `lazy.nvim` vai se auto-instalar e baixar todos os
   plugins na primeira execução.
4. Rode `:Mason` para conferir se `jdtls`, `gopls`, `zls`,
   `kotlin_language_server`, `rust_analyzer`, `ruby_lsp`, `ts_ls`, `html`,
   `cssls`, `templ`, `lua_ls` e `efm-langserver` foram instalados (o
   `mason-lspconfig` e o `mason-tool-installer` fazem isso automaticamente).
5. Rode `:checkhealth` para conferir dependências do sistema.

## Dependências externas que continuam necessárias

Mesmo evitando o CLI do `tree-sitter` e o binário `fzf`, alguns pontos ainda
dependem de ferramentas do sistema — não tem como fugir totalmente delas:

- **Compilador C** (`cc`/`gcc`/`clang`): usado pelo `nvim-treesitter` para
  compilar os parsers baixados (`:TSUpdate`). Não é o CLI `tree-sitter`, é só
  um compilador C, que normalmente já vem no sistema.
- **Java (JDK)**: necessário para o `jdtls` (o próprio jdtls é um programa
  Java).
- **git**: usado pelo `lazy.nvim`, `gitsigns` e `fugitive`.
- **Nerd Font** no terminal: os ícones (`kind_icon` do blink.cmp, ícones do
  oil/telescope/which-key) dependem de uma Nerd Font instalada e configurada
  no seu emulador de terminal.
- **golangci-lint / eslint_d / rubocop**: instalados automaticamente pelo
  Mason (via `mason-tool-installer`), então não precisa instalar à mão.

## Por que Telescope em vez de fzf-lua

Você pediu uma busca "estilo fzf" sem precisar instalar o app `fzf` na
máquina. O `fzf-lua` de fato exige o binário `fzf` externo (ele abre um
terminal embutido e roda o fzf de verdade). O `telescope.nvim`, com o sorter
padrão (Lua puro, sem nenhuma dependência nativa), dá uma experiência de
busca fuzzy equivalente 100% dentro do Neovim — é por isso que ele foi
escolhido no lugar do fzf-lua.

## Mapa de atalhos (leader = espaço)

### Geral
- `<leader>w` — salvar
- `<leader>q` — fechar janela
- `-` — abrir Oil no diretório do arquivo atual
- `<leader>oe` — Oil flutuante

### Busca (Telescope)
- `<leader>ff` — arquivos
- `<leader>fg` — grep
- `<leader>fb` — buffers
- `<leader>fh` — help
- `<leader>fo` — arquivos recentes
- `<leader>fd` — diagnósticos
- `<leader>ft` — TODOs
- `<leader>fn` — arquivos da config do Neovim (`~/.config/nvim`, não o cwd)
- `<leader>fN` — grep dentro da config do Neovim

### LSP (só existem com LSP ativo no buffer)
- `gd` / `gD` / `gi` / `gr` / `gy` — definição / declaração / implementação / referências / tipo
- `K` — hover
- `<leader>rn` — rename
- `<leader>ca` — code action
- `<leader>ds` — diagnóstico da linha
- `[d` / `]d` — navegar diagnósticos
- `<leader>lf` — formatar
- `<leader>ll` — code lens
- `<leader>lh` — toggle inlay hints neste buffer
- `<leader>jo` / `<leader>jv` / `<leader>jm` — Java: organizar imports / extrair variável / extrair método

Inlay hints vêm **ligados por padrão** para qualquer servidor que suporte
(`textDocument/inlayHint`) — jdtls, gopls, rust_analyzer, ts_ls, lua_ls etc.
`<leader>lh` liga/desliga só no buffer atual.

### Toggle do LSP
- `<leader>lt` — liga/desliga o(s) cliente(s) LSP do buffer atual. Esse
  atalho é global (não depende de LSP estar ativo), já que precisa continuar
  funcionando mesmo com o LSP desligado para poder religar.

### Git
- `]h` / `[h` — próximo/anterior hunk
- `<leader>hp/hs/hr/hb/hd` — preview / stage / reset / blame / diff
- `<leader>gs` — Git status (fugitive)
- `<leader>gd` — Git diff split (fugitive)

### Harpoon
- `<leader>a` — adicionar arquivo atual
- `<C-e>` — menu rápido
- `<leader>1..4` — ir para arquivo marcado 1-4

### Flash
- `s` / `S` — jump / jump treesitter

## Linguagens configuradas

Java (foco principal via nvim-jdtls), Go, Zig, Kotlin, Rust, Ruby,
JavaScript/TypeScript, HTML, CSS, Templ — parsers do treesitter, LSPs via
Mason e linters via efm-langserver (eslint_d, golangci-lint, rubocop).
