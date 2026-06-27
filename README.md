# Neovim Config

Personal Neovim configuration focused on frontend development, Git workflows,
LSP, formatting, Treesitter, Telescope, navigation, terminal usage, and
cross-platform use.

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

Install dependencies with `winget`:

```powershell
winget install Neovim.Neovim Git.Git OpenJS.NodeJS Python.Python.3.12 BurntSushi.ripgrep.MSVC sharkdp.fd wez.wezterm
```

Install a C compiler for Treesitter parsers. LLVM is a reasonable default:

```powershell
winget install LLVM.LLVM
```

Clone this repository into the standard Windows Neovim config directory:

```powershell
git clone https://github.com/trungtrung-art/config-nvim.git $env:LOCALAPPDATA\nvim
```

### WSL or Ubuntu Linux

Install dependencies:

```bash
sudo apt update
sudo apt install -y git curl unzip build-essential ripgrep fd-find nodejs npm python3 python3-pip tmux
```

Ubuntu names `fd` as `fdfind`. Create a local shim if `fd` is missing:

```bash
mkdir -p ~/.local/bin
ln -s "$(command -v fdfind)" ~/.local/bin/fd
```

Make sure `~/.local/bin` is in `PATH`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

Install Neovim 0.11 or newer from the official release, a PPA, or another
package source. Then clone this repository:

```bash
git clone https://github.com/trungtrung-art/config-nvim.git ~/.config/nvim
```

Optional WSL clipboard support:

```bash
curl -L -o /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
unzip /tmp/win32yank.zip -d ~/.local/bin
chmod +x ~/.local/bin/win32yank.exe
```

### macOS

Install dependencies with Homebrew:

```bash
brew install neovim git node python ripgrep fd tmux unzip
```

Install Apple command line tools if Treesitter parsers fail to build:

```bash
xcode-select --install
```

Clone this repository into the standard XDG Neovim config directory:

```bash
git clone https://github.com/trungtrung-art/config-nvim.git ~/.config/nvim
```

### Existing config backup

If the target config directory already exists, back it up before cloning:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

On Windows:

```powershell
$nvimConfig = Join-Path $env:LOCALAPPDATA "nvim"
Rename-Item $nvimConfig "$nvimConfig.backup"
```

## tmux

This repository includes a tmux config at `tmux/.tmux.conf`.

On macOS, Linux, or WSL:

```bash
ln -s ~/.config/nvim/tmux/.tmux.conf ~/.tmux.conf
```

The tmux config uses `Ctrl-a` as the prefix and supports `Ctrl-h/j/k/l`
navigation between tmux panes and Neovim splits.

## Cross-platform behavior

The config includes lightweight OS detection in `lua/core/os.lua`.

- Windows native prefers PowerShell Core (`pwsh`) when available, then Windows
  PowerShell.
- WSL uses `win32yank.exe` for clipboard integration when it is installed.
- Image opening uses OS-specific open commands when available:
  - Windows: `cmd.exe /c start`
  - WSL: `wslview` or `explorer.exe`
  - macOS: `open`
  - Linux: `xdg-open`
- Inline image preview uses WezTerm `imgcat` when the `wezterm` CLI is
  available, otherwise it opens the image with the operating system.

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
:ConformInfo
:Trouble diagnostics
:Git
:Git blame
```

Recommended first-run checklist:

```vim
:Lazy sync
:MasonToolsInstall
:TSUpdate
:ConformInfo
:checkhealth
```

Restart Neovim after the first install pass so all language servers, formatters,
and Treesitter parsers are loaded from a clean session.

## Troubleshooting

- If Telescope live grep fails, install `ripgrep`.
- If Telescope find files is slow or missing results, install `fd`.
- If Treesitter parser installation fails, install a C compiler toolchain.
- If formatting does nothing, open `:ConformInfo` and confirm the formatter is
  available. Then open `:Mason` and confirm the formatter is installed.
- If clipboard does not work in WSL, install `win32yank.exe` and restart
  Neovim.
- If diagnostics feel noisy inline, use `Space ld` or `Space lD` to inspect
  them in Trouble.
- Use `s` for Flash jump, `ys`/`ds`/`cs` for surround edits, and `af`/`if` or
  `ac`/`ic` for Treesitter textobjects.
- Use `Space gs` for Git status, `Space gb` for file blame, and `Space gl` for
  a compact Git log inside Neovim.

## Notes

- `lazy-lock.json` is committed to keep plugin versions stable across machines.
- Local machine-specific settings should go in `lua/local.lua`, not in the
  shared config. Copy `lua/local.lua.example` to `lua/local.lua` when needed.
- `.editorconfig` and `.stylua.toml` keep formatting stable across machines.
