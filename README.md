# Oxidizer

[![CI](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer/actions/workflows/main.yml)
[![license](https://img.shields.io/github/license/ivaquero/oxidizer)](https://github.com/ivaquero/oxidizer/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

Simple & Extensible Dotfile Manager Unifying Your Terminal Operations (PRs and Forks are welcome !)

<p align="left">
<a href="README.md">English</a> |
<a href="https://github.com/ivaquero/oxidizer/blob/master/README_CN.md">简体中文</a>
</p>

Let's Oxidize Development Environments

![oxidizer](https://raw.githubusercontent.com/ivaquero/backup/main/docs/oxidizer.png)

## 1. Get Started

For macOS / Linux (Intel)

```sh
git clone --depth=1 https://github.com/ivaquero/oxidizer.git && bash oxidizer/install.sh

# customize path for Oxidizer
export OXIDIZER=$HOME/oxidizer
```

Note that Homebrew is an essential dependency for Oxidizer on macOS / Linux. For China mainland users, you may set `BREW_CN` variable to install Homebrew through domestic mirror

```sh
export BREW_CN=1
```

> Note that Oxidizer only support limited functionality on Linux-on-ARM yet.

For Windows

```powershell
git clone --depth=1 https://github.com/ivaquero/oxidizer.git; . oxidizer\install.ps1

# customize path for Oxidizer
$env:OXIDIZER = "$HOME\oxidizer"
```

Note that Scoop is an essential dependency for Oxidizer on Windows. For China mainland users, you may set `SCOOP_CN` variable to install Scoop through domestic mirror

```powershell
$env:scoop_mirror = 1
```

> For Cmder users, you need to remove the `-Options ReadOnly` from `Set-Item -Path function:\prompt -Value $Prompt -Options ReadOnly` in the last line of `%CMDER_ROOT%\vendor\profile.ps1`.

After installation, you might personalize your preference in `custom.sh`, check [defaults.sh](https://github.com/ivaquero/oxidizer/blob/master/defaults.sh). Open `custom.sh` or `custom.ps1` by following command

```bash
edf ox
```

To keep up the updates, simply use `upox` function.

## 2. Motivation

Oxidizer is originally designed for **non-administrator** users. It saves your time from repetitive and tedious setups of coding environments, and it aims to provide with following features:

- Cross-Platform (mainly Rust toolchains)
- Minimal Dependencies & Minimal Installation
- Extensible Architecture
- Unified Interface & Smooth Usage
- Super-Fast! (loading time < 1 s)

### 2.1. CLI Tools Replacement

> ☑️ means required in the installation.

- coreutils
  - [x] Use [uutils-coreutils](https://github.com/uutils/coreutils) instead of `coreutils` (only required on Windows)
  - [x] Use [bat](https://github.com/sharkdp/bat) instead of `cat`
  - [x] Use [lsd](https://github.com/Peltoche/lsd) instead of `ls`
- non-coreutils
  - [x] Use [fd](https://github.com/sharkdp/fd) instead of `find`
  - [x] Use [zoxide](https://github.com/ajeetdsouza/zoxide) instead of `cd` or `z`
  - [x] Use [ripgrep](https://github.com/BurntSushi/ripgrep) instead of `grep`
  - [ ] Use [dust](https://github.com/bootandy/dust) instead of `du`
  - [ ] Use [hyperfine](https://github.com/sharkdp/hyperfine) instead of `time`
  - [ ] Use [procs](https://github.com/dalance/procs) instead of `ps`
  - [ ] Use [starship](https://github.com/starship/starship) instead of `powerline10k` or `ohmyposh`
  - [ ] Use [tealdeer](https://github.com/dbrgn/tealdeer) instead of `tldr` or `man`
  - [ ] Use [tokei](https://github.com/XAMPPRocky/tokei) instead of `cloc`
  - [ ] Use [tre](https://github.com/dduan/tre) instead of `tree`

> `Nushell` is a cross-platform written in Rust, but it doesn't support dynamical path for the moment.

### 2.2. TUI Tools Replacement

- [x] Use [gitui](https://github.com/extrawurst/gitui) instead of `lazygit`
- [ ] Use [bottom](https://github.com/ClementTsang/bottom) instead of `top` or `htop`
- [ ] Use [yazi](https://github.com/sxyazi/yazi) instead of `range`
- [ ] Use [helix](https://github.com/helix-editor/helix) instead of `vim` (Not drop-in)
- [ ] Use [zellij](https://github.com/zellij-org/zellij) instead of `tmux` (Not supported on Windows)

### 2.3. GUI Tools Replacement

- [ ] Use [WezTerm](https://github.com/wez/wezterm) or [alacritty](https://github.com/alacritty/alacritty) instead of `iterm2` or `windows terminal`

> `WezTerm` is more recommended because it has a built-in multiplexer.

### 2.4. Other Useful Rust Tools

- [x] [ouch](https://github.com/ouch-org/ouch): Painless compression and decompression tool
- [ ] [pueue](https://github.com/Nukesor/pueue): Command-line task management tool for sequential and parallel execution of long-running tasks
- [ ] [kondo](https://github.com/tbillington/kondo): A tool to clean dependencies and build artefacts from your projects.
- [ ] [navi](https://github.com/denisidoro/navi): An interactive cheatsheet tool for the command-line
- [ ] [onefetch](https://github.com/o2sh/onefetch): Command-line Git information tool

### 2.5. Summary of Plugins

Oxidizer is designed to be extensible, you can personalize `OX_PLUGINS` in `custom.sh` to load the plugins by your need.

Of course, you are allowed to write your own plugins, see [Writing A Plugin](https://github.com/ivaquero/oxidizer/blob/master/docs/plugins.md) for details.

The plugins are hosted in [OxPlugins](https://github.com/ivaquero/oxplugins)

> [OxPlugins-PowerShell](https://github.com/ivaquero/oxplugins-pwsh) has stopped maintenance.

|                      Plugin                       | Linux | macOS | Windows | Autoload? |
| :-----------------------------------------------: | :---: | :---: | :-----: | :-------: |
|     [Brew](https://github.com/Homebrew/brew)      |  ✅   |  ✅   |   ❌    |    ✅     |
| [Scoop](https://github.com/ScoopInstaller/Scoop)  |  ❌   |  ❌   |   ✅    |    ✅     |
|     [Pueue](https://github.com/Nukesor/pueue)     |  ✅   |  ✅   |   ✅    |    ✅     |
|                      System                       |  ✅¹  |  ✅   |   ✅    |    ✅     |
|     File Utility (backup/import config, etc.)     |  ✅   |  ✅   |   ✅    |    ✅     |
|            [Git](https://git-scm.com/)            |  ✅   |  ✅   |   ✅    |           |
| [Bitwarden](https://github.com/bitwarden/clients) |  🕒   |  🕒   |   🕒    |           |
|    [Conan](https://github.com/conan-io/conan)     |  ✅   |  ✅   |   ✅    |           |
|      [Conda](https://github.com/conda/conda)      |  ✅   |  ✅   |   ✅    |           |
|    [Julia](https://github.com/JuliaLang/julia)    |  ✅   |  ✅   |   🚧    |           |
|   [Jupyter](https://github.com/jupyter/jupyter)   |  ✅   |  ✅   |   ✅    |           |
|      [Node](https://github.com/nodejs/node)       |  ✅   |  ✅   |   ✅    |           |
|     [Rust](https://github.com/rust-lang/rust)     |  ✅   |  ✅   |   ✅    |           |
|   [Espanso](https://github.com/espanso/espanso)   |  ✅   |  ✅   |   ✅    |           |
|        [TeXLive](https://tug.org/texlive/)        |  ✅   |  ✅   |   ✅    |           |
|   [VSCode](https://github.com/microsoft/vscode)   |  ✅   |  ✅   |   ✅    |           |
|                    Container²                     |  ✅   |  ✅   |   ✅    |           |
|               Formats (conversion)                |  🕒   |  🕒   |   🕒    |           |
|            Network (proxy and mirror)             |  🕒   |  🕒   |   🕒    |           |
|                      Weather                      |  🕒   |  🕒   |   🕒    |           |
|                 Notes (obsidian)                  |  🕒   |  🕒   |   🕒    |           |

✅: complete functionality
🚧: partial functionality
🕒: basic functionality, needs more features
❌: not exist

> ¹: Currently, on Linux only provide with Debian-family shortcuts
>
> ²: Only for [Docker](https://docker.com/) and [Podman](https://github.com/containers/podman).

Oxidizer uses Homebrew or Scoop to manage packages and software programs to bypass the requirement of administrator privilege.

## 3. File Management

![design](https://raw.githubusercontent.com/ivaquero/backup/master/docs/design.drawio.png)

- `rff`
  - refresh file by `source`
- `edf`
  - edit file by `$EDITOR` (default: VSCode)
- `brf`
  - file: browse by `bat` / `cat`
  - folder: browse by `lsd` / `ls`
- `rdf`
  - reduce file: owerwrite configuation file by backup (customized) file
- `oxf`
  - oxidize file: backup configuration file to backup folder
- `clzf`
  - catalyze file: owerwrite configuartion file by Oxidizer defaults
- `ppgf`
  - propagate file: backup Oxidizer defaults to backup folder

For example, if you want to edit `~/.zshrc`, you can type `edf zs`.

When you use `oxf zs`, `~/.zshrc` will be copied and save in `$OX_BACKUP/shell` folder, where `$OX_BACKUP` is the backup path that can be personalized in `$OXIDIZER/custom.sh`. As mentioned in **Get Started**, you can open `custom.sh` simply by `edf ox`.

The table below lists the information of specific configuration files:

|     Origin     | Abbreviation |      Corresponding File      |
| :------------: | :----------: | :--------------------------: |
|    oxidizer    |     `ox`     |         `custom.sh`          |
|      zsh       |     `zs`     |           `.zshrc`           |
|   powershell   |     `ps`     |        `Profile.ps1`         |
| linux (debian) |     `sc`     |   `/etc/apt/sources.list`    |
|    wezterm     |     `wz`     |        `wezterm.lua`         |
|     conda      |     `c`      |          `.condarc`          |
|      git       |     `g`      |         `.gitconfig`         |
|      git       |     `gi`     |         `.gitignore`         |
|     conan      |     `cn`     |         `conan.conf`         |
|     conan      |    `cnr`     |        `remotes.json`        |
|     conan      |    `cnd`     |      `profiles/default`      |
|    espanso     |     `es`     |        `default.yml`         |
|    espanso     |    `esb`     |       `match/base.yml`       |
|    espanso     |    `esx_`    |       `match/packages`       |
|     julia      |     `jl`     |         `startup.jl`         |
|     julia      |    `jlx`     |       `julia-pkgs.txt`       |
|     julia      |    `jlp`     |        `Project.toml`        |
|     julia      |    `jlm`     |       `Manifest.toml`        |
|    jupyter     |     `jn`     | `jupyter_notebook_config.py` |
|     latex      |     `tl`     |        `texlive-pkgs`        |
|      node      |     `nj`     |           `.npmrc`           |
|      node      |    `njx`     |       `node-pkgs.txt`        |
|     pueue      |     `pu`     |         `pueue.yml`          |
|     pueue      |    `pua`     |     `pueue_aliases.yml`      |
|     cargo      |     `cg`     |        `config.toml`         |
|     rustup     |     `rs`     |       `settings.toml`        |
|    starship    |     `ss`     |       `starship.toml`        |
|     vscode     |     `vs`     |       `settings.json`        |
|     vscode     |    `vsk`     |      `keybindings.json`      |
|     vscode     |    `vss_`    |          `snippets`          |
|     vscode     |    `vsx`     |      `vscode-pkgs.txt`       |
|     winget     |     `w`      |        `winget.json`         |
|     zellij     |     `zj`     |         `config.kdl`         |
|     zellij     |    `zjl_`    |          `layouts`           |

> `_` denotes a folder

Oxidizer uses [ouch](https://github.com/ouch-org/ouch) to deal with compression and decompression, and provides with 3 shortcuts

- `zpf`: compress file
- `uzpf`: decompress file
- `lzpf`: list items in the compressed file

## 4. Software Information Management

`back_*` and `up_*` work for `brew`, `scoop`, `conda`, `vscode` (only for windows), `julia`, `texlive`, `node`. `clean_*` works for `brew` and `conda`.

- `back_*`
  - file: export package/extension info into `$OX_BACKUP` folder
- `up_*`
  - file: install packages/extensions by predefined files in `$OX_BACKUP`
- `clean_*`
  - file: clean package/extension info by predefined files in `$OX_BACKUP` folder

## 5. Package Management

Oxidizer aims to provide a unified interface for all package manager-related commands to reduce typing and memory burden of command-line users.

| Suffix |   Action    | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | gem `rb` | conan `cn` | tlmgr `tl` |
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

Particularly, Oxidizer provides with two groups of experimental functions with suffix `p` for installing and downloading packages in parallel

- brew: `bisp`, `biscp`, `bupp`
- scoop: `sisp`, `supp`

For example, when you have more than 1 packages to install, instead of using `bis [pkg1] [pkg2]` , you can use `bisp [pkg1] [pkg2]` then the packages will be downloaded and installed in parallel.

Similarly, `biscp`, `bupp`, are the parallel version of `bisc`, `bup`, respectively.

Before using parallel functions, `pueue` service need to be enabled by

```sh
# All OS
pueued -d
# or macOS / Linux
bss pu
```

Some package managers also have functionality of project management

| Suffix |   Action    | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | gem `rb` | conan `cn` |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :------: | :--------: |
| `*ii`  | init/create |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |          |     ✅     |
|  `*b`  |    build    |          |           |           |         |     ✅     |             |     ✅     |    ✅    |     ✅     |
|  `*r`  |     run     |          |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |          |            |
| `*ed`  |    edit     |    ✅    |           |           |         |            |             |            |          |            |
| `*ct`  |     cat     |    ✅    |    ✅     |           |         |            |             |            |    ✅    |            |
| `*ln`  |    link     |    ✅    |           |           |         |            |             |            |          |            |
| `*ts`  |    test     |    ✅    |           |           |   ✅    |     ✅     |             |     ✅     |          |     ✅     |
| `*au`  |    audit    |    ✅    |           |           |   ✅    |            |             |            |          |            |
| `*fx`  |     fix     |    ✅    |           |           |   ✅    |     ✅     |             |            |          |            |
| `*pb`  |   publish   |          |           |           |   ✅    |     ✅     |             |            |          |            |

Some of the package managers shortcuts are included in corresponding system plugins.

- `ox-macos`: autoloaded, contains alias and functions for `mas`
- `ox-debians`: autoloaded, contains alias and functions for `apt`
- `ox-windows`: autoloaded, contains alias and functions for `winget` and `wsl`

| Suffix |   Action    | mas `m` | apt `a` | winget `w` | wsl `wl` |
| :----: | :---------: | :-----: | :-----: | :--------: | :------: |
|  `*h`  |    help     |   ✅    |   ✅    |     ✅     |    ✅    |
| `*is`  |   install   |   ✅    |   ✅    |     ✅     |    ✅    |
| `*us`  |  uninstall  |   ✅    |   ✅    |     ✅     |    ✅    |
| `*up`  |   update    |   ✅    |   ✅    |     ✅     |    ✅    |
| `*ups` | update self |         |   ✅    |     ✅     |    ✅    |
| `*ls`  |    list     |         |   ✅    |     ✅     |    ✅    |
| `*lv`  |   leaves    |         |         |            |          |
| `*sc`  |   search    |   ✅    |   ✅    |            |          |
| `*cl`  |    clean    |         |   ✅    |            |    ✅    |
| `*if`  |    info     |   ✅    |   ✅    |     ✅     |          |
| `*st`  |   status    |   ✅    |         |            |          |
| `*ck`  |    check    |         |   ✅    |            |          |
| `*dp`  |   depends   |         |   ✅    |            |          |
| `*xa`  |  add repo   |         |   ✅    |     ✅     |          |
| `*xrm` | remove repo |         |   ✅    |     ✅     |          |
| `*xls` |  list repo  |         |   ✅    |     ✅     |          |

### 5.1. Homebrew

- `bis`: brew install
- `bris`: brew reinstall

suffix `c` is a flag to specify brew commands only work on casks

- `bisc`: brew install --cask
- `brisc`: brew reinstall --cask
- `bupc`: brew upgrade --cask
- `bupg`: brew upgrade --greedy

- `brp`: replace brew cache file by pre-downloaded file
- `bmr`: using brew mirror
- `bmrq`: reset brew git source to official repositories, `q` is for quit.

### 5.2. Conda

Note that some shortcuts of the `ox-conda` plugin is based on the package `conda-tree` that you need to install

```sh
conda install -c conda-forge conda-tree
```

Besides the shortcuts mentioned above in **Package Management**, the conda plugin also provides with Conda environment management shortcuts which start with `ce`

- `ceat`: activate environment
  - `$1` length = 0: activate `base` env
  - `$1` length = 1 or 2: activate predefined env `OX_CONDA_ENV`
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
  - `i`: for `osx-64` or `linux-64` or `win-64`
  - `a`: for `osx-arm64` or `linux-aarch64` or `win-arm64`
  - `p`: for `ppc64le`
  - `s`: for `linux-s390x`
- `ceep`: export environment

## 6. Project Management

### 6.1. Git

- [x] `gclhs`: delete commit history

for aliases, check `.gitconfig` in `defaults` folder by `edf oxg`

## 7. Further Reading

- [Service Management](https://github.com/ivaquero/oxidizer/blob/master/docs/services.md)
- [Project Management](https://github.com/ivaquero/oxidizer/blob/master/docs/projects.md)
- [Utility Management](https://github.com/ivaquero/oxidizer/blob/master/docs/utilities.md)
- [System Management](https://github.com/ivaquero/oxidizer/blob/master/docs/systems.md)
- [Writing A Plugin](https://github.com/ivaquero/oxidizer/blob/master/docs/plugins.md)

## 8. Credits

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 9. License

This work is released under the GPL-v3 license.
