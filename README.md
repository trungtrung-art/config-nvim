# Neovim Config

Personal Neovim configuration focused on frontend development, Git workflows,
LSP, formatting, Treesitter, Telescope, navigation, tests, debugging, session
restore, terminal usage, and cross-platform use.

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
Stylua, Prettier, Black, isort, gofumpt, and the JavaScript debug adapter.

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

## Sessions

Project sessions are managed by `persistence.nvim`.

- Sessions are saved automatically when Neovim exits after a real file has been
  opened.
- Sessions are not restored automatically, so opening a single file stays
  predictable.
- Session files live under Neovim's state directory, not in this repository.

Common keymaps:

- `Space ss` restores the session for the current working directory.
- `Space sS` opens a session picker.
- `Space sl` restores the last session.
- `Space sd` stops saving the current session.

Recommended project workflow:

```bash
cd path/to/project
nvim .
```

Then press `Space ss` if you want to restore the saved project layout.

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
:DapContinue
:DapToggleBreakpoint
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

## Debugging

JavaScript and TypeScript debugging is configured through `nvim-dap`,
`nvim-dap-ui`, and Mason's `js-debug-adapter`.

Supported debug entries:

- `Launch current file` for Node-based JS/TS files.
- `Attach to Node process` for processes started with Node inspect flags.
- `Launch Chrome against localhost` for frontend apps such as Vite or Next.js.

Common keymaps:

- `Space db` toggles a breakpoint.
- `Space dc` starts or continues a debug session.
- `Space du` toggles the debug UI.
- `Space dt` terminates the current session.

For attach debugging, start Node with an inspect flag first, for example:

```bash
node --inspect-brk app.js
```

## Testing

JavaScript and TypeScript test running is configured through Neotest with Jest
and Vitest adapters.

Supported project runners:

- Jest projects with `jest` installed or exposed through the project test
  script.
- Vitest projects with `vitest` installed.

Common keymaps:

- `Space nn` runs the nearest test.
- `Space nf` runs the current test file.
- `Space nA` runs all tests in the current working directory.
- `Space nl` runs the last test again.
- `Space nd` debugs the nearest test through DAP when the adapter supports it.
- `Space ns` toggles the test summary.
- `Space no` opens focused output for a test.
- `Space nO` toggles the output panel.

Recommended workflow:

```bash
cd path/to/project
nvim .
```

Open a test file, then press `Space nn` for the nearest test or `Space nf` for
the whole file.

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
- If JavaScript debugging fails after a fresh clone, run `:MasonToolsInstall`
  and confirm `js-debug-adapter` is installed in `:Mason`.
- If Neotest finds no JS/TS tests, confirm the project has `jest` or `vitest`
  installed and that the Treesitter JavaScript/TypeScript parsers are installed
  with `:TSUpdate`.
- If a restored session opens an old layout, start Neovim in the project root
  with `nvim .`, then use `Space ss` for that cwd or `Space sS` to pick another
  session.

## Notes

- `lazy-lock.json` is committed to keep plugin versions stable across machines.
- Local machine-specific settings should go in `lua/local.lua`, not in the
  shared config. Copy `lua/local.lua.example` to `lua/local.lua` when needed.
- `.editorconfig` and `.stylua.toml` keep formatting stable across machines.
