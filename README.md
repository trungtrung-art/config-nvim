# config-nvim

Day la bo Neovim config cua `trungtrung-art`.

No bat dau tu mot chuyen rat don gian: minh to mo ve Neovim. Ban dau chi la
muon thu xem mot editor trong terminal co gi hay, sau do thanh viec tu dung mot
bo config rieng de hoc, de toc mach, de code hang ngay, va de chia se cho ai
muon clone ve dung thu.

Config nay khong co y dinh lam mot framework lon. No la mot bo setup ca nhan,
co du nhung thu minh can: mo project, tim file, LSP, format, Git, terminal,
test, debug, Markdown, session, va mot loi mo nhanh cho Claude/Codex CLI.

## Dung Cho Ai

- Ban moi to mo ve Neovim va muon xem mot config that te duoc sap xep ra sao.
- Ban lam frontend/JavaScript/TypeScript va can LSP, format, test, debug.
- Ban dung Git nhieu va muon co status, blame, diff, log ngay trong Neovim.
- Ban muon mot config co the clone sang may moi roi kiem tra thieu gi bang mot lenh.
- Ban muon dung Claude hoac Codex CLI ngay trong terminal cua project.

## Cai Dat Nhanh

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

Neu Ubuntu khong co lenh `fd`, tao shim:

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

## Lan Dau Mo Neovim

Sau khi mo `nvim`, chay cac lenh nay:

```vim
:Lazy sync
:MasonToolsInstall
:TSUpdate
:NvimConfigCheck
```

Neu co loi, doc output cua `:NvimConfigCheck` truoc. Lenh nay se bao may dang
thieu Git, Node, Python, ripgrep, fd, Mason package, Treesitter parser, Claude,
Codex, hoac tool he dieu hanh nao.

## Thu Muc Chinh

| Duong dan               | Tac dung                                    |
| ----------------------- | ------------------------------------------- |
| `init.lua`              | Diem vao cua config, nap core va plugins    |
| `lua/core/options.lua`  | Option editor, shell, clipboard             |
| `lua/core/keymaps.lua`  | Keymap core nho                             |
| `lua/core/os.lua`       | Helper nhan dien Windows, WSL, macOS, Linux |
| `lua/core/open.lua`     | Mo file/anh bang OS hoac WezTerm            |
| `lua/core/health.lua`   | Lenh `:NvimConfigCheck`                     |
| `lua/health/config.lua` | Health check rieng cua config nay           |
| `lua/plugins/*.lua`     | Tat ca plugin va workflow chinh             |
| `KEYMAPS.md`            | Bang phim tat chi tiet hon                  |
| `NEXT_BATCHES.md`       | Trang thai batch va viec con lai            |
| `tmux/.tmux.conf`       | tmux config optional                        |

## Plugin Va Workflow

| Nhom           | Plugin / Tool                                                     | Tac dung                                                   |
| -------------- | ----------------------------------------------------------------- | ---------------------------------------------------------- |
| Plugin manager | `lazy.nvim`                                                       | Cai va quan ly plugin                                      |
| Theme          | `catppuccin`                                                      | Giao dien mau                                              |
| File tree      | `neo-tree.nvim`                                                   | Mo/cay thu muc ben trai                                    |
| Search         | `telescope.nvim`, `ripgrep`, `fd`                                 | Tim file, grep text, tim buffer                            |
| UI             | `lualine.nvim`, `bufferline.nvim`, `which-key.nvim`               | Statusline, buffer tabs, goi y phim                        |
| Completion     | `nvim-cmp`, `LuaSnip`                                             | Autocomplete va snippets                                   |
| LSP            | `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`            | Cai va chay language servers                               |
| Format         | `conform.nvim`                                                    | Format buffer bang Prettier, Stylua, Black, isort, gofumpt |
| Treesitter     | `nvim-treesitter`, `nvim-treesitter-textobjects`                  | Highlight va textobjects tot hon                           |
| Diagnostics    | `trouble.nvim`                                                    | Xem diagnostics/list loi ro rang                           |
| Git            | `vim-fugitive`, `gitsigns.nvim`, `diffview.nvim`, `gitgraph.nvim` | Git status, blame, hunk, diff, graph                       |
| Terminal       | `toggleterm.nvim`                                                 | Terminal ngang/doc/floating trong Neovim                   |
| Session        | `persistence.nvim`                                                | Luu/restore workspace theo project                         |
| Test           | `neotest`, `neotest-jest`, `neotest-vitest`                       | Chay Jest/Vitest                                           |
| Debug          | `nvim-dap`, `dap-ui`, `dap-python`, `dap-go`, `dap-vscode-js`     | Debug JS/TS, Python, Go                                    |
| Markdown       | `marksman`, Treesitter, Prettier                                  | Viet README/docs de hon                                    |
| AI CLI         | `claude`, `codex`                                                 | Mo Claude/Codex trong Git root cua project                 |
| Images         | `wezterm imgcat`                                                  | Preview anh trong terminal neu co WezTerm                  |
| tmux           | `vim-tmux-navigator`                                              | Di chuyen giua tmux pane va Neovim split                   |

