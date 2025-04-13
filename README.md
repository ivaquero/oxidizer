# Oxidizer

[![CI](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/ivaquero/oxidizer)](https://github.com/ivaquero/oxidizer/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

A Simple & Extensible Dotfile Manager That Unifies Your Terminal Operations

一个简单 & 可扩展的，用于统一终端操作的 dotfile 管理工具

![oxidizer](https://raw.githubusercontent.com/ivaquero/backup/main/docs/oxidizer.png)

## 1. Get Started 从这里开始

For macOS / Linux (Intel)

```sh
export OXIDIZER=$HOME/oxidizer
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $OXIDIZER && bash oxidizer/install.sh
```

Note that Homebrew is an essential dependency for Oxidizer on macOS / Linux.

- 对中国大陆用户，可设置 `BREW_CN` 变量来下载安装 Homebrew：

```sh
export BREW_CN=1
```

For Windows

```powershell
$env:OXIDIZER = "$HOME\oxidizer"
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $env:OXIDIZER; . oxidizer\install.ps1
```

- 对中国大陆用户，可设置 `SCOOP_CN` 变量来下载安装

```powershell
$env:scoop_mirror = 1
```

> For Cmderrs, you need to remove the `-Options ReadOnly` from `Set-Item -Path function:\prompt -Value $Prompt -Options ReadOnly` in the last line of `%CMDER_ROOT%\vendor\profile.ps1`.
>
> 对于 Cmder 用户，你需要删除`%CMDER_ROOT%\vendor\profile.ps1`的最后一行`Set-Item -Path function:\prompt -Value $Prompt -Options ReadOnly`中的`-Options ReadOnly`。

After installation, you might personalize your preference in `custom.sh`, check [defaults.sh](https://github.com/ivaquero/oxidizer/blob/master/defaults.sh). Open `custom.sh` | `custom.ps1` by following command

安装之后，您可以在`custom.sh`中个性化您的系统环境（请参考[defaults.sh](https://github.com/ivaquero/oxidizer/blob/master/defaults.sh)，通过一下命令打开

```bash
edf ox
```

To keep up the updates, simply `upox` function.

可使用 `upox` 命令来更新 Oxidizer

## 2. Motivation 动机

Oxidizer 的主要目标

Oxidizer is originally designed for **non-administrator** users. It saves your time from repetitive and tedious setups of coding environments, and it aims to provide with following features:

- Cross-Platform (mainly Rust toolchains)
- Minimal Dependencies & Minimal Installation
- Extensible Architecture
- Unified Interface & Smooth Usage
- Super-Fast! (loading time < 1 s)

Oxidizer 起初主要为**非管理员用户**设计，用于快速搭建跨平台统一的工作环境，避免重复和繁琐的环境配置劳动，其具有特点

- 跨平台（主要基于 Rust 工具链）
- 最少依赖 & 最少安装
- 可扩展架构
- 统一接口 & 丝滑操作
- 超级快！（载入时间 < 1 秒）

## 3. Tool Chains 工具链

### 3.1. CLI Tools Replacement

> ☑️ means required in the installation.

- coreutils
  - [x] [bat](https://github.com/sharkdp/bat) ⟶ `cat`
  - [x] [lsd](https://github.com/Peltoche/lsd) ⟶ `ls`
  - [ ] [uutils-coreutils](https://github.com/uutils/coreutils) ⟶ `coreutils`
- non-coreutils
  - [x] [dust](https://github.com/bootandy/dust) ⟶ `du`
  - [x] [fd](https://github.com/sharkdp/fd) ⟶ `find`
  - [x] [ripgrep](https://github.com/BurntSushi/ripgrep) ⟶ `grep`
  - [x] [sd](https://github.com/chmln/sd) ⟶ `sed`
  - [x] [tlrc](https://github.com/tldr-pages/tlrc) ⟶ `tldr` | `man`
  - [x] [zoxide](https://github.com/ajeetdsouza/zoxide) ⟶ `cd` | `z`
  - [x] [hyperfine](https://github.com/sharkdp/hyperfine) ⟶ `time`
  - [ ] [starship](https://github.com/starship/starship) ⟶ `powerline10k` | `ohmyposh`
  - [ ] [yazi](https://github.com/sxyazi/yazi) ⟶ `ranger`
  - [ ] [tokei](https://github.com/XAMPPRocky/tokei) ⟶ `cloc`

### 3.2. GUI Tools Replacement

- [ ] [WezTerm](https://github.com/wez/wezterm) | [alacritty](https://github.com/alacritty/alacritty) ⟶ `iterm2` | `windows terminal`

> `WezTerm` is more recommended because it has a built-in multiplexer.

### 3.3. Otherful Rust Tools

- [x] [onefetch](https://github.com/o2sh/onefetch): Command-line Git information tool
- [ ] [ouch](https://github.com/ouch-org/ouch): Painless compression and decompression tool
- [ ] [kondo](https://github.com/tbillington/kondo): A tool to clean dependencies and build artefacts from your projects

### 3.4. Summary of Plugins

Oxidizer is designed to be extensible, you can personalize `plugin_load` in `config.json` to load the plugins by your need.

Of course, you are allowed to write your own plugins, see [Writing A Plugin](https://github.com/ivaquero/oxidizer/blob/master/docs/plugins.md) for details.

The plugins are hosted in [oxplugins](https://github.com/ivaquero/oxplugins) as well as [oxplugins-powershell](https://github.com/ivaquero/oxplugins-pwsh).

插件位于 [oxplugins](https://github.com/ivaquero/oxplugins) 和  [oxplugins-powershell](https://github.com/ivaquero/oxplugins-pwsh)

To load a plugin, simply add its abbreviation into the `OX_PLUGINS` array of `~/oxidizer/config.json`, like

```json
{
    "plugin_load": [
        "cli_espanso",
        "cli_jupyter",
        "cli_ollama",
        "cli_vscode",
        "lang_julia",
        "lang_ruby",
        "lang_rust",
        "pkg_conda",
        "pkg_npm",
        "pkg_tlmgr"
    ]
}
```

|      Filename       |    Category     |            Support             |
| :-----------------: | :-------------: | :----------------------------: |
|     `os_macos`      |  OS Shortcuts   |             macOS              |
|    `os_debians`     |  OS Shortcuts   |      Debian-Based Systems      |
|     `os_redhat`     |  OS Shortcuts   |      RedHat-Based Systems      |
|    `os_windows`     |  OS Shortcuts   |    Windows (include winget)    |
|     `pkg_brew`      | Package Manager |    Homebrew (macOS & Linux)    |
|     `pkg_scoop`     | Package Manager |        Scoop (Windows)         |
|     `pkg_conda`     | Package Manager |    Conda (Multi-Languages)     |
|      `pkg_npm`      | Package Manager |    NPM + PNPM (JavaScript)     |
|     `pkg_pixi`      | Package Manager |     Pixi (Multi-Languages)     |
|     `pkg_tlmgr`     | Package Manager |        tlmgr (TeXLive)         |
|   `cli_bitwarden`   |     App CLI     |           Bitwarden            |
|    `cli_espanso`    |     App CLI     |            Espanso             |
|    `cli_jupyter`    |     App CLI     | Jupyter (notebook, lab, book)  |
|    `cli_ollama`     |     App CLI     |             Ollama             |
|    `cli_vscode`     |     App CLI     |             VSCode             |
|    `lang_julia`     |    Language     |             Julia              |
|     `lang_ruby`     |    Language     |       Ruby (include gem)       |
|     `lang_rust`     |    Language     |  Rust (include cargo, rustup)  |
|    `utils_files`    |  System Utils   |         File Operation         |
|   `utils_formats`   |  System Utils   |       Formats Conversion       |
| `utils_networks.sh` |  System Utils   |     Network Configuration      |
|    `xtra_notes`     |   Extra Utils   | Notes Apps (Obsidian & Logseq) |

## 4. File Management 文件管理

![design](https://raw.githubusercontent.com/ivaquero/backup/master/docs/design.drawio.png)

- `rff`
  - refresh file by `source`
- `edf`
  - edit file by `$EDITOR` (default: VSCode)
- `brf`
  - file: browse by `bat` / `cat`
  - folder: browse by `lsd` / `ls`
- `ipf` (import file, alias: `rdf`)
  - reduce file: overwrite configuration file by backup (customized) file
- `epf` (export file, alias: `oxf`)
  - oxidize file: backup configuration file to backup folder
- `iif` (initialize file, alias: `clzf`)
  - catalyze file: overwrite configuration file by Oxidizer defaults
- `ppgf`
  - propagate file: backup Oxidizer defaults to backup folder

For example, if you want to edit `~/.zshrc`, you can type `edf zs`.

When you `epf zs` (export file), `~/.zshrc` will be copied and save in  folder backup folder

As mentioned in **Get Started**, you can open `custom.json` simply by `edf jox`.

In the `custom.json`, edit the `oxides` map to predefine the specific backup path, where `oxide_folder` is the backup root path relative to `$HOME`. Note that the key should be set as `bk` + `[key in OX_ELEMENT]`.

```json
{
 "oxide_folder": "Documents",
 "oxides": {
        "bkox": "shell/custom.sh",
        "bkoxw": "shell/custom.ps1",
        "bkoxj": "shell/custom.json",
        "bkb": "unix/Brewfile",
        "bkvi": "shell/.vimrc",
        "bkss": "shell/starship.toml",
        "bkg": "../notes/.gitconfig",
        "bkzs": "shell/.zshrc",
        "bkbs": "shell/.bash_profile"
    }
}
```

The table below lists the information of specific configuration files:

> `_` denotes a folder, and you can check these abbreviations closely by `brf [Plugin Abbr.]` | `edf [Plugin Abbr.]`.

Oxidizer uses [ouch](https://github.com/ouch-org/ouch) to deal with compression and decompression, and provides with 3 shortcuts

- `zpf`: compress file
- `zpfr`: decompress file
- `zpfls`: list items in the compressed file

## 6. Package Management 包管理

Oxidizer aims to provide a unified interface for all package manager-related commands to reduce typing and memory burden of command-liners.

| Suffix |   Action    | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | pixi `px` | gem `rb` | tlmgr `tl` |
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

Some package managers also have functionality of project management

| Suffix | Action  | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | pixi `px` | gem `rb` |
| :----: | :-----: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :-------: | :------: |
| `*ii`  |  init   |          |           |     ✅     |    ✅    |     ✅      |             |            |     ✅     |          |
| `*cr`  | create  |    ✅     |     ✅     |           |    ✅    |     ✅      |             |            |           |          |
|  `*b`  |  build  |          |           |           |         |     ✅      |             |     ✅      |           |    ✅     |
|  `*r`  |   run   |          |           |     ✅     |    ✅    |     ✅      |      ✅      |     ✅      |     ✅     |          |
| `*ed`  |  edit   |    ✅     |           |           |         |            |             |            |           |          |
| `*ct`  |   cat   |    ✅     |     ✅     |           |         |            |             |            |           |    ✅     |
| `*ln`  |  link   |    ✅     |           |           |         |            |             |            |           |          |
| `*ts`  |  test   |    ✅     |           |           |    ✅    |     ✅      |             |     ✅      |           |          |
| `*au`  |  audit  |    ✅     |           |           |    ✅    |            |             |            |           |          |
| `*fx`  |   fix   |    ✅     |           |           |    ✅    |     ✅      |             |            |           |          |
| `*pb`  | publish |          |           |           |    ✅    |     ✅      |             |            |           |          |

Some of the package managers shortcuts are included in corresponding system plugins.

- `ox-os-macos`: auto-loaded, contains alias and functions for `mas`
- `ox-os-debians`: auto-loaded, contains alias and functions for `apt`
- `ox-os-windows`: auto-loaded, contains alias and functions for `winget` and `wsl`

| Suffix |   Action    | mas `m` | apt `a` | winget `w` | wsl `wl` |
| :----: | :---------: | :-----: | :-----: | :--------: | :------: |
|  `*h`  |    help     |    ✅    |    ✅    |     ✅      |    ✅     |
| `*is`  |   install   |    ✅    |    ✅    |     ✅      |    ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅    |     ✅      |    ✅     |
| `*up`  |   update    |    ✅    |    ✅    |     ✅      |    ✅     |
| `*ups` | update self |         |    ✅    |     ✅      |    ✅     |
| `*ls`  |    list     |         |    ✅    |     ✅      |    ✅     |
| `*lv`  |   leaves    |         |         |            |          |
| `*sc`  |   search    |    ✅    |    ✅    |            |          |
| `*cl`  |    clean    |         |    ✅    |     ✅      |    ✅     |
| `*if`  |    info     |    ✅    |    ✅    |     ✅      |          |
| `*st`  |   status    |    ✅    |         |            |          |
| `*ck`  |    check    |         |    ✅    |            |          |
| `*dp`  |   depends   |         |    ✅    |            |          |
| `*xa`  |  add repo   |         |    ✅    |     ✅      |          |
| `*xrm` | remove repo |         |    ✅    |     ✅      |          |
| `*xls` |  list repo  |         |    ✅    |     ✅      |          |

### 6.1. Homebrew

- `bis`: brew install
- `bris`: brew reinstall

suffix `c` is a flag to specify brew commands only work on casks

- `bisc`: brew install --cask
- `brisc`: brew reinstall --cask
- `bupc`: brew upgrade --cask

- `brp [cask]`: replace brew cache file by pre-downloaded file

### 6.2. Conda

Note that some shortcuts of the `ox-conda` plugin is based on the package `conda-tree` that you need to install

```sh
conda install -c conda-forge conda-tree
```

Besides the shortcuts mentioned above in **Package Management**, the conda plugin also provides with Conda environment management shortcuts which start with `ce`

- `ceat`: activate environment
  - `$1` length = 0: activate `base` env
  - `$1` length = 1 | 2: activate predefined env `OX_CONDA_ENV`
  - `$1` length > 2: activate new env

`OX_CONDA_ENV` can be personalized in `custom.sh`

For example, assume your environment's name is `hello`, you can set

```sh
# macOS / Linux
OX_CONDA_ENV[h]="hello"
# Windows
$Global:OX_CONDA_ENV.h = "hello"
```

then, you will be able to manipulate the environment by

```sh
# create environment
cecr h
# remove environment
cerm h
# update all packages in the specific environment
cup h
# list all packages in the specific environment
cls h
```

- `cerat`: reactivate environment, works live `ceat`
- `ceq`: quit environment (`q` is for `kill/quit`)
- `cecr`: create
- `cerm`: remove environment, works live `ceat` but won't remove `base` env
- `cels`: environment list
- `cedf`: compare packages between conda environments
- `cern`: renames an existing environment
- `cesd`: change environment's `conda-forge subdir`
  - `i`: for `osx-64` | `linux-64` | `win-64`
  - `a`: for `osx-arm64` | `linux-aarch64` | `win-arm64`
  - `p`: for `ppc64le`
  - `s`: for `linux-s390x`
- `ceep`: export environment

## 5. Software Information Management

`back_*` and `up_*` work for `brew`, `scoop`, `conda`, `vscode` (only for windows), `julia`, `tlmgr`, `npm`. `clean_*` works for `brew` and `conda`.

- `back_*`
  - file: export package/extension info into `$OX_BACKUP` folder
- `up_*`
  - file: install packages/extensions by predefined files in `$OX_BACKUP`
- `clean_*`
  - file: clean package/extension info by predefined files in `$OX_BACKUP` folder

## 7. Project Management **工程管理**

### 7.1. Git

- [x] `gclhs`: delete commit history

for aliases, check `.gitconfig` in `defaults` folder by `edf oxg`

## 8. Further Reading

- [Service Management](https://github.com/ivaquero/oxidizer/blob/master/docs/services.md)
- [Project Management](https://github.com/ivaquero/oxidizer/blob/master/docs/projects.md)
- [Utility Management](https://github.com/ivaquero/oxidizer/blob/master/docs/utilities.md)
- [System Management](https://github.com/ivaquero/oxidizer/blob/master/docs/systems.md)
- [Writing A Plugin](https://github.com/ivaquero/oxidizer/blob/master/docs/plugins.md)

## 9. Credits 致谢

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 10. License 许可

This work is released under the GPL-v3 license.

这个项目在 GPL-v3 许可下发布
