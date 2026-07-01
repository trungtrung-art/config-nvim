# config-nvim

[Tiếng Việt](README.vi.md)

This is the Neovim config of `trungtrung-art`.

It started from a simple curiosity: I wanted to understand Neovim. At first, it was just about seeing what a terminal editor could do. Then it became a personal config for learning, tinkering, daily coding, and sharing with anyone who wants to clone it and try it.

This config is not trying to be a big framework. It is a personal setup with the things I actually use: project navigation, file search, LSP, formatting, Git, terminal, tests, debugging, Markdown, sessions, and quick project terminals for Claude/Codex CLI.

## Who This Is For

- You are curious about Neovim and want to see how a practical config is built.
- You write frontend, JavaScript, or TypeScript and want LSP, formatting, tests, and debugging.
- You use Git often and want status, blame, diff, and logs inside Neovim.
- You want a config that can be cloned onto a new machine and checked with one command.
- You want Claude or Codex CLI available inside the current project terminal.

## Quick Install

### Windows

```powershell
winget install Neovim.Neovim Git.Git OpenJS.NodeJS Python.Python.3.12 BurntSushi.ripgrep.MSVC sharkdp.fd wez.wezterm LLVM.LLVM
git clone https://github.com/trungtrung-art/config-nvim.git $env:LOCALAPPDATA\nvim
nvim
```

### WSL / Linux

```bash
sudo apt update
sudo apt install -y git curl unzip build-essential ripgrep fd-find nodejs npm python3 python3-pip tmux
git clone https://github.com/trungtrung-art/config-nvim.git ~/.config/nvim
nvim
```

If Ubuntu does not provide an `fd` command, create a small shim:

```bash
mkdir -p ~/.local/bin
ln -s "$(command -v fdfind)" ~/.local/bin/fd
```

### macOS

```bash
brew install neovim git node python ripgrep fd tmux unzip
git clone https://github.com/trungtrung-art/config-nvim.git ~/.config/nvim
nvim
```

## First Run

After opening `nvim`, run:

```vim
:Lazy sync
:MasonToolsInstall
:TSUpdate
:NvimConfigCheck
```

If something fails, read `:NvimConfigCheck` first. It reports missing tools such as Git, Node, Python, ripgrep, fd, Mason packages, Treesitter parsers, Claude, Codex, or operating-system helpers.

## Main Files

| Path                    | Purpose                                      |
| ----------------------- | -------------------------------------------- |
| `init.lua`              | Config entry point, loads core and plugins   |
| `lua/core/options.lua`  | Editor options, shell, clipboard             |
| `lua/core/keymaps.lua`  | Small core keymaps                           |
| `lua/core/os.lua`       | Windows, WSL, macOS, Linux detection helpers |
| `lua/core/open.lua`     | Open files/images through the OS or WezTerm  |
| `lua/core/health.lua`   | Defines `:NvimConfigCheck`                   |
| `lua/health/config.lua` | Custom health checks for this config         |
| `lua/plugins/*.lua`     | All plugin and workflow definitions          |
| `KEYMAPS.md`            | More detailed keymap reference               |
| `NEXT_BATCHES.md`       | Batch status and remaining notes             |
| `tmux/.tmux.conf`       | Optional tmux config                         |

## Plugins And Workflows

| Group          | Plugin / Tool                                                     | Purpose                                               |
| -------------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
| Plugin manager | `lazy.nvim`                                                       | Install and manage plugins                            |
| Theme          | `catppuccin`                                                      | Color theme                                           |
| File tree      | `neo-tree.nvim`                                                   | Left-side project tree                                |
| Search         | `telescope.nvim`, `ripgrep`, `fd`                                 | Find files, grep text, find buffers                   |
| UI             | `lualine.nvim`, `bufferline.nvim`, `which-key.nvim`               | Statusline, buffer tabs, key hints                    |
| Completion     | `nvim-cmp`, `LuaSnip`                                             | Completion and snippets                               |
| LSP            | `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`            | Install and run language servers                      |
| Format         | `conform.nvim`                                                    | Format with Prettier, Stylua, Black, isort, gofumpt   |
| Treesitter     | `nvim-treesitter`, `nvim-treesitter-textobjects`                  | Better highlighting and textobjects                   |
| Diagnostics    | `trouble.nvim`                                                    | Clear diagnostics and list views                      |
| Git            | `vim-fugitive`, `gitsigns.nvim`, `diffview.nvim`, `gitgraph.nvim` | Git status, blame, hunks, diffs, graph                |
| Terminal       | `toggleterm.nvim`                                                 | Horizontal, vertical, and floating terminals          |
| Session        | `persistence.nvim`                                                | Save and restore project workspaces                   |
| Test           | `neotest`, `neotest-jest`, `neotest-vitest`                       | Run Jest and Vitest                                   |
| Debug          | `nvim-dap`, `dap-ui`, `dap-python`, `dap-go`, `dap-vscode-js`     | Debug JS/TS, Python, Go                               |
| Markdown       | `marksman`, Treesitter, Prettier                                  | Better README and docs editing                        |
| AI CLI         | `claude`, `codex`                                                 | Open Claude/Codex inside the current Git project root |
| Images         | `wezterm imgcat`                                                  | Preview images in terminal when WezTerm is available  |
| tmux           | `vim-tmux-navigator`                                              | Move between tmux panes and Neovim splits             |