## Language Servers Va Formatters

| Ngon ngu / file         | LSP                            | Formatter / Tool          |
| ----------------------- | ------------------------------ | ------------------------- |
| Lua                     | `lua_ls`                       | `stylua`                  |
| JavaScript / TypeScript | `ts_ls`                        | `prettier`                |
| React / TSX             | `ts_ls`                        | `prettier`                |
| HTML                    | `html`                         | `prettier`                |
| CSS / Tailwind          | `cssls`, `tailwindcss`         | `prettier`                |
| JSON                    | `jsonls`                       | `prettier`                |
| Markdown                | `marksman`                     | `prettier`                |
| Python                  | `pyright`                      | `isort`, `black`          |
| Go                      | `gopls` neu co `go` trong PATH | `gofumpt`                 |
| ESLint                  | `eslint`                       | code action / diagnostics |

## Bang Cu Phap / Phim Tat

`leader` la phim `Space`.

### Mo File Va Tim Kiem

| Phim       | Tac dung                            |
| ---------- | ----------------------------------- |
| `Space v`  | Bat/tat Neo-tree ben trai           |
| `Space q`  | Reveal file hien tai trong Neo-tree |
| `Space ff` | Tim file                            |
| `Space fg` | Tim text trong project              |
| `Space fb` | Tim buffer dang mo                  |
| `Space fh` | Tim help tag                        |

### Buffer

| Phim        | Tac dung                   |
| ----------- | -------------------------- |
| `Tab`       | Buffer tiep theo           |
| `Shift Tab` | Buffer truoc               |
| `Space bp`  | Pick buffer                |
| `Space x`   | Dong buffer hien tai       |
| `Space X`   | Force dong buffer hien tai |
| `Space bo`  | Dong cac buffer khac       |

### Session Va Project

| Phim       | Tac dung                          |
| ---------- | --------------------------------- |
| `Space ss` | Restore session cua cwd hien tai  |
| `Space sS` | Chon session de restore           |
| `Space sl` | Restore session gan nhat          |
| `Space sd` | Dung luu session cho lan hien tai |

### LSP Va Diagnostics

| Phim       | Tac dung                                       |
| ---------- | ---------------------------------------------- |
| `K`        | Hover/documentation                            |
| `gd`       | Di toi definition                              |
| `gD`       | Di toi declaration                             |
| `gi`       | Di toi implementation                          |
| `gr`       | Tim references                                 |
| `Space rn` | Rename symbol                                  |
| `Space ca` | Code action                                    |
| `Space lf` | Format buffer bang LSP/fallback                |
| `Space p`  | Format buffer                                  |
| `[d`       | Diagnostic truoc                               |
| `]d`       | Diagnostic tiep theo                           |
| `Space d`  | Diagnostic popup                               |
| `Space ld` | Trouble workspace diagnostics                  |
| `Space lD` | Trouble buffer diagnostics                     |
| `Space ls` | Trouble document symbols                       |
| `Space ll` | Trouble definitions/references/implementations |
| `Space lq` | Trouble quickfix                               |
| `Space lL` | Trouble location list                          |

### Completion

| Phim         | Tac dung                              |
| ------------ | ------------------------------------- |
| `Ctrl Space` | Goi autocomplete                      |
| `Ctrl j`     | Chon item tiep theo                   |
| `Ctrl k`     | Chon item truoc                       |
| `Tab`        | Chon item tiep theo hoac nhay snippet |
| `Shift Tab`  | Chon item truoc hoac lui snippet      |
| `Enter`      | Xac nhan completion                   |
| `Ctrl e`     | Huy completion                        |
| `Ctrl b`     | Cuon docs len                         |
| `Ctrl f`     | Cuon docs xuong                       |

### Git

| Phim       | Tac dung                                  |
| ---------- | ----------------------------------------- |
| `Space gg` | Mo Git Graph                              |
| `Space gc` | Chuyen cwd vao Git root cua file hien tai |
| `Space gw` | Xem cwd hien tai                          |
| `Space gs` | Fugitive Git status                       |
| `Space gb` | Fugitive Git blame                        |
| `Space gC` | Fugitive Git commit                       |
| `Space gl` | Git log ngan gon                          |
| `Space gd` | Diffview thay doi hien tai                |
| `Space gh` | History cua file hien tai                 |
| `Space gH` | History cua repo                          |
| `Space gq` | Dong Diffview                             |
| `]h`       | Hunk tiep theo                            |
| `[h`       | Hunk truoc                                |
| `Space hs` | Stage hunk                                |
| `Space hr` | Reset hunk                                |
| `Space hp` | Preview hunk                              |
| `Space hb` | Blame line                                |

### Terminal, Claude, Codex

