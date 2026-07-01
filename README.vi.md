# config-nvim

[English](README.md)

Đây là bộ Neovim config của `trungtrung-art`.

Nó bắt đầu từ một chuyện rất đơn giản: mình tò mò về Neovim. Ban đầu chỉ là muốn thử xem một editor trong terminal có gì hay, sau đó thành việc tự dựng một bộ config riêng để học, để tọc mạch, để code hằng ngày, và để chia sẻ cho ai muốn clone về dùng thử.

Config này không có ý định làm một framework lớn. Nó là một bộ setup cá nhân, có đủ những thứ mình cần: mở project, tìm file, LSP, format, Git, terminal, test, debug, Markdown, session, và một lối mở nhanh cho Claude/Codex CLI.

## Dành Cho Ai

- Bạn mới tò mò về Neovim và muốn xem một config thực tế được sắp xếp ra sao.
- Bạn làm frontend/JavaScript/TypeScript và cần LSP, format, test, debug.
- Bạn dùng Git nhiều và muốn có status, blame, diff, log ngay trong Neovim.
- Bạn muốn một config có thể clone sang máy mới rồi kiểm tra thiếu gì bằng một lệnh.
- Bạn muốn dùng Claude hoặc Codex CLI ngay trong terminal của project.

## Cài Đặt Nhanh

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

Nếu Ubuntu không có lệnh `fd`, tạo shim:

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

## Lần Đầu Mở Neovim

Sau khi mở `nvim`, chạy các lệnh này:

```vim
:Lazy sync
:MasonToolsInstall
:TSUpdate
:NvimConfigCheck
```

Nếu có lỗi, đọc output của `:NvimConfigCheck` trước. Lệnh này sẽ báo máy đang thiếu Git, Node, Python, ripgrep, fd, Mason package, Treesitter parser, Claude, Codex, hoặc tool hệ điều hành nào.

## Thư Mục Chính

| Đường dẫn               | Tác dụng                                    |
| ----------------------- | ------------------------------------------- |
| `init.lua`              | Điểm vào của config, nạp core và plugins    |
| `lua/core/options.lua`  | Option editor, shell, clipboard             |
| `lua/core/keymaps.lua`  | Keymap core nhỏ                             |
| `lua/core/os.lua`       | Helper nhận diện Windows, WSL, macOS, Linux |
| `lua/core/open.lua`     | Mở file/ảnh bằng OS hoặc WezTerm            |
| `lua/core/health.lua`   | Lệnh `:NvimConfigCheck`                     |
| `lua/health/config.lua` | Health check riêng của config này           |
| `lua/plugins/*.lua`     | Tất cả plugin và workflow chính             |
| `KEYMAPS.md`            | Bảng phím tắt chi tiết hơn                  |
| `NEXT_BATCHES.md`       | Trạng thái batch và việc còn lại            |
| `tmux/.tmux.conf`       | tmux config optional                        |

## Plugin Và Workflow

| Nhóm           | Plugin / Tool                                                     | Tác dụng                                                   |
| -------------- | ----------------------------------------------------------------- | ---------------------------------------------------------- |
| Plugin manager | `lazy.nvim`                                                       | Cài và quản lý plugin                                      |
| Theme          | `catppuccin`                                                      | Giao diện màu                                              |
| File tree      | `neo-tree.nvim`                                                   | Mở/cây thư mục bên trái                                    |
| Search         | `telescope.nvim`, `ripgrep`, `fd`                                 | Tìm file, grep text, tìm buffer                            |
| UI             | `lualine.nvim`, `bufferline.nvim`, `which-key.nvim`               | Statusline, buffer tabs, gợi ý phím                        |
| Completion     | `nvim-cmp`, `LuaSnip`                                             | Autocomplete và snippets                                   |
| LSP            | `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`            | Cài và chạy language servers                               |
| Format         | `conform.nvim`                                                    | Format buffer bằng Prettier, Stylua, Black, isort, gofumpt |
| Treesitter     | `nvim-treesitter`, `nvim-treesitter-textobjects`                  | Highlight và textobjects tốt hơn                           |
| Diagnostics    | `trouble.nvim`                                                    | Xem diagnostics/list lỗi rõ ràng                           |
| Git            | `vim-fugitive`, `gitsigns.nvim`, `diffview.nvim`, `gitgraph.nvim` | Git status, blame, hunk, diff, graph                       |
| Terminal       | `toggleterm.nvim`                                                 | Terminal ngang/dọc/floating trong Neovim                   |
| Session        | `persistence.nvim`                                                | Lưu/restore workspace theo project                         |
| Test           | `neotest`, `neotest-jest`, `neotest-vitest`                       | Chạy Jest/Vitest                                           |
| Debug          | `nvim-dap`, `dap-ui`, `dap-python`, `dap-go`, `dap-vscode-js`     | Debug JS/TS, Python, Go                                    |
| Markdown       | `marksman`, Treesitter, Prettier                                  | Viết README/docs dễ hơn                                    |
| AI CLI         | `claude`, `codex`                                                 | Mở Claude/Codex trong Git root của project                 |
| Images         | `wezterm imgcat`                                                  | Preview ảnh trong terminal nếu có WezTerm                  |
| tmux           | `vim-tmux-navigator`                                              | Di chuyển giữa tmux pane và Neovim split                   |

