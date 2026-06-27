# Neovim Keymaps

Ghi chu: trong config nay `leader` la phim `Space`.

## Mo Giao Dien Folder

| Phim | Tac dung |
| --- | --- |
| `Space v` | Bat/tat Neo-tree ben trai |
| `Space q` | Reveal file hien tai trong Neo-tree |

Trong Neo-tree:

| Phim | Tac dung |
| --- | --- |
| `Enter` | Mo file hoac folder |
| `a` | Tao file/folder |
| `d` | Xoa |
| `r` | Doi ten |
| `q` | Dong Neo-tree |

## Tim Kiem Kieu VS Code

| Phim | Tac dung |
| --- | --- |
| `Space ff` | Tim file |
| `Space fg` | Tim text trong project |
| `Space fb` | Tim buffer dang mo |
| `Space fh` | Tim help tag |

## Buffers Va Tab Bar

Trong Neovim, file dang mo thuong la `buffer`. Config nay co thanh bufferline o tren cung de nhin giong tab file cua VS Code.

| Phim | Tac dung |
| --- | --- |
| `Tab` | Chuyen sang buffer tiep theo |
| `Shift Tab` | Chuyen ve buffer truoc |
| `Space fb` | Tim buffer dang mo bang Telescope |
| `Space bp` | Pick buffer truc tiep tren bufferline |
| `Space x` | Dong buffer hien tai nhung giu layout/window |
| `Space X` | Force dong buffer hien tai |
| `Space bo` | Dong cac buffer khac, giu lai buffer hien tai |

Lenh Vim tuong duong:

| Lenh | Tac dung |
| --- | --- |
| `:ls` | Xem danh sach buffer |
| `:bnext` | Buffer tiep theo |
| `:bprev` | Buffer truoc |
| `:Bdelete` | Dong buffer hien tai, it bi vang khoi layout hon `:bd` |

## Session Va Project

Session luu buffer, tab, window layout va cwd theo project. Config nay tu luu
session khi thoat Neovim sau khi anh da mo file, nhung khong tu restore khi mo
Neovim de tranh mo nham workspace.

| Phim | Tac dung |
| --- | --- |
| `Space ss` | Restore session cua cwd hien tai |
| `Space sS` | Chon session de restore |
| `Space sl` | Restore session gan nhat |
| `Space sd` | Dung luu session cho lan hien tai |

## LSP: Di Chuyen Va Sua Code

| Phim | Tac dung |
| --- | --- |
| `K` | Xem hover/documentation |
| `gd` | Di toi definition |
| `gD` | Di toi declaration |
| `gi` | Di toi implementation |
| `gr` | Tim references |
| `Space rn` | Rename symbol |
| `Space ca` | Code action |
| `Space lf` | Format buffer bang LSP |
| `Space p` | Format buffer |
| `[d` | Diagnostic truoc |
| `]d` | Diagnostic tiep theo |
| `Space d` | Mo diagnostic popup |
| `Space ld` | Mo diagnostics cua workspace bang Trouble |
| `Space lD` | Mo diagnostics cua buffer hien tai bang Trouble |
| `Space ls` | Mo document symbols bang Trouble |
| `Space ll` | Mo definitions/references/implementations bang Trouble |
| `Space lq` | Mo quickfix list bang Trouble |
| `Space lL` | Mo location list bang Trouble |

## Completion

Trong insert mode:

| Phim | Tac dung |
| --- | --- |
| `Ctrl Space` | Goi menu autocomplete |
| `Ctrl j` | Chon item tiep theo |
| `Ctrl k` | Chon item truoc |
| `Tab` | Chon item tiep theo hoac nhay snippet |
| `Shift Tab` | Chon item truoc hoac lui snippet |
| `Enter` | Xac nhan completion |
| `Ctrl e` | Huy completion |
| `Ctrl b` | Cuon docs len |
| `Ctrl f` | Cuon docs xuong |

## Git Signs