## Language Servers And Formatters

| Language / file         | LSP                            | Formatter / Tool         |
| ----------------------- | ------------------------------ | ------------------------ |
| Lua                     | `lua_ls`                       | `stylua`                 |
| JavaScript / TypeScript | `ts_ls`                        | `prettier`               |
| React / TSX             | `ts_ls`                        | `prettier`               |
| HTML                    | `html`                         | `prettier`               |
| CSS / Tailwind          | `cssls`, `tailwindcss`         | `prettier`               |
| JSON                    | `jsonls`                       | `prettier`               |
| Markdown                | `marksman`                     | `prettier`               |
| Python                  | `pyright`                      | `isort`, `black`         |
| Go                      | `gopls` if `go` exists in PATH | `gofumpt`                |
| ESLint                  | `eslint`                       | code actions/diagnostics |

## Syntax / Keymap Reference

`leader` is `Space`.

### Files And Search

| Key        | Action                          |
| ---------- | ------------------------------- |
| `Space v`  | Toggle left Neo-tree            |
| `Space q`  | Reveal current file in Neo-tree |
| `Space ff` | Find file                       |
| `Space fg` | Search text in project          |
| `Space fb` | Find open buffer                |
| `Space fh` | Find help tag                   |

### Buffers

| Key         | Action               |
| ----------- | -------------------- |
| `Tab`       | Next buffer          |
| `Shift Tab` | Previous buffer      |
| `Space bp`  | Pick buffer          |
| `Space x`   | Close current buffer |
| `Space X`   | Force close buffer   |
| `Space bo`  | Close other buffers  |

### Sessions And Project

| Key        | Action                          |
| ---------- | ------------------------------- |
| `Space ss` | Restore session for current cwd |
| `Space sS` | Pick a session to restore       |
| `Space sl` | Restore last session            |
| `Space sd` | Stop saving this session        |

### LSP And Diagnostics

| Key        | Action                                         |
| ---------- | ---------------------------------------------- |
| `K`        | Hover/documentation                            |
| `gd`       | Go to definition                               |
| `gD`       | Go to declaration                              |
| `gi`       | Go to implementation                           |
| `gr`       | Find references                                |
| `Space rn` | Rename symbol                                  |
| `Space ca` | Code action                                    |
| `Space lf` | Format buffer with LSP/fallback                |
| `Space p`  | Format buffer                                  |
| `[d`       | Previous diagnostic                            |
| `]d`       | Next diagnostic                                |
| `Space d`  | Diagnostic popup                               |
| `Space ld` | Trouble workspace diagnostics                  |
| `Space lD` | Trouble buffer diagnostics                     |
| `Space ls` | Trouble document symbols                       |
| `Space ll` | Trouble definitions/references/implementations |
| `Space lq` | Trouble quickfix                               |
| `Space lL` | Trouble location list                          |

### Completion

| Key          | Action                            |
| ------------ | --------------------------------- |
| `Ctrl Space` | Trigger completion                |
| `Ctrl j`     | Select next item                  |
| `Ctrl k`     | Select previous item              |
| `Tab`        | Select next item or jump snippet  |
| `Shift Tab`  | Select previous item or jump back |
| `Enter`      | Confirm completion                |
| `Ctrl e`     | Abort completion                  |
| `Ctrl b`     | Scroll docs up                    |
| `Ctrl f`     | Scroll docs down                  |

### Git

| Key        | Action                                |
| ---------- | ------------------------------------- |
| `Space gg` | Open Git Graph                        |
| `Space gc` | Change cwd to current file's Git root |
| `Space gw` | Show current cwd                      |
| `Space gs` | Fugitive Git status                   |
| `Space gb` | Fugitive Git blame                    |
| `Space gC` | Fugitive Git commit                   |
| `Space gl` | Compact Git log                       |
| `Space gd` | Diffview current changes              |
| `Space gh` | Current file history                  |
| `Space gH` | Repository history                    |
| `Space gq` | Close Diffview                        |
| `]h`       | Next hunk                             |
| `[h`       | Previous hunk                         |
| `Space hs` | Stage hunk                            |
| `Space hr` | Reset hunk                            |
| `Space hp` | Preview hunk                          |
| `Space hb` | Blame line                            |

### Terminal, Claude, Codex