## Language Servers Và Formatters

| Ngôn ngữ / file         | LSP                            | Formatter / Tool          |
| ----------------------- | ------------------------------ | ------------------------- |
| Lua                     | `lua_ls`                       | `stylua`                  |
| JavaScript / TypeScript | `ts_ls`                        | `prettier`                |
| React / TSX             | `ts_ls`                        | `prettier`                |
| HTML                    | `html`                         | `prettier`                |
| CSS / Tailwind          | `cssls`, `tailwindcss`         | `prettier`                |
| JSON                    | `jsonls`                       | `prettier`                |
| Markdown                | `marksman`                     | `prettier`                |
| Python                  | `pyright`                      | `isort`, `black`          |
| Go                      | `gopls` nếu có `go` trong PATH | `gofumpt`                 |
| ESLint                  | `eslint`                       | code action / diagnostics |

## Bảng Cú Pháp / Phím Tắt

`leader` là phím `Space`.

### Mở File Và Tìm Kiếm

| Phím       | Tác dụng                            |
| ---------- | ----------------------------------- |
| `Space v`  | Bật/tắt Neo-tree bên trái           |
| `Space q`  | Reveal file hiện tại trong Neo-tree |
| `Space ff` | Tìm file                            |
| `Space fg` | Tìm text trong project              |
| `Space fb` | Tìm buffer đang mở                  |
| `Space fh` | Tìm help tag                        |

### Buffer

| Phím        | Tác dụng                   |
| ----------- | -------------------------- |
| `Tab`       | Buffer tiếp theo           |
| `Shift Tab` | Buffer trước               |
| `Space bp`  | Pick buffer                |
| `Space x`   | Đóng buffer hiện tại       |
| `Space X`   | Force đóng buffer hiện tại |
| `Space bo`  | Đóng các buffer khác       |

### Session Và Project

| Phím       | Tác dụng                          |
| ---------- | --------------------------------- |
| `Space ss` | Restore session của cwd hiện tại  |
| `Space sS` | Chọn session để restore           |
| `Space sl` | Restore session gần nhất          |
| `Space sd` | Dừng lưu session cho lần hiện tại |

### LSP Và Diagnostics

| Phím       | Tác dụng                                       |
| ---------- | ---------------------------------------------- |
| `K`        | Hover/documentation                            |
| `gd`       | Đi tới definition                              |
| `gD`       | Đi tới declaration                             |
| `gi`       | Đi tới implementation                          |
| `gr`       | Tìm references                                 |
| `Space rn` | Rename symbol                                  |
| `Space ca` | Code action                                    |
| `Space lf` | Format buffer bằng LSP/fallback                |
| `Space p`  | Format buffer                                  |
| `[d`       | Diagnostic trước                               |
| `]d`       | Diagnostic tiếp theo                           |
| `Space d`  | Diagnostic popup                               |
| `Space ld` | Trouble workspace diagnostics                  |
| `Space lD` | Trouble buffer diagnostics                     |
| `Space ls` | Trouble document symbols                       |
| `Space ll` | Trouble definitions/references/implementations |
| `Space lq` | Trouble quickfix                               |
| `Space lL` | Trouble location list                          |

### Completion

| Phím         | Tác dụng                              |
| ------------ | ------------------------------------- |
| `Ctrl Space` | Gọi autocomplete                      |
| `Ctrl j`     | Chọn item tiếp theo                   |
| `Ctrl k`     | Chọn item trước                       |
| `Tab`        | Chọn item tiếp theo hoặc nhảy snippet |
| `Shift Tab`  | Chọn item trước hoặc lùi snippet      |
| `Enter`      | Xác nhận completion                   |
| `Ctrl e`     | Hủy completion                        |
| `Ctrl b`     | Cuộn docs lên                         |
| `Ctrl f`     | Cuộn docs xuống                       |

### Git

| Phím       | Tác dụng                                  |
| ---------- | ----------------------------------------- |
| `Space gg` | Mở Git Graph                              |
| `Space gc` | Chuyển cwd vào Git root của file hiện tại |
| `Space gw` | Xem cwd hiện tại                          |
| `Space gs` | Fugitive Git status                       |
| `Space gb` | Fugitive Git blame                        |
| `Space gC` | Fugitive Git commit                       |
| `Space gl` | Git log ngắn gọn                          |
| `Space gd` | Diffview thay đổi hiện tại                |
| `Space gh` | History của file hiện tại                 |
| `Space gH` | History của repo                          |
| `Space gq` | Đóng Diffview                             |
| `]h`       | Hunk tiếp theo                            |
| `[h`       | Hunk trước                                |
| `Space hs` | Stage hunk                                |
| `Space hr` | Reset hunk                                |
| `Space hp` | Preview hunk                              |
| `Space hb` | Blame line                                |

### Terminal, Claude, Codex