| Phim         | Tac dung                                |
| ------------ | --------------------------------------- |
| `Space tt`   | Terminal ngang                          |
| `Space tf`   | Terminal floating                       |
| `Space tv`   | Terminal doc ben phai                   |
| `2 Space tt` | Terminal so 2 dang ngang                |
| `3 Space tf` | Terminal so 3 dang floating             |
| `4 Space tv` | Terminal so 4 dang doc                  |
| `Ctrl \`     | Toggle terminal mac dinh cua ToggleTerm |
| `Esc Esc`    | Thoat terminal mode ve normal mode      |
| `Space ac`   | Mo Claude CLI trong Git root            |
| `Space aC`   | Tiep tuc Claude CLI trong Git root      |
| `Space ax`   | Mo Codex CLI trong Git root             |
| `Space aX`   | Resume Codex CLI trong Git root         |

### Comment, Edit, Navigation

| Phim               | Tac dung                                      |
| ------------------ | --------------------------------------------- |
| `gcc`              | Comment/uncomment dong hien tai               |
| `gc` visual        | Comment/uncomment vung chon                   |
| `ys{motion}{char}` | Them surround                                 |
| `S{char}` visual   | Them surround cho vung chon                   |
| `ds{char}`         | Xoa surround                                  |
| `cs{old}{new}`     | Doi surround                                  |
| `J` visual         | Di chuyen dong xuong                          |
| `K` visual         | Di chuyen dong len                            |
| `Space p` visual   | Paste de len vung chon ma khong mat clipboard |
| `s`                | Flash jump                                    |
| `Space S`          | Flash Treesitter node                         |
| `af` / `if`        | Around/inside function                        |
| `ac` / `ic`        | Around/inside class                           |
| `]m` / `[m`        | Function tiep theo/truoc do                   |
| `]]` / `[[`        | Class tiep theo/truoc do                      |

### Images

| Phim       | Tac dung                                    |
| ---------- | ------------------------------------------- |
| `Space ip` | Preview image bang `wezterm imgcat`         |
| `Space io` | Mo image bang app mac dinh cua he dieu hanh |

### Debug

| Phim        | Tac dung                       |
| ----------- | ------------------------------ |
| `Space db`  | Toggle breakpoint              |
| `Space dB`  | Conditional breakpoint         |
| `Space dL`  | Log point                      |
| `Space dc`  | Start/continue debug           |
| `Space do`  | Step over                      |
| `Space di`  | Step into                      |
| `Space dO`  | Step out                       |
| `Space dp`  | Pause debug                    |
| `Space dt`  | Terminate debug                |
| `Space dl`  | Chay lai debug config gan nhat |
| `Space dr`  | Mo debug REPL                  |
| `Space du`  | Toggle debug UI                |
| `Space de`  | Eval expression                |
| `Space dPm` | Debug Python method gan cursor |
| `Space dPc` | Debug Python class gan cursor  |
| `Space dPs` | Debug Python visual selection  |
| `Space dGt` | Debug Go test gan cursor       |
| `Space dGl` | Debug lai Go test gan nhat     |

### Test JavaScript / TypeScript

| Phim       | Tac dung                        |
| ---------- | ------------------------------- |
| `Space nn` | Chay test gan cursor            |
| `Space nf` | Chay test file hien tai         |
| `Space nA` | Chay tat ca test trong cwd      |
| `Space nl` | Chay lai test gan nhat          |
| `Space nd` | Debug test gan cursor bang DAP  |
| `Space ns` | Toggle test summary             |
| `Space no` | Mo output test gan nhat         |
| `Space nO` | Toggle output panel             |
| `Space nx` | Dung test gan nhat              |
| `Space nw` | Toggle watch test file hien tai |

### Lenh Hay Dung

| Lenh                   | Tac dung                          |
| ---------------------- | --------------------------------- |
| `:Lazy`                | Quan ly plugin                    |
| `:Mason`               | Quan ly LSP/formatter/debugger    |
| `:MasonToolsInstall`   | Cai tool Mason thieu              |
| `:TSUpdate`            | Cap nhat Treesitter parsers       |
| `:ConformInfo`         | Xem formatter cua buffer          |
| `:Trouble diagnostics` | Mo diagnostics bang Trouble       |
| `:Git`                 | Fugitive Git status               |
| `:Git blame`           | Git blame                         |
| `:DapContinue`         | Start/continue debug              |
| `:DapToggleBreakpoint` | Toggle breakpoint                 |
| `:NvimConfigCheck`     | Kiem tra config tren may hien tai |

## Workflow Ngan

```bash
cd path/to/project
nvim .
```

Trong Neovim:

1. `Space v` de mo cay file.
2. `Space ff` de tim file.
3. `Space fg` de grep text.
4. `gd`, `K`, `Space ca`, `Space rn` de lam viec voi LSP.
5. `Space p` de format.
6. `Space gs` de xem Git status.
7. `Space tt` de mo terminal.
8. `Space nn` hoac `Space nf` de chay test.
9. `Space db`, `Space dc`, `Space du` de debug.
10. `Space ac` hoac `Space ax` neu muon goi Claude/Codex trong project.

## Ghi Chu

- `lazy-lock.json` duoc commit de giu version plugin on dinh.
- Cau hinh rieng tung may nen de trong `lua/local.lua`, khong commit len repo.
- `tmux` la optional, Windows native van dung tot voi ToggleTerm.
- Go tools chi duoc cai khi may co `go` trong PATH.
- Claude va Codex la optional CLI; config nay chi mo terminal dung thu muc, khong luu token hay API key.
