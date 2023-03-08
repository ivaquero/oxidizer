# Oxidizer

[![CI](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/ivaquero/oxidizer)](https://github.com/ivaquero/oxidizer/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

基于 Rust 工具链的简单 & 可扩展 dotfile 管理方案（欢迎 PR 和 Fork）

<p align="left">
<a href="README.md">English</a> |
<a href="https://github.com/ivaquero/oxidizer/blob/master/README_CN.md">简体中文</a>
</p>

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

安装之后，您可以在`custom.sh`或`custom.ps1`中个性化您的系统环境（请参考[defaults.sh](https://github.com/ivaquero/oxidizer/blob/master/defaults.sh)或[defaults.ps1](https://github.com/ivaquero/oxidizer/blob/master/defaults.ps1)），通过一下命令打开

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
  - [x] 使用 `uutils-coreutils` 替换 `coreutils`
  - [x] 使用 `bat` 替换 `cat`
  - [x] 使用 `dust` 替换 `du`
  - [x] 使用 `lsd` 替换 `ls`
- non-coreutils
  - [x] 使用 `hyperfine` 替换 `time`
  - [x] 使用 `ripgrep` 替换 `grep`
  - [x] 使用 `sd` 替换 `sed`
  - [x] 使用 `tealdeer` 替换 `tldr` 和 `man`
  - [x] 使用 `tre` 替换 `tree`
  - [x] 使用 `zoxide` 替换 `cd` 和 `z`
  - [ ] 使用 `fd` 替换 `find`
  - [ ] 使用 `tokei` 替换 `cloc`
  - [ ] 使用 `starship` 替换 `powerline10k` 和 `ohmyposh`

> `Nushell` 是一个 Rust 编写的全平台 Shell，但其目前不支持动态地址，而且其插件只支持 Rust 和 Python，而不是其内置的 Nu 语言。

### 2.2. TUI 工具替换

- [x] 使用 `gitui` 替换 `lazygit`
- [x] 使用 `bottom` 替换 `top` 和 `htop`
- [ ] 使用 `broot` 替换 `ranger`
- [ ] 使用 `helix` 替换 `neovim`
- [ ] 使用 `navi`：替换 `cheat.sh`
- [ ] 使用 `zellij` 替换 `tmux`（目前不支持 Windows）

### 2.3. GUI 工具替换

- [ ] 使用 `wezTerm` 或 `alacritty` 替换 `iterm2` 和 `windows terminal`

### 2.4. 其他实用的 Rust 工具

- [x] `onefetch`：命令行 Git 信息工具
- [x] `ouch`：终端无痛压缩&解压工具
- [x] `pueue`：命令行并行任务管理器
- [ ] `espanso`：输入法扩展器（推荐尝试）

### 2.5. 插件总结

|                       插件                        | Linux | macOS | Windows | 自动加载？ |
| :-----------------------------------------------: | :---: | :---: | :-----: | :--------: |
|     [Brew](https://github.com/Homebrew/brew)      |   ✅   |   ✅   |    ❌    |     ✅      |
| [Scoop](https://github.com/ScoopInstaller/Scoop)  |   ❌   |   ❌   |    ✅    |     ✅      |
|     [Pueue](https://github.com/Nukesor/pueue)     |   ✅   |   ✅   |    ✅    |     ✅      |
|                      System                       |  ✅¹   |   ✅   |    ✅    |     ✅      |
|                      Utility                      |   ✅   |   ✅   |    ✅    |     ✅      |
|            [Git](https://git-scm.com/)            |   ✅   |   ✅   |    ✅    |            |
| [Bitwarden](https://github.com/bitwarden/clients) |   🕒   |   🕒   |    🕒    |            |
|    [Conan](https://github.com/conan-io/conan)     |   ✅   |   ✅   |    ✅    |            |
|      [Conda](https://github.com/conda/conda)      |   ✅   |   ✅   |    ✅    |            |
|    [Julia](https://github.com/JuliaLang/julia)    |   ✅   |   ✅   |    🚧    |            |
|   [Jupyter](https://github.com/jupyter/jupyter)   |   ✅   |   ✅   |    ✅    |            |
|      [Node](https://github.com/nodejs/node)       |   ✅   |   ✅   |    🚧    |            |
|     [Rust](https://github.com/rust-lang/rust)     |   ✅   |   ✅   |    ✅    |            |
|   [Espanso](https://github.com/espanso/espanso)   |   ✅   |   ✅   |    ✅    |            |
|        [TeXLive](https://tug.org/texlive/)        |   ✅   |   ✅   |    ✅    |            |
|   [VSCode](https://github.com/microsoft/vscode)   |   ✅   |   ✅   |    ✅    |            |
|                    Container²                     |   ✅   |   ✅   |    ✅    |            |
|                      Formats                      |   🕒   |   🕒   |    🕒    |            |
|  [Helix](https://github.com/helix-editor/helix)   |   🕒   |   🕒   |    🕒    |            |

✅：完整功能
🚧：部分功能
🕒：基础功能，有待补充
❌：不存在

> ¹：目前在 Linux 只提供 Debian 系的相关快捷操作
>
> ²: 仅支持 [Docker](https://docker.com/) 和 [Podman](https://github.com/containers/podman).

Oxidizer 通过 Homebrew 或 Scoop 管理包和软件，以绕过管理员权限的要求。

## 3. 文件管理

![design](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer-design.png)

- `frf`
  - 通过 `source` 刷新
- `edf`
  - 通过 `$EDITOR` 编辑（默认：VSCode）
- `brf`
  - 通过 `bat`/`cat` 浏览文件
  - 文件夹：通过 `lsd`/`ls` 浏览
- `ipf`
  - 文件：在 `$OX_OXYGEN` 中覆盖对应的 `$OX_ELEMENT` 文件配置
- `epf`
  - 文件：在 `$OX_ELEMENT` 中覆盖对应的 `$OX_OXYGEN` 文件配置

例如，当你想编辑 `~/.zshrc`，键入 `edf zs`。

当你使用 `epf zs`，`~/.zshrc` 会被复制并保存到 `$OX_BACKUP/shell` 文件夹。其中，`$OX_BACKUP` 是可以在 `$OXIDIZER/custom.sh` 中自定义的备份路径。通过 `edf ox` 即可轻松打开 `custom.sh` 文件。

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
|    espanso     | `esx`  |       `match/base.yml`       |
|    espanso     | `esx_` |       `match/packages`       |
|     helix      |  `hx`  |        `config.toml`         |
|     helix      | `hxl`  |       `languages.toml`       |
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

Oxidizer 使用 [ouch](https://github.com/ouch-org/ouch)（需要自行安装）压缩或解压缩文件，提供 3 个快捷命令

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

`back_*` 和 `up_*` 适用于 `brew`，`scoop`，`conda`，`vscode`，`espanso`，`julia`，`texlive`，`node`；`clean_*` 只适用于 `brew`。

## 5. 包管理

Oxidizer 致力于为各个包管理器提供统一的接口，以减轻敲击和记忆负担。

|  后缀  |    操作     | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | conan `cn` | tlmgr `tl` |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: | :--------: |
|  `*h`  |    help     |    ✅     |           |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅      |     ✅      |
| `*cf`  |   config    |    ✅     |           |     ✅     |    ✅    |            |             |            |     ✅      |            |
| `*is`  |   install   |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅      |     ✅      |
| `*us`  |  uninstall  |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅      |     ✅      |
| `*up`  |   update    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅      |     ✅      |
| `*ups` | update self |    ✅     |     ✅     |           |         |            |             |            |            |     ✅      |
| `*ls`  |    list     |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |            |     ✅      |
| `*lv`  |   leaves    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |     ✅      |            |            |
| `*sc`  |   search    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |            |     ✅      |            |
| `*cl`  |    clean    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |     ✅      |            |            |
| `*if`  |    info     |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |            |     ✅      |     ✅      |
| `*st`  |   status    |    ✅     |     ✅     |           |    ✅    |            |             |     ✅      |            |            |
| `*ck`  |    check    |    ✅     |     ✅     |           |    ✅    |     ✅      |      ✅      |            |            |     ✅      |
| `*pn`  |     pin     |    ✅     |     ✅     |           |         |            |             |     ✅      |            |            |
| `*upn` |    unpin    |    ✅     |     ✅     |           |         |            |             |     ✅      |            |            |
| `*dp`  |   depends   |    ✅     |     ✅     |     ✅     |         |     ✅      |             |     ✅      |     ✅      |            |
| `*rdp` |    needs    |          |           |     ✅     |         |            |             |     ✅      |            |            |
| `*xa`  |  add repo   |    ✅     |     ✅     |     ✅     |         |            |             |            |     ✅      |            |
| `*xrm` | remove repo |    ✅     |     ✅     |     ✅     |         |            |             |            |     ✅      |            |
| `*xls` |  list repo  |          |           |     ✅     |         |            |             |            |     ✅      |            |

特别地，Oxidizer 提供两组后缀为`p`的实验性函数，用于并行安装和下载软件包

- brew：`bisp`, `biscp`, `bupp`, `bupgp`
- scoop：`sisp`, `supp`

例如，当需要安装 2 个及以上的包时，可以使用 `bisp [pkg1] [pkg1]` 代替 `bis [pkg1] [pkg1]`，进行并行下载安装。

同理，`biscp`, `bupp`, `bupgp` 分别为 `bisc`, `bup`, `bupg` 的并行版本。

使用并行功能前，需要启动 pueue 服务

```sh
# All OS
pueued -d
# or macOS / Linux
bss pu
```

一些包管理器还有项目管理功能

| 后缀  |    操作     | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | conan `cn` |
| :---: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: |
| `*ii` | init/create |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |            |     ✅      |
| `*b`  |    build    |          |           |           |         |     ✅      |             |     ✅      |     ✅      |
| `*r`  |     run     |          |           |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |            |
| `*ed` |    edit     |    ✅     |           |           |         |            |             |            |            |
| `*ca` |     cat     |    ✅     |     ✅     |           |         |            |             |            |            |
| `*ln` |    link     |    ✅     |           |           |         |            |             |            |            |
| `*ts` |    test     |    ✅     |           |           |    ✅    |     ✅      |             |     ✅      |     ✅      |
| `*au` |    audit    |    ✅     |           |           |    ✅    |            |             |            |            |
| `*fx` |     fix     |    ✅     |           |           |    ✅    |     ✅      |             |            |            |
| `*pb` |   publish   |          |           |           |    ✅    |     ✅      |             |            |            |

部分快捷命令被包含在对应的系统扩展中

- `ox-macos` `oxpm`：自启动，包含 `mas`
- `ox-debians` `oxpd`：自启动，包含 `apt`
- `ox-windows` `oxpw`：自启动，包含 `winget`、`wsl`·
- `ox-flatpak` `oxpf`：可选

|  后缀  |  对应操作   | mas `m` | apt `a` | flatpak `f` | winget `w` | wsl `wl` |
| :----: | :---------: | :-----: | :-----: | :---------: | :--------: | :------: |
|  `*h`  |    help     |    ✅    |    ✅    |             |     ✅      |          |
| `*is`  |   install   |    ✅    |    ✅    |      ✅      |     ✅      |    ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅    |      ✅      |     ✅      |          |
| `*up`  |   update    |    ✅    |    ✅    |             |     ✅      |          |
| `*ups` | update self |         |    ✅    |             |     ✅      |          |
| `*ls`  |    list     |         |    ✅    |      ✅      |     ✅      |    ✅     |
| `*lv`  |   leaves    |         |         |             |            |          |
| `*sc`  |   search    |    ✅    |    ✅    |             |            |          |
| `*cl`  |    clean    |         |    ✅    |             |            |          |
| `*if`  |    info     |    ✅    |    ✅    |             |     ✅      |          |
| `*st`  |   status    |    ✅    |         |             |            |          |
| `*ck`  |    check    |         |    ✅    |             |            |          |
| `*dp`  |   depends   |         |    ✅    |             |            |          |

### 5.1. Homebrew 管理

- [x] 使用 `aria2` 下载 brew cask（需自行安装 `aria2` ）
- [x] 使用预下载器安装 Homebrew Casks

- `bris`：brew reinstall 重装
- `bup`：brew upgrade 更新

**前缀 `c` 是一个标志用来严格限制 brew 命令只针对的 casks 操作**

- `bisc`：安装 cask
- `brisc`：重装 cask
- `bupc`：升级 cask

后缀 `a` 是 `all` 的简写，用来使 brew 升级每个 cask（包括含有 `auto_update` 的 cask）

- `bupa`：brew upgrade --greedy

- `bdl`：使用 `aria2` 下载 brew cask
  - `$1`：cask name
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

## 6. 更多阅读

- [更多用法](https://github.com/ivaquero/oxidizer/blob/master/docs/advanced_cn.md)

## 7. 致谢

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 8. 许可

这个项目在 GPL-v3 许可下发布