| Phím         | Tác dụng                                |
| ------------ | --------------------------------------- |
| `Space tt`   | Terminal ngang                          |
| `Space tf`   | Terminal floating                       |
| `Space tv`   | Terminal dọc bên phải                   |
| `2 Space tt` | Terminal số 2 dạng ngang                |
| `3 Space tf` | Terminal số 3 dạng floating             |
| `4 Space tv` | Terminal số 4 dạng dọc                  |
| `Ctrl \`     | Toggle terminal mặc định của ToggleTerm |
| `Esc Esc`    | Thoát terminal mode về normal mode      |
| `Space ac`   | Mở Claude CLI trong Git root            |
| `Space aC`   | Tiếp tục Claude CLI trong Git root      |
| `Space ax`   | Mở Codex CLI trong Git root             |
| `Space aX`   | Resume Codex CLI trong Git root         |

### Comment, Edit, Navigation

| Phím               | Tác dụng                                      |
| ------------------ | --------------------------------------------- |
| `gcc`              | Comment/uncomment dòng hiện tại               |
| `gc` visual        | Comment/uncomment vùng chọn                   |
| `ys{motion}{char}` | Thêm surround                                 |
| `S{char}` visual   | Thêm surround cho vùng chọn                   |
| `ds{char}`         | Xóa surround                                  |
| `cs{old}{new}`     | Đổi surround                                  |
| `J` visual         | Di chuyển dòng xuống                          |
| `K` visual         | Di chuyển dòng lên                            |
| `Space p` visual   | Paste đè lên vùng chọn mà không mất clipboard |
| `s`                | Flash jump                                    |
| `Space S`          | Flash Treesitter node                         |
| `af` / `if`        | Around/inside function                        |
| `ac` / `ic`        | Around/inside class                           |
| `]m` / `[m`        | Function tiếp theo/trước đó                   |
| `]]` / `[[`        | Class tiếp theo/trước đó                      |

### Images

| Phím       | Tác dụng                                    |
| ---------- | ------------------------------------------- |
| `Space ip` | Preview image bằng `wezterm imgcat`         |
| `Space io` | Mở image bằng app mặc định của hệ điều hành |

### Debug

| Phím        | Tác dụng                       |
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
| `Space dl`  | Chạy lại debug config gần nhất |
| `Space dr`  | Mở debug REPL                  |
| `Space du`  | Toggle debug UI                |
| `Space de`  | Eval expression                |
| `Space dPm` | Debug Python method gần cursor |
| `Space dPc` | Debug Python class gần cursor  |
| `Space dPs` | Debug Python visual selection  |
| `Space dGt` | Debug Go test gần cursor       |
| `Space dGl` | Debug lại Go test gần nhất     |

### Test JavaScript / TypeScript

| Phím       | Tác dụng                        |
| ---------- | ------------------------------- |
| `Space nn` | Chạy test gần cursor            |
| `Space nf` | Chạy test file hiện tại         |
| `Space nA` | Chạy tất cả test trong cwd      |
| `Space nl` | Chạy lại test gần nhất          |
| `Space nd` | Debug test gần cursor bằng DAP  |
| `Space ns` | Toggle test summary             |
| `Space no` | Mở output test gần nhất         |
| `Space nO` | Toggle output panel             |
| `Space nx` | Dừng test gần nhất              |
| `Space nw` | Toggle watch test file hiện tại |

### Lệnh Hay Dùng

| Lệnh                   | Tác dụng                          |
| ---------------------- | --------------------------------- |
| `:Lazy`                | Quản lý plugin                    |
| `:Mason`               | Quản lý LSP/formatter/debugger    |
| `:MasonToolsInstall`   | Cài tool Mason thiếu              |
| `:TSUpdate`            | Cập nhật Treesitter parsers       |
| `:ConformInfo`         | Xem formatter của buffer          |
| `:Trouble diagnostics` | Mở diagnostics bằng Trouble       |
| `:Git`                 | Fugitive Git status               |
| `:Git blame`           | Git blame                         |
| `:DapContinue`         | Start/continue debug              |
| `:DapToggleBreakpoint` | Toggle breakpoint                 |
| `:NvimConfigCheck`     | Kiểm tra config trên máy hiện tại |

## Workflow Ngắn

```bash
cd path/to/project
nvim .
```

Trong Neovim:

1. `Space v` để mở cây file.
2. `Space ff` để tìm file.
3. `Space fg` để grep text.
4. `gd`, `K`, `Space ca`, `Space rn` để làm việc với LSP.
5. `Space p` để format.
6. `Space gs` để xem Git status.
7. `Space tt` để mở terminal.
8. `Space nn` hoặc `Space nf` để chạy test.
9. `Space db`, `Space dc`, `Space du` để debug.
10. `Space ac` hoặc `Space ax` nếu muốn gọi Claude/Codex trong project.

## Ghi Chú

- `lazy-lock.json` được commit để giữ version plugin ổn định.
- Cấu hình riêng từng máy nên để trong `lua/local.lua`, không commit lên repo.
- `tmux` là optional, Windows native vẫn dùng tốt với ToggleTerm.
- Go tools chỉ được cài khi máy có `go` trong PATH.
- Claude và Codex là optional CLI; config này chỉ mở terminal đúng thư mục, không lưu token hay API key.
