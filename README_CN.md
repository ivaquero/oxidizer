# Oxidizer

[![CI](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/ivaquero/oxidizer)](https://github.com/ivaquero/oxidizer/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

统一你终端操作的简单 & 可扩展的 dotfile 管理工具（欢迎 PR 和 Fork！）

<p align="left">
<a href="README.md">English</a> |
<a href="https://github.com/ivaquero/oxidizer/blob/master/README_CN.md">简体中文</a>
</p>

![oxidizer](https://raw.githubusercontent.com/ivaquero/backup/main/docs/oxidizer.png)

## 1. 从这里开始

对 macOS / Linux (Intel)

```sh
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $OXIDIZER && bash $OXIDIZER/install.sh

# 自定义安装路径
export OXIDIZER=$HOME/oxidizer
```

- 对中国大陆用户，可设置 `BREW_CN` 变量来下载安装 Homebrew：

```sh
export BREW_CN=1
```

对 Windows

```powershell
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $env:OXIDIZER; . $env:OXIDIZER\install.ps1

# 自定义安装路径
$env:OXIDIZER = "$HOME\oxidizer"
```

> 对于 Cmder 用户，你需要删除`%CMDER_ROOT%\vendor\profile.ps1`的最后一行`Set-Item -Path function:\prompt -Value $Prompt -Options ReadOnly`中的`-Options ReadOnly`。

安装之后，您可以在`custom.sh`中个性化您的系统环境（请参考[defaults.sh](https://github.com/ivaquero/oxidizer/blob/master/defaults.sh)，通过一下命令打开

```sh
edf ox
```

可使用 `upox` 命令来更新 Oxidizer

## 2. Oxidizer 的主要目标

Oxidizer 起初主要为非管理员用户设计，用于快速搭建跨平台统一的工作环境，避免重复和繁琐的环境配置劳动，其具有特点

- 跨平台（主要基于 Rust 工具链）
- 最少依赖 & 最少安装
- 可扩展架构
- 统一接口 & 丝滑操作
- 超级快！（载入时间 < 1 秒）

### 2.1. CLI 工具替换

☑️ 表示默认安装

- coreutils
  - [x] 使用 [bat](https://github.com/sharkdp/bat) 替换 `cat`
  - [x] 使用 [lsd](https://github.com/Peltoche/lsd) 替换 `ls`
  - [ ] 使用 [uutils-coreutils](https://github.com/uutils/coreutils) 替换 `coreutils`
- non-coreutils
  - [x] 使用 [dust](https://github.com/bootandy/dust) 替换 `du`
  - [x] 使用 [fd](https://github.com/sharkdp/fd) 替换 `find`
  - [x] 使用 [ripgrep](https://github.com/BurntSushi/ripgrep) 替换 `grep`
  - [x] 使用 [sd](https://github.com/chmln/sd) 替换 `sed`
  - [x] 使用 [tealdeer](https://github.com/dbrgn/tealdeer) 替换 `tldr` 和 `man`
  - [x] 使用 [zoxide](https://github.com/ajeetdsouza/zoxide) 替换 `cd` 和 `z`
  - [ ] 使用 [hyperfine](https://github.com/sharkdp/hyperfine) 替换 `time`
  - [ ] 使用 [procs](https://github.com/dalance/procs) 替换 `ps`
  - [ ] 使用 [starship](https://github.com/starship/starship) 替换 `powerline10k` 和 `ohmyposh`
  - [ ] 使用 [tokei](https://github.com/XAMPPRocky/tokei) 替换 `cloc`
  - [ ] 使用 [tre](https://github.com/dduan/tre) 替换 `tree`

> `Nushell` 是一个 Rust 编写的全平台 Shell，但其目前不支持动态地址，而且其插件只支持 Rust 和 Python，而不是其内置的 Nu 语言。

### 2.2. TUI 工具替换

- [ ] 使用 [bottom](https://github.com/ClementTsang/bottom) 替换 `top` 和 `htop`
- [ ] 使用 [gitui](https://github.com/extrawurst/gitui) 替换 `lazygit`
- [ ] 使用 [yazi](https://github.com/sxyazi/yazi) 替换 `range`
- [ ] 使用 [helix](https://github.com/helix-editor/helix) 替换 `vim` （非平替）
- [ ] 使用 [zellij](https://github.com/zellij-org/zellij) 替换 `tmux`（目前不支持 Windows）

### 2.3. GUI 工具替换

- [ ] 使用 [WezTerm](https://github.com/wez/wezterm) 或 [alacritty](https://github.com/alacritty/alacritty) 替换 `iterm2` 和 `windows terminal`

> 更推荐 `WezTerm`，自带分屏器

### 2.4. 其他实用的 Rust 工具

- [x] [ouch](https://github.com/ouch-org/ouch)：终端无痛压缩 & 解压工具
- [ ] [pueue](https://github.com/Nukesor/pueue)：命令行并行任务管理器
- [ ] [kondo](https://github.com/tbillington/kondo)：项目依赖清理命令行工具
- [ ] [navi](https://github.com/denisidoro/navi)：交互式 cheatsheet 命令行
- [ ] [onefetch](https://github.com/o2sh/onefetch)：命令行 Git 信息工具

### 2.5. 插件总结

插件位于 [oxplugins](https://github.com/ivaquero/oxplugins)

> [OxPlugins-PowerShell](https://github.com/ivaquero/oxplugins-pwsh) 已停止维护。

|                       插件                        | Linux | macOS | Windows | 自动加载？ |
| :-----------------------------------------------: | :---: | :---: | :-----: | :--------: |
|     [Brew](https://github.com/Homebrew/brew)      |  ✅   |  ✅   |   ❌    |     ✅     |
| [Scoop](https://github.com/ScoopInstaller/Scoop)  |  ❌   |  ❌   |   ✅    |     ✅     |
|     [Pueue](https://github.com/Nukesor/pueue)     |  ✅   |  ✅   |   ✅    |     ✅     |
|                      System                       |  ✅¹  |  ✅   |   ✅    |     ✅     |
|                   File Utility                    |  ✅   |  ✅   |   ✅    |     ✅     |
|            [Git](https://git-scm.com/)            |  ✅   |  ✅   |   ✅    |            |
| [Bitwarden](https://github.com/bitwarden/clients) |  🕒   |  🕒   |   🕒    |            |
|    [Conan](https://github.com/conan-io/conan)     |  ✅   |  ✅   |   ✅    |            |
|      [Conda](https://github.com/conda/conda)      |  ✅   |  ✅   |   ✅    |            |
|    [Julia](https://github.com/JuliaLang/julia)    |  ✅   |  ✅   |   🚧    |            |
|   [Jupyter](https://github.com/jupyter/jupyter)   |  ✅   |  ✅   |   ✅    |            |
|      [Node](https://github.com/nodejs/node)       |  ✅   |  ✅   |   ✅    |            |
|     [Rust](https://github.com/rust-lang/rust)     |  ✅   |  ✅   |   ✅    |            |
|   [Espanso](https://github.com/espanso/espanso)   |  ✅   |  ✅   |   ✅    |            |
|        [TeXLive](https://tug.org/texlive/)        |  ✅   |  ✅   |   ✅    |            |
|   [VSCode](https://github.com/microsoft/vscode)   |  ✅   |  ✅   |   ✅    |            |
|                    Container²                     |  ✅   |  ✅   |   ✅    |            |
|                Formats（格式转换）                |  🕒   |  🕒   |   🕒    |            |
|               Network（代理与镜像）               |  🕒   |  🕒   |   🕒    |            |
|                      Weather                      |  🕒   |  🕒   |   🕒    |            |
|                Notes （Obsidian）                 |  🕒   |  🕒   |   🕒    |            |

✅：完整功能
🚧：部分功能
🕒：基础功能，有待补充
❌：不存在

> ¹：目前在 Linux 只提供 Debian 系的相关快捷操作
>
> ²: 仅支持 [Docker](https://docker.com/) 和 [Podman](https://github.com/containers/podman).

Oxidizer 通过 Homebrew 或 Scoop 管理包和软件，以绕过管理员权限的要求。

## 3. 文件管理

![design](https://raw.githubusercontent.com/ivaquero/backup/master/docs/design.drawio.png)

- `rff`
  - 通过 `source` 刷新
- `edf`
  - 通过 `$EDITOR` 编辑（默认：VSCode）
- `brf`
  - 通过 `bat`/`cat` 浏览文件
  - 文件夹：通过 `lsd`/`ls` 浏览
- `rdf` (reduce file)
  - 还原文件：在 `$OX_OXIDE` 中覆盖对应的 `$OX_ELEMENT` 文件配置
- `oxf` (oxidize file)
  - 氧化文件：在 `$OX_ELEMENT` 中覆盖对应的 `$OX_OXIDE` 文件配置
- `clzf` (catalyze file)
  - 催化文件：在 `$OX_OXYGEN` 中覆盖对应的 `$OX_ELEMENT` 文件配置
- `ppgf` (propagate file)
  - 传播文件：在 `$OX_OXYGEN` 中覆盖对应的 `$OX_OXIDE` 文件配置

例如，当你想编辑 `~/.zshrc`，键入 `edf zs`。

当你使用 `oxf zs`，`~/.zshrc` 会被复制并保存到 `$OX_BACKUP/shell` 文件夹。其中，`$OX_BACKUP` 是可以在 `$OXIDIZER/custom.sh` 中自定义的备份路径。通过 `edf ox` 即可轻松打开 `custom.sh` 文件。

下表罗列了每个配置文件的缩写：

|      来源      |  代号  |           对应文件           |
| :------------: | :----: | :--------------------------: |
|    oxidizer    |  `ox`  |         `custom.sh`          |
|      zsh       |  `zs`  |           `.zshrc`           |
|   powershell   |  `ps`  |        `Profile.ps1`         |
| linux (debian) |  `sc`  |   `/etc/apt/sources.list`    |
|    wezterm     |  `wz`  |        `wezterm.lua`         |
|     conda      |  `c`   |          `.condarc`          |
|      git       |  `g`   |         `.gitconfig`         |
|      git       |  `gi`  |         `.gitignore`         |
|     conan      |  `cn`  |         `conan.conf`         |
|     conan      | `cnr`  |        `remotes.json`        |
|     conan      | `cnd`  |      `profiles/default`      |
|    espanso     |  `es`  |        `default.yml`         |
|    espanso     | `esb`  |       `match/base.yml`       |
|    espanso     | `esx_` |       `match/packages`       |
|     julia      |  `jl`  |         `startup.jl`         |
|     julia      | `jlx`  |       `julia-pkgs.txt`       |
|     julia      | `jlp`  |        `Project.toml`        |
|     julia      | `jlm`  |       `Manifest.toml`        |
|    jupyter     |  `jn`  | `jupyter_notebook_config.py` |
|     latex      |  `tl`  |        `texlive-pkgs`        |
|      node      |  `nj`  |           `.npmrc`           |
|      node      | `njx`  |       `node-pkgs.txt`        |
|     pueue      |  `pu`  |         `pueue.yml`          |
|     pueue      | `pua`  |     `pueue_aliases.yml`      |
|     cargo      |  `cg`  |        `config.toml`         |
|     rustup     |  `rs`  |       `settings.toml`        |
|     vscode     |  `vs`  |       `settings.json`        |
|     vscode     | `vsk`  |      `keybindings.json`      |
|     vscode     | `vss_` |          `snippets`          |
|     vscode     | `vsx`  |      `vscode-pkgs.txt`       |
|     winget     |  `w`   |        `winget.json`         |
|     zellij     |  `zj`  |         `config.kdl`         |
|     zellij     | `zjl_` |          `layouts`           |

> `_` 表示文件夹

Oxidizer 使用 [ouch](https://github.com/ouch-org/ouch) 压缩或解压缩文件，提供 3 个快捷命令

- `zpf`：压缩
- `uzpf`：解压缩
- `lzpf`：显示压缩文件中的内容

## 4. 软件管理

- `back_*`
  - 文件：将配置文件保存至自定义文件夹 `$OX_BACKUP`
- `up_*`
  - 文件：根据自定义文件夹 `$OX_BACKUP` 中的配置文件安装
- `clean_*`
  - 文件：根据自定义文件夹 `$OX_BACKUP` 中的配置文件清理

`back_*` 和 `up_*` 适用于 `brew`，`scoop`，`conda`，`vscode`，`espanso`，`julia`，`texlive`，`node`；`clean_*` 适用于 `brew`，`conda`。

## 5. 包管理

Oxidizer 致力于为各个包管理器提供统一的接口，以减轻敲击和记忆负担。

|  后缀  |    操作     | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | gem `rb` | conan `cn` | tlmgr `tl` |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :------: | :--------: | :--------: |
|  `*h`  |    help     |    ✅    |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |    ✅    |     ✅     |     ✅     |
| `*cf`  |   config    |    ✅    |           |    ✅     |   ✅    |            |             |            |          |     ✅     |            |
| `*is`  |   install   |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |    ✅    |     ✅     |     ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |    ✅    |     ✅     |     ✅     |
| `*up`  |   update    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |    ✅    |     ✅     |     ✅     |
| `*ups` | update self |    ✅    |    ✅     |           |         |            |             |            |          |            |     ✅     |
| `*ls`  |    list     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |    ✅    |            |     ✅     |
| `*lv`  |   leaves    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |          |            |            |
| `*sc`  |   search    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |    ✅    |     ✅     |            |
| `*cl`  |    clean    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |     ✅     |    ✅    |            |            |
| `*if`  |    info     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |          |     ✅     |     ✅     |
| `*st`  |   status    |    ✅    |    ✅     |           |   ✅    |            |             |     ✅     |          |            |            |
| `*ck`  |    check    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      |            |    ✅    |            |     ✅     |
| `*pn`  |     pin     |    ✅    |    ✅     |           |         |            |             |     ✅     |          |            |            |
| `*upn` |    unpin    |    ✅    |    ✅     |           |         |            |             |     ✅     |          |            |            |
| `*dp`  |   depends   |    ✅    |    ✅     |    ✅     |         |     ✅     |             |     ✅     |    ✅    |     ✅     |            |
| `*rdp` |    needs    |          |           |    ✅     |         |            |             |     ✅     |          |            |            |
| `*xa`  |  add repo   |    ✅    |    ✅     |    ✅     |         |            |             |            |          |     ✅     |            |
| `*xrm` | remove repo |    ✅    |    ✅     |    ✅     |         |            |             |            |          |     ✅     |            |
| `*xls` |  list repo  |          |           |    ✅     |         |            |             |            |          |     ✅     |            |

特别地，Oxidizer 提供两组后缀为`p`的实验性函数，用于并行安装和下载软件包

- brew：`bisp`, `biscp`, `bupp`
- scoop：`sisp`, `supp`

例如，当需要安装 2 个及以上的包时，可以使用 `bisp [pkg1] [pkg1]` 代替 `bis [pkg1] [pkg1]`，进行并行下载安装。

同理，`biscp`, `bupp` 分别为 `bisc`, `bup` 的并行版本。

使用并行功能前，需要启动 pueue 服务

```sh
# All OS
pueued -d
# or macOS / Linux
bss pu
```

一些包管理器还有项目管理功能

| 后缀  |    操作     | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | gem `rb` | conan `cn` |
| :---: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :------: | :--------: |
| `*ii` | init/create |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |          |     ✅     |
| `*b`  |    build    |          |           |           |         |     ✅     |             |     ✅     |    ✅    |     ✅     |
| `*r`  |     run     |          |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |          |            |
| `*ed` |    edit     |    ✅    |           |           |         |            |             |            |          |            |
| `*ct` |     cat     |    ✅    |    ✅     |           |         |            |             |            |    ✅    |            |
| `*ln` |    link     |    ✅    |           |           |         |            |             |            |          |            |
| `*ts` |    test     |    ✅    |           |           |   ✅    |     ✅     |             |     ✅     |          |     ✅     |
| `*au` |    audit    |    ✅    |           |           |   ✅    |            |             |            |          |            |
| `*fx` |     fix     |    ✅    |           |           |   ✅    |     ✅     |             |            |          |            |
| `*pb` |   publish   |          |           |           |   ✅    |     ✅     |             |            |          |            |

部分快捷命令被包含在对应的系统扩展中

- `ox-macos` `oxpm`：自启动，包含 `mas`
- `ox-debians` `oxpd`：自启动，包含 `apt`
- `ox-windows` `oxpw`：自启动，包含 `winget`、`wsl`·

|  后缀  |  对应操作   | mas `m` | apt `a` | flatpak `f` | winget `w` | wsl `wl` |
| :----: | :---------: | :-----: | :-----: | :---------: | :--------: | :------: |
|  `*h`  |    help     |   ✅    |   ✅    |             |     ✅     |          |
| `*is`  |   install   |   ✅    |   ✅    |     ✅      |     ✅     |    ✅    |
| `*us`  |  uninstall  |   ✅    |   ✅    |     ✅      |     ✅     |          |
| `*up`  |   update    |   ✅    |   ✅    |             |     ✅     |          |
| `*ups` | update self |         |   ✅    |             |     ✅     |          |
| `*ls`  |    list     |         |   ✅    |     ✅      |     ✅     |    ✅    |
| `*lv`  |   leaves    |         |         |             |            |          |
| `*sc`  |   search    |   ✅    |   ✅    |             |            |          |
| `*cl`  |    clean    |         |   ✅    |             |            |          |
| `*if`  |    info     |   ✅    |   ✅    |             |     ✅     |          |
| `*st`  |   status    |   ✅    |         |             |            |          |
| `*ck`  |    check    |         |   ✅    |             |            |          |
| `*dp`  |   depends   |         |   ✅    |             |            |          |

### 5.1. Homebrew 管理

- `bris`：brew reinstall 重装
- `bup`：brew upgrade 更新

**前缀 `c` 是一个标志用来严格限制 brew 命令只针对的 casks 操作**

- `bisc`：安装 cask
- `brisc`：重装 cask
- `bupc`：升级 cask
- `bupg`：brew upgrade --greedy

- `brp`：适用于下载文件替换缓存中的 brew cask
  - `$1`：cask name
- `bmr`：using brew mirror 使用 brew 镜像
- `bmrq`：reset brew git source to official repositories 重置 brew 到官方源

### 5.2. Conda 环境管理

请注意，Conda 插件基于 `mamba` 和 `conda-tree` 包，需要预先安装

```sh
conda install -c conda-forge mamba conda-tree
```

除了上面**包管理**提及的 Conda 命令，Conda 插件还提供了 Conda 环境管理的快捷命令，均以 `ce` 开头

- `cerat`: reactivate environment, works live `ceat`
- `ceq`: quit environment (`q` is for `kill/quit`)
- `cecr`: create
- `cerm`: remove environment, works live `ceat` but won't remove `base` env
- `cels`: environment list
- `cedf`: compare packages between conda environments
- `cern`: renames an existing environment
- `cesd`: change environment's `conda-forge subdir`
  - `i`: for `osx-64` or `linux-64` or `win-64`
  - `a`: for `osx-arm64` or `linux-aarch64` or `win-arm64`
  - `p`: for `ppc64le`
  - `s`: for `linux-s390x`
- `ceep`: export environment

## 6. 项目管理

### 6.1. Git

- [x] `gclhs`：删除提交历史

## 7. 更多阅读

- [更多用法](https://github.com/ivaquero/oxidizer/blob/master/docs/advanced_cn.md)

## 8. 致谢

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 9. 许可

这个项目在 GPL-v3 许可下发布