| Phim | Tac dung |
| --- | --- |
| `Space gg` | Mo Git Graph |
| `Space gc` | Nhay cwd vao Git root cua file hien tai |
| `Space gw` | Xem cwd hien tai |
| `Space gs` | Mo Fugitive Git status |
| `Space gb` | Mo Fugitive Git blame |
| `Space gC` | Mo Fugitive Git commit |
| `Space gl` | Mo Git log ngan gon |
| `Space gd` | Mo Diffview cho thay doi hien tai |
| `Space gh` | Xem history cua file hien tai |
| `Space gH` | Xem history cua repo |
| `Space gq` | Dong Diffview |
| `]h` | Hunk tiep theo |
| `[h` | Hunk truoc |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hp` | Preview hunk |
| `Space hb` | Blame line |

Trong Fugitive status:

| Phim | Tac dung |
| --- | --- |
| `s` | Stage file/hunk duoi cursor |
| `u` | Unstage file/hunk duoi cursor |
| `cc` | Commit |
| `dv` | Mo vertical diff |
| `q` | Dong buffer |

Trong Git Graph:

| Phim | Tac dung |
| --- | --- |
| `Enter` | Chon commit de mo diff commit do |
| Chon 2 commit | Mo diff giua 2 commit neu plugin dang o che do range select |
| `q` | Dong buffer graph |

Neu dang o thu muc lon `a` nhung repo that nam trong `a/b/c`:

1. Mo mot file bat ky nam trong `a/b/c`.
2. Nhan `Space gc` de chuyen cwd vao Git root `c`.
3. Nhan `Space gg` de mo Git Graph cua repo `c`.

Lenh tuong duong neu muon go tay:

```vim
:cd a/b/c
:lua require("gitgraph").draw({}, { all = true, max_count = 5000 })
```

## Terminal

| Phim | Tac dung |
| --- | --- |
| `Space tt` | Bat/tat terminal ngang ben duoi |
| `Space tf` | Bat/tat floating terminal |
| `Space tv` | Bat/tat terminal doc ben phai |
| `2 Space tt` | Bat/tat terminal so 2 dang ngang |
| `3 Space tf` | Bat/tat terminal so 3 dang floating |
| `4 Space tv` | Bat/tat terminal so 4 dang doc ben phai |
| `Ctrl \` | Bat/tat terminal theo mapping mac dinh cua ToggleTerm |
| `Esc Esc` | Thoat terminal mode ve normal mode |

Trong terminal:

| Phim | Tac dung |
| --- | --- |
| `i` | Vao lai terminal insert mode neu dang o normal mode |
| `exit` | Dong shell hien tai |

Nen dung terminal trong Neovim cho:

| Viec | Vi du |
| --- | --- |
| Lenh ngan | `git status`, `git log --oneline` |
| Lenh dev vua phai | `npm test`, `python script.py` |
| Chay script trong project | `npm run lint`, `npm run build` |

Nen dung terminal ngoai cho:

| Viec | Ly do |
| --- | --- |
| Dev server log qua nhieu | Giam lag trong Neovim |
| Watcher spam output | Terminal buffer phai render lien tuc |
| TUI nang hoac chay rat lau | Tach khoi editor de de quan ly |

Neu terminal trong Neovim bi lag do log qua nhieu:

1. Nhan `Ctrl c` de dung lenh dang chay.
2. Nhan `Esc Esc` de ve normal mode.
3. Nhan `Space tt` de an terminal.
4. Chay lenh do bang terminal ngoai neu can.

## Images

Neovim khong render anh san nhu VS Code. Config nay dung WezTerm de preview anh trong terminal buffer, va co fallback mo bang app mac dinh cua Windows.

| Phim | Tac dung |
| --- | --- |
| `Space ip` | Preview image trong Neovim bang `wezterm imgcat` |
| `Space io` | Mo image bang app mac dinh cua Windows |

Cach dung:

1. Dat cursor len duong dan anh, vi du `assets/logo.png`.
2. Nhan `Space ip` de preview ngay trong Neovim.
3. Neu dang mo truc tiep file anh, nhan `Space ip` cung se preview file hien tai.
4. Nhan `Enter` trong preview terminal de thoat trang thai hold cua `wezterm imgcat`.
5. Nhan `Space io` neu muon mo anh bang app ngoai.

Ho tro cac dinh dang thong dung: `png`, `jpg`, `jpeg`, `gif`, `webp`, `svg`, `bmp`, `ico`, `avif`.

## Comment Va Edit

| Phim | Tac dung |
| --- | --- |
| `gcc` | Comment/uncomment dong hien tai |
| `gc` trong visual mode | Comment/uncomment vung chon |
| `ys{motion}{char}` | Them surround theo motion, vi du `ysiw"` |
| `S{char}` trong visual mode | Them surround cho vung chon |
| `ds{char}` | Xoa surround, vi du `ds"` |
| `cs{old}{new}` | Doi surround, vi du `cs"'` |
| `J` trong visual mode | Di chuyen dong dang chon xuong |
| `K` trong visual mode | Di chuyen dong dang chon len |
| `Space p` trong visual mode | Paste de len vung chon ma khong mat clipboard |

