# Batch Status

Ngay cap nhat: 2026-07-01

Trang thai hien tai:

- Repo: https://github.com/trungtrung-art/config-nvim
- Branch: `main`
- Batch gan nhat da push truoc do: `704cd35 Add Go debugging workflow`
- Batch 14-17 da duoc lam trong working tree hien tai.

## Da Hoan Thanh

### Batch 14: Shell/CLI polish

- ToggleTerm mo terminal theo `cwd` hien tai de shell workflow de doan.
- Health check bao shell hien tai trong project context.
- Claude/Codex terminal workflow dung Git root neu co, fallback ve `cwd`.

### Batch 15: Markdown/docs workflow

- Them `marksman` cho Markdown LSP.
- Them Treesitter parser `markdown` va `markdown_inline`.
- Prettier Markdown formatting da co san qua Conform.
- Cap nhat README va KEYMAPS cho docs workflow.

### Batch 16: Claude va Codex CLI

- `Space ac`: mo Claude trong project root.
- `Space aC`: continue Claude trong project root.
- `Space ax`: mo Codex trong project root.
- `Space aX`: resume Codex trong project root.
- Health check bao thieu `claude` hoac `codex` nhu optional tools.

### Batch 17: Final audit + release-ready cleanup

- Ra soat keymap moi, docs, health checks, LSP/Treesitter lists.
- Chay headless check va health check truoc khi commit/push.

## Con Lai

- Chay `:MasonToolsInstall` trong Neovim de cai `marksman` neu Mason chua cai.
- Chay `:TSUpdate` hoac de Treesitter auto-install `markdown` va `markdown_inline`.
- Cai va login Claude Code/Codex CLI ngoai Neovim neu muon dung keymap AI.