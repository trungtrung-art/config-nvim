# Neovim Config

Personal Neovim configuration focused on frontend development, Git workflows,
LSP, formatting, Treesitter, Telescope, terminal usage, and cross-platform use.

## Status

This config currently works on Windows native Neovim and is being hardened for
Windows/WSL, macOS, and Linux portability. tmux support is included but optional.

## Requirements

Install these tools before starting Neovim on a fresh machine:

- Neovim 0.11 or newer
- Git
- Node.js and npm
- Python 3
- ripgrep
- fd
- C compiler toolchain for Treesitter parsers
- unzip

Optional but recommended:

- tmux
- WezTerm

Mason installs the configured language servers and formatters on first run where
possible, including Lua, TypeScript, HTML, CSS, Tailwind, JSON, Python, ESLint,
Stylua, Prettier, Black, isort, and gofumpt.

## Install

### Windows native

Clone this repository into the standard Neovim config directory:

```powershell
git clone https://github.com/trungtrung-art/config-nvim.git $env:LOCALAPPDATA\nvim
```

### macOS or Linux

Clone this repository into the standard XDG config directory:

```bash
git clone https://github.com/trungtrung-art/config-nvim.git ~/.config/nvim
```

## tmux

This repository includes a tmux config at `tmux/.tmux.conf`.

On macOS, Linux, or WSL:

```bash
ln -s ~/.config/nvim/tmux/.tmux.conf ~/.tmux.conf
```

The tmux config uses `Ctrl-a` as the prefix and supports `Ctrl-h/j/k/l`
navigation between tmux panes and Neovim splits.

## First Run

Open Neovim and let lazy.nvim install plugins:

```bash
nvim
```

Then check health:

```vim
:checkhealth
```

Useful commands:

```vim
:Lazy
:Mason
:MasonToolsInstall
:TSUpdate
```

## Notes

- `lazy-lock.json` is committed to keep plugin versions stable across machines.
- Local machine-specific settings should go in `lua/local.lua`, not in the
  shared config. Copy `lua/local.lua.example` to `lua/local.lua` when needed.
- `.editorconfig` and `.stylua.toml` keep formatting stable across machines.
