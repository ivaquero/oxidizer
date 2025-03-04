# Oxidizer

[![CI](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/ivaquero/oxidizer)](https://github.com/ivaquero/oxidizer/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

一个简单 & 可扩展的，用于统一终端操作的 dotfile 管理工具

<p align="left">
<a href="README.md">English</a> |
<a href="https://github.com/ivaquero/oxidizer/blob/master/README_CN.md">简体中文</a>
</p>

![oxidizer](https://raw.githubusercontent.com/ivaquero/backup/main/docs/oxidizer.png)

## 1. 从这里开始

对 macOS / Linux（Intel）

```sh
export OXIDIZER=$HOME/oxidizer
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $OXIDIZER && bash $OXIDIZER/install.sh
```

- 对中国大陆用户，可设置 `BREW_CN` 变量来下载安装 Homebrew：

```sh
export BREW_CN=1
```

对 Windows

```powershell
$env:OXIDIZER = "$HOME\oxidizer"
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $env:OXIDIZER; . $env:OXIDIZER\install.ps1
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
  - [x] 使用 [tlrc](https://github.com/tldr-pages/tlrc) 替换 `tldr` 和 `man`
  - [x] 使用 [zoxide](https://github.com/ajeetdsouza/zoxide) 替换 `cd` 和 `z`
  - [x] 使用 [hyperfine](https://github.com/sharkdp/hyperfine) 替换 `time`
  - [ ] 使用 [starship](https://github.com/starship/starship) 替换 `powerline10k` 和 `ohmyposh`
  - [ ] 使用 [tokei](https://github.com/XAMPPRocky/tokei) 替换 `cloc`

### 2.2. GUI 工具替换

- [ ] 使用 [WezTerm](https://github.com/wez/wezterm) 或 [alacritty](https://github.com/alacritty/alacritty) 替换 `iterm2` 和 `windows terminal`

> 更推荐 `WezTerm`，自带分屏器

### 2.3. 其他实用的 CLI 工具

- [x] [onefetch](https://github.com/o2sh/onefetch)：命令行 Git 信息工具
- [ ] [yazi](https://github.com/sxyazi/yazi)：终端文件管理器
- [ ] [kondo](https://github.com/tbillington/kondo)：项目依赖清理命令行工具
- [ ] [ouch](https://github.com/ouch-org/ouch)：终端无痛压缩 & 解压工具
- [ ] [sniffnet](https://github.com/GyulyVGC/sniffnet)：网络流量监控工具

### 2.4. 插件总结

插件位于 [oxplugins](https://github.com/ivaquero/oxplugins) 和  [oxplugins-powershell](https://github.com/ivaquero/oxplugins-pwsh)。

| 插件缩写 |       类别       |             macOS              | 自动加载？ |
| :------: | :--------------: | :----------------------------: | :--------: |
| `oxpbg`  |       推荐       |              Git               |            |
| `oxpom`  |   系统快捷操作   |             macOS              |     ✓      |
| `oxpod`  |   系统快捷操作   |      Debian-Based Systems      |     ✓      |
| `oxpor`  |   系统快捷操作   |      RedHat-Based Systems      |     ✓      |
| `oxpow`  |   系统快捷操作   |     Windows（包括 WinGet）     |     ✓      |
| `oxppb`  |     包管理器     |   Homebrew（macOS & Linux）    |     ✓      |
| `oxpps`  |     包管理器     |        Scoop（Windows）        |     ✓      |
| `oxppc`  |     包管理器     | Conda（多语言，主要是 Python） |            |
| `oxppn`  |     包管理器     |    NPM + PNPM（JavaScript）    |            |
| `oxpppx` |     包管理器     | Pixi（多语言，主要是 Python）  |            |
| `oxpptl` |     包管理器     |        tlmgr（TeXLive）        |            |
| `oxpljl` |     编程语言     |             Julia              |            |
| `oxplrb` |     编程语言     |        Ruby（包括 gem）        |            |
| `oxplrs` |     编程语言     |   Rust（包括 cargo, rustup）   |            |
| `oxpcbw` | 软件的命令行界面 |           Bitwarden            |            |
| `oxpces` | 软件的命令行界面 |            Espanso             |            |
| `oxpcjr` | 软件的命令行界面 | Jupyter（notebook, lab, book） |            |
| `oxpcol` | 软件的命令行界面 |             Ollama             |            |
| `oxpcvs` | 软件的命令行界面 |             VSCode             |            |
| `oxpuf`  |     系统工具     |            文件操作            |     ✓      |
| `oxpufm` |     系统工具     |            格式转换            |            |
| `oxpunw` |     系统工具     |            网络配置            |     ✓      |
| `oxpxns` |       其他       | 笔记备份（Obsidian & Logseq）  |            |

将对应的缩写放入 `~/oxidizer/custom.sh` 的 `OX_PLUGINS` 即可加载插件

```sh
OX_PLUGINS=(
  oxpbg
  oxpufm
  oxplrs
)
```

Oxidizer 通过 `Homebrew` 或 `Scoop` 管理包和软件，以绕过管理员权限的要求。

## 3. 文件管理

![design](https://raw.githubusercontent.com/ivaquero/backup/master/docs/design.drawio.png)

- `rff`
  - 通过 `source` 刷新
- `edf`
  - 通过 `$EDITOR` 编辑（默认：VSCode）
- `brf`
  - 通过 `bat`/`cat` 浏览文件
  - 文件夹：通过 `lsd`/`ls` 浏览
- `rdf` （reduce file）
  - 还原文件：在 `$OX_OXIDE` 中覆盖对应的 `$OX_ELEMENT` 文件配置
- `oxf` （oxidize file）
  - 氧化文件：在 `$OX_ELEMENT` 中覆盖对应的 `$OX_OXIDE` 文件配置
- `clzf` （catalyze file）
  - 催化文件：在 `$OX_OXYGEN` 中覆盖对应的 `$OX_ELEMENT` 文件配置
- `ppgf` （propagate file）
  - 传播文件：在 `$OX_OXYGEN` 中覆盖对应的 `$OX_OXIDE` 文件配置

例如，当你想编辑 `~/.zshrc`，键入 `edf zs`。

当你使用 `oxf zs`，`~/.zshrc` 会被复制并保存到 `$OX_BACKUP/shell` 文件夹。其中，`$OX_BACKUP` 是可以在 `$OXIDIZER/custom.sh` 中自定义的备份路径。通过 `edf ox` 即可轻松打开 `custom.sh` 文件。

下表罗列了每个配置文件的缩写：

|    来源    |  代号  |           对应文件           |  定义扩展   |
| :--------: | :----: | :--------------------------: | :---------: |
|  Oxidizer  |  `ox`  |         `custom.sh`          |             |
|    Zsh     |  `zs`  |           `.zshrc`           |  built-in   |
|  Starship  |  `ss`  |       `starship.toml`        |  built-in   |
|  WezTerm   |  `wz`  |        `wezterm.lua`         | `custom.sh` |
|   Debian   |  `sc`  |   `/etc/apt/sources.list`    |   `oxpod`   |
|   Scoop    |  `w`   |        `config.json`         |   `oxpps`   |
|   WinGet   |  `w`   |       `settings.json`        |   `oxpow`   |
|    Git     |  `gi`  |         `.gitignore`         |   `oxpbg`   |
|    Git     |  `g`   |         `.gitconfig`         |   `oxpbg`   |
|   Conda    |  `c`   |          `.condarc`          |   `oxppc`   |
| JavaScript | `jsx`  |        `js-pkgs.txt`         |   `oxppn`   |
|    NPM     |  `n`   |           `.npmrc`           |   `oxppn`   |
|   LaTeX    |  `tl`  |        `texlive-pkgs`        |  `oxpptl`   |
|   Cargo    |  `cg`  |        `config.toml`         |   `oxlrs`   |
|   rustup   |  `rs`  |       `settings.toml`        |   `oxlrs`   |
|  Espanso   |  `es`  |        `default.yml`         |  `oxpces`   |
|  Espanso   | `esb`  |       `match/base.yml`       |  `oxpces`   |
|  Espanso   | `esx_` |       `match/packages`       |  `oxpces`   |
|   VSCode   |  `vs`  |       `settings.json`        |  `oxpcvs`   |
|   VSCode   | `vsk`  |      `keybindings.json`      |  `oxpcvs`   |
|   VSCode   | `vss_` |          `snippets`          |  `oxpcvs`   |
|   VSCode   | `vsx`  |      `vscode-pkgs.txt`       |  `oxpcvs`   |
|  Jupyter   |  `jr`  | `jupyter_notebook_config.py` |  `oxpcjr`   |

> `_` 表示文件夹，你可以详细查看每个相关文件缩写 these abbreviations closely by `brf [Plugin Abbr.]` or `edf [Plugin Abbr.]`.

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

`back_*` 和 `up_*` 适用于 `brew`，`scoop`，`conda`，`vscode`，`espanso`，`julia`，`tlmgr`，`npm`；`clean_*` 适用于 `brew`，`conda`。

## 5. 包管理

Oxidizer 致力于为各个包管理器提供统一的接口，以减轻敲击和记忆负担。

|  后缀  |    操作     | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | pixi `px` | gem `rb` | tlmgr `tl` |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :-------: | :------: | :--------: |
|  `*h`  |    help     |    ✅     |           |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |    ✅     |     ✅      |
| `*cf`  |   config    |    ✅     |           |     ✅     |    ✅    |            |             |            |     ✅     |          |            |
| `*is`  |   install   |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |    ✅     |     ✅      |
| `*us`  |  uninstall  |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |    ✅     |     ✅      |
| `*up`  |   update    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |    ✅     |     ✅      |
| `*ups` | update self |    ✅     |     ✅     |           |         |            |             |            |           |          |     ✅      |
| `*ls`  |    list     |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |    ✅     |     ✅      |
| `*lv`  |   leaves    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |     ✅      |     ✅     |          |            |
| `*sc`  |   search    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |            |     ✅     |    ✅     |            |
| `*cl`  |    clean    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |     ✅      |     ✅     |    ✅     |            |
| `*if`  |    info     |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |             |            |           |          |     ✅      |
| `*st`  |   status    |    ✅     |     ✅     |           |    ✅    |            |             |     ✅      |           |          |            |
| `*ck`  |    check    |    ✅     |     ✅     |     ✅     |    ✅    |     ✅      |      ✅      |            |           |    ✅     |     ✅      |
| `*pn`  |     pin     |    ✅     |     ✅     |           |         |            |             |     ✅      |           |          |            |
| `*upn` |    unpin    |    ✅     |     ✅     |           |         |            |             |     ✅      |           |          |            |
| `*dp`  |   depends   |    ✅     |     ✅     |     ✅     |         |     ✅      |             |     ✅      |           |    ✅     |            |
| `*dpr` |    needs    |          |           |     ✅     |         |            |             |     ✅      |           |          |            |
| `*xa`  |  add repo   |    ✅     |     ✅     |     ✅     |         |            |             |            |           |          |            |
| `*xrm` | remove repo |    ✅     |     ✅     |     ✅     |         |            |             |            |           |          |            |
| `*xls` |  list repo  |          |           |     ✅     |         |            |             |            |           |          |            |

一些包管理器还有项目管理功能

| 后缀  |  操作   | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | pixi `px` | gem `rb` |
| :---: | :-----: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :-------: | :------: |
| `*ii` |  init   |          |           |     ✅     |    ✅    |     ✅      |             |            |     ✅     |          |
| `*cr` | create  |    ✅     |     ✅     |           |    ✅    |     ✅      |             |            |           |          |
| `*b`  |  build  |          |           |           |         |     ✅      |             |     ✅      |           |    ✅     |
| `*r`  |   run   |          |           |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |          |
| `*ed` |  edit   |    ✅     |           |           |         |            |             |            |           |          |
| `*ct` |   cat   |    ✅     |     ✅     |           |         |            |             |            |           |    ✅     |
| `*ln` |  link   |    ✅     |           |           |         |            |             |            |           |          |
| `*ts` |  test   |    ✅     |           |           |    ✅    |     ✅      |             |     ✅      |           |          |
| `*au` |  audit  |    ✅     |           |           |    ✅    |            |             |            |           |          |
| `*fx` |   fix   |    ✅     |           |           |    ✅    |     ✅      |             |            |           |          |
| `*pb` | publish |          |           |           |    ✅    |     ✅      |             |            |           |          |

部分快捷命令被包含在对应的系统扩展中

- `ox-os-macos` `oxpm`：自启动，包含 `mas`
- `ox-os-debians` `oxpd`：自启动，包含 `apt`
- `ox-os-windows` `oxpw`：自启动，包含 `winget`、`wsl`·

|  后缀  |  对应操作   | mas `m` | apt `a` | winget `w` | wsl `wsl` |
| :----: | :---------: | :-----: | :-----: | :--------: | :-------: |
|  `*h`  |    help     |    ✅    |    ✅    |     ✅      |     ✅     |
| `*is`  |   install   |    ✅    |    ✅    |     ✅      |     ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅    |     ✅      |     ✅     |
| `*up`  |   update    |    ✅    |    ✅    |     ✅      |     ✅     |
| `*ups` | update self |         |    ✅    |     ✅      |     ✅     |
| `*ls`  |    list     |         |    ✅    |     ✅      |     ✅     |
| `*lv`  |   leaves    |         |         |            |           |
| `*sc`  |   search    |    ✅    |    ✅    |            |           |
| `*cl`  |    clean    |         |    ✅    |     ✅      |     ✅     |
| `*if`  |    info     |    ✅    |    ✅    |     ✅      |           |
| `*st`  |   status    |    ✅    |         |            |           |
| `*ck`  |    check    |         |    ✅    |            |           |
| `*dp`  |   depends   |         |    ✅    |            |           |
| `*xa`  |  add repo   |         |    ✅    |     ✅      |           |
| `*xrm` | remove repo |         |    ✅    |     ✅      |           |
| `*xls` |  list repo  |         |    ✅    |     ✅      |           |

### 5.1. Homebrew 管理

- `bris`：brew reinstall 重装
- `bup`：brew upgrade 更新

**前缀 `c` 是一个标志用来严格限制 brew 命令只针对的 casks 操作**

- `bisc`：安装 cask
- `brisc`：重装 cask
- `bupc`：升级 cask

- `brp [cask]`：适用于下载文件替换缓存中的 brew cask

### 5.2. Conda 环境管理

请注意，Conda 插件基于 `mamba` 和 `conda-tree` 包，需要预先安装

```sh
conda install -c conda-forge mamba conda-tree
```

除了上面**包管理**提及的 Conda 命令，Conda 插件还提供了 Conda 环境管理的快捷命令，均以 `ce` 开头

- `cerat`: 重启环境，类似 `ceat`
- `ceq`: 退出环境（`q` 代表 `kill/quit`）
- `cecr`: 创建环境
- `cerm`: 删除环境，类似 `ceat` 但不删除 `base` 环境
- `cels`: 环境包列表
- `cedf`: 对比环境
- `cern`: 重命名环境
- `cesd`: 改变架构 `conda-forge subdir`
  - `i`: 对 `osx-64` 或 `linux-64` 或 `win-64`
  - `a`: 对 `osx-arm64` 或 `linux-aarch64` huo `win-arm64`
  - `p`: 对 `ppc64le`
  - `s`: 对 `linux-s390x`
- `ceep`: 导出环境

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