## Navigation Nang Cao

| Phim | Tac dung |
| --- | --- |
| `s` | Flash jump toi match nhanh |
| `Space S` | Flash Treesitter node |
| `af` / `if` | Chon around/inside function trong visual/operator mode |
| `ac` / `ic` | Chon around/inside class trong visual/operator mode |
| `]m` / `[m` | Nhay toi function tiep theo/truoc do |
| `]]` / `[[` | Nhay toi class tiep theo/truoc do |

## Debug JavaScript/TypeScript

| Phim | Tac dung |
| --- | --- |
| `Space db` | Toggle breakpoint |
| `Space dB` | Dat conditional breakpoint |
| `Space dL` | Dat log point |
| `Space dc` | Start/continue debug |
| `Space do` | Step over |
| `Space di` | Step into |
| `Space dO` | Step out |
| `Space dp` | Pause debug |
| `Space dt` | Terminate debug |
| `Space dl` | Chay lai cau hinh debug gan nhat |
| `Space dr` | Mo debug REPL |
| `Space du` | Bat/tat debug UI |
| `Space de` | Eval expression duoi cursor hoac visual selection |
| `Space dPm` | Debug Python method gan cursor |
| `Space dPc` | Debug Python class gan cursor |
| `Space dPs` | Debug Python visual selection |

Lua chon debug hien co:

| Lua chon | Tac dung |
| --- | --- |
| `Launch current file` | Chay file JS/TS hien tai bang Node debugger |
| `Attach to Node process` | Attach vao process Node dang chay voi inspect |
| `Launch Chrome against localhost` | Mo Chrome debug cho frontend localhost |
| Python launch entries | Chay file Python hien tai bang debugpy |

## Test JavaScript/TypeScript

Config nay dung Neotest cho Jest va Vitest.

| Phim | Tac dung |
| --- | --- |
| `Space nn` | Chay test gan cursor nhat |
| `Space nf` | Chay test file hien tai |
| `Space nA` | Chay tat ca test trong cwd |
| `Space nl` | Chay lai test gan nhat |
| `Space nd` | Debug test gan cursor nhat bang DAP |
| `Space ns` | Bat/tat test summary |
| `Space no` | Mo output cua test gan nhat |
| `Space nO` | Bat/tat output panel |
| `Space nx` | Dung test gan nhat |
| `Space nw` | Bat/tat watch test file hien tai |

## Lenh Hay Dung

| Lenh | Tac dung |
| --- | --- |
| `:Lazy` | Quan ly plugin |
| `:Mason` | Quan ly LSP/formatter/debugger |
| `:checkhealth` | Kiem tra suc khoe config |
| `:checkhealth config` | Kiem tra rieng bo config nay |
| `:NvimConfigCheck` | Alias de chay `:checkhealth config` |
| `:Neotree toggle left` | Bat/tat Neo-tree bang command |
| `:Git` | Mo Fugitive Git status |
| `:Git blame` | Mo blame cua file hien tai |
| `:DapContinue` | Start/continue debug session |
| `:DapToggleBreakpoint` | Toggle breakpoint |

## Workflow Co Ban

1. Mo terminal moi.
2. Chay `nvim .` trong thu muc project.
3. Nhan `Space ss` neu muon restore session cua project.
4. Nhan `Space v` de mo folder tree.
5. Nhan `Space ff` de tim file nhanh.
6. Nhan `Space fg` de search text trong project.
7. Trong file code, dung `gd`, `K`, `Space ca`, `Space rn`, `Space p`.
8. Nhan `Space tt` de mo terminal tich hop.
9. Trong file test, dung `Space nn` hoac `Space nf` de chay test.
10. Dung `:NvimConfigCheck` neu muon kiem tra may moi thieu gi.
11. Dung `:Mason` neu can cai them language server.