| Key          | Action                             |
| ------------ | ---------------------------------- |
| `Space tt`   | Horizontal terminal                |
| `Space tf`   | Floating terminal                  |
| `Space tv`   | Right vertical terminal            |
| `2 Space tt` | Terminal number 2, horizontal      |
| `3 Space tf` | Terminal number 3, floating        |
| `4 Space tv` | Terminal number 4, vertical        |
| `Ctrl \`     | Toggle ToggleTerm default terminal |
| `Esc Esc`    | Leave terminal mode                |
| `Space ac`   | Open Claude CLI in Git root        |
| `Space aC`   | Continue Claude CLI in Git root    |
| `Space ax`   | Open Codex CLI in Git root         |
| `Space aX`   | Resume Codex CLI in Git root       |

### Comment, Edit, Navigation

| Key                | Action                                       |
| ------------------ | -------------------------------------------- |
| `gcc`              | Comment/uncomment current line               |
| `gc` visual        | Comment/uncomment selection                  |
| `ys{motion}{char}` | Add surround                                 |
| `S{char}` visual   | Add surround to selection                    |
| `ds{char}`         | Delete surround                              |
| `cs{old}{new}`     | Change surround                              |
| `J` visual         | Move selected lines down                     |
| `K` visual         | Move selected lines up                       |
| `Space p` visual   | Paste over selection without losing register |
| `s`                | Flash jump                                   |
| `Space S`          | Flash Treesitter node                        |
| `af` / `if`        | Around/inside function                       |
| `ac` / `ic`        | Around/inside class                          |
| `]m` / `[m`        | Next/previous function                       |
| `]]` / `[[`        | Next/previous class                          |

### Images

| Key        | Action                              |
| ---------- | ----------------------------------- |
| `Space ip` | Preview image with `wezterm imgcat` |
| `Space io` | Open image with the OS default app  |

### Debug

| Key         | Action                        |
| ----------- | ----------------------------- |
| `Space db`  | Toggle breakpoint             |
| `Space dB`  | Conditional breakpoint        |
| `Space dL`  | Log point                     |
| `Space dc`  | Start/continue debug          |
| `Space do`  | Step over                     |
| `Space di`  | Step into                     |
| `Space dO`  | Step out                      |
| `Space dp`  | Pause debug                   |
| `Space dt`  | Terminate debug               |
| `Space dl`  | Rerun last debug config       |
| `Space dr`  | Open debug REPL               |
| `Space du`  | Toggle debug UI               |
| `Space de`  | Evaluate expression           |
| `Space dPm` | Debug nearest Python method   |
| `Space dPc` | Debug nearest Python class    |
| `Space dPs` | Debug Python visual selection |
| `Space dGt` | Debug nearest Go test         |
| `Space dGl` | Debug last Go test again      |

### JavaScript / TypeScript Tests

| Key        | Action                        |
| ---------- | ----------------------------- |
| `Space nn` | Run nearest test              |
| `Space nf` | Run current test file         |
| `Space nA` | Run all tests in cwd          |
| `Space nl` | Run last test again           |
| `Space nd` | Debug nearest test with DAP   |
| `Space ns` | Toggle test summary           |
| `Space no` | Open nearest test output      |
| `Space nO` | Toggle output panel           |
| `Space nx` | Stop nearest test             |
| `Space nw` | Toggle watch for current file |

### Useful Commands

| Command                | Action                            |
| ---------------------- | --------------------------------- |
| `:Lazy`                | Manage plugins                    |
| `:Mason`               | Manage LSP/formatters/debuggers   |
| `:MasonToolsInstall`   | Install missing Mason tools       |
| `:TSUpdate`            | Update Treesitter parsers         |
| `:ConformInfo`         | Inspect formatter for buffer      |
| `:Trouble diagnostics` | Open diagnostics in Trouble       |
| `:Git`                 | Fugitive Git status               |
| `:Git blame`           | Git blame                         |
| `:DapContinue`         | Start/continue debug              |
| `:DapToggleBreakpoint` | Toggle breakpoint                 |
| `:NvimConfigCheck`     | Check this config on this machine |

## Short Workflow

```bash
cd path/to/project
nvim .
```

Inside Neovim:

1. `Space v` opens the file tree.
2. `Space ff` finds files.
3. `Space fg` greps project text.
4. `gd`, `K`, `Space ca`, `Space rn` use LSP.
5. `Space p` formats.
6. `Space gs` opens Git status.
7. `Space tt` opens a terminal.
8. `Space nn` or `Space nf` runs tests.
9. `Space db`, `Space dc`, `Space du` debug.
10. `Space ac` or `Space ax` opens Claude/Codex in the project.

## Notes

- `lazy-lock.json` is committed to keep plugin versions stable.
- Machine-specific config should go in `lua/local.lua` and should not be committed.
- `tmux` is optional. Windows native works fine with ToggleTerm.
- Go tools are installed only when `go` exists in PATH.
- Claude and Codex are optional CLIs. This config only opens the right terminal directory; it does not store tokens or API keys.
