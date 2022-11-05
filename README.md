# Oxidizer.sh

[![CI](https://github.com/ivaquero/oxidizer.sh/actions/workflows/main.yml/badge.svg)](https://github.com/ivaquero/oxidizer.sh/actions/workflows/main.yml)
[![licence](https://img.shields.io/github/license/ivaquero/oxidizer.sh)](https://github.com/ivaquero/oxidizer.sh/blob/master/LICENSE)
![code size](https://img.shields.io/github/languages/code-size/ivaquero/oxidizer.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/oxidizer.svg)

Minimalistic & Extensible Dotfile Manager using Rust Toolchains (PRs and Forks are welcome !)

<p align="left">
<a href="README.md">English</a> |
<a href="https://github.com/ivaquero/oxidizer.sh/wiki/%E4%B8%AD%E6%96%87">简体中文</a>
</p>

Let's Oxidize Development Environments

![oxidizer](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer.png)

## 1. Get Started

For macOS / Linux (Intel)

```bash
# define path for Oxidizer
export OXIDIZER=$HOME/oxidizer

git clone --depth=1 https://github.com/ivaquero/oxidizer.sh.git $OXIDIZER && bash $OXIDIZER/install.sh
```

Note that Homebrew is an essential dependency for Oxidizer on macOS / Linux. For China mainland users, you may set `BREW_CN` variable to install Homebrew through domestic mirror

```bash
export BREW_CN=1
```

For Windows

```powershell
# define path for Oxidizer
$env:OXIDIZER = "$HOME\oxidizer"

git clone --depth=1 https://github.com/ivaquero/oxidizer.sh.git $env:OXIDIZER; . $env:OXIDIZER\install.ps1
```

Note that Scoop is an essential dependency for Oxidizer on Windows. For China mainland users, you may set `SCOOP_CN` variable to install Scoop through domestic mirror

```powershell
$env:scoop_mirror = 1
```

> For Cmder users, you need to remove the `-Options ReadOnly` from `Set-Item -Path function:\prompt -Value $Prompt -Options ReadOnly` in the last line of `%CMDER_ROOT%\vendor\profile.ps1`.

After installation, you might personalize your preference in `custom.sh` or `custom.ps1`, check [defaults.sh](https://github.com/ivaquero/oxidizer.sh/blob/master/defaults.sh) or [defaults.ps1](https://github.com/ivaquero/oxidizer.sh/blob/master/defaults.ps1). Open `custom.sh` or `custom.ps1` by following command

```shellscript
ef ox
```

To keep up the updates, simply use `upox` function.

## 1. Philosophy

Oxidizer is originally designed for **non-administrator** users. It quickly sets up a minimal but powerful coding environment, and it aims to provide with following features:

- Cross-Platform (Mainly Rust Tool chains)
- Minimal dependencies & Minimal Installation
- Extensible Architecture
- Unified Interface & Smooth Usage
- Super-Fast! (Loading time < 1 s)

## 2. Oxidization Progress

### 2.1. Command Line Replacement

☑️ means required in the installation.

- [x] Use `bat` instead of `cat`
- [x] Use `fd` instead of `find`
- [x] Use `gitui` instead of `lazygit`
- [x] Use `lsd` instead of `ls`
- [x] Use `lsd --tree` instead of `tree`
- [x] Use `ripgrep` instead of `grep`
- [x] Use `sd` instead of `sed`
- [x] Use `tealdeer` instead of `tldr` or `man`
- [x] Use `zoxide` instead of `cd` or `z.lua`
- [x] Use `bottom` instead of `top` or `htop`
- [x] Use `dust` instead of `du`
- [ ] Use `tokei` instead of `cloc`
- [ ] Use `starship` instead of `powerline10k` or `ohmyposh`
- [ ] Use `tectonic` instead of `xetex` or `xelatex`

### 2.2. Software Replacement

- [ ] Use `WezTerm` or `Alacritty` instead of `iTerm2` or `Windows Terminal`
- [ ] Use `Helix` instead of `NeoVim`
- [ ] Use `Zellij` instead of `TMux` (Not support Windows yet)
- [ ] Use `Joshuto` instead of `Ranger` (Not support Windows yet)

> `Nushell` is a cross-platform written in Rust, but it doesn't support dynamical path for the moment.

### 2.3. Other Useful Rust Tools

- [x] `pueue`: Command-line task management tool for sequential and parallel execution of long-running tasks.
- [x] `hyperfine`: Command-line benchmarking tool
- [ ] `navi`: An interactive cheatsheet tool for the command-line
- [ ] `espanso`: Text Expander written in Rust (try it for fun!)

### 2.4. Summary of Plugins

Oxidizer is designed to be extensible, you can personalize `PLUGINS` in `custom.sh` to load the plugins by your need.

Of course, you are allowed to write your own plugins, see `11. Writing A Plugin` for details.

|     |                      Plugin                       | Linux | macOS | Windows | Autoload? |
| :-: | :-----------------------------------------------: | :---: | :---: | :-----: | :-------: |
|  1  |     [Brew](https://github.com/Homebrew/brew)      |  ✅   |  ✅   |   ❌    |    ✅     |
|  2  | [Scoop](https://github.com/ScoopInstaller/Scoop)  |  ❌   |  ❌   |   ✅    |    ✅     |
|  3  |                      System                       |  ✅¹  |  ✅   |   ✅    |    ✅     |
|  4  |                      Utility                      |  ✅   |  ✅   |   ✅    |    ✅     |
|  5  |     [Pueue](https://github.com/Nukesor/pueue)     |  ✅   |  ✅   |   ✅    |    ✅     |
|  6  |            [Git](https://git-scm.com/)            |  ✅   |  ✅   |   ✅    |           |
|  7  |                      Formats                      |  🕒   |  🕒   |   🕒    |           |
|  8  |          [Flatpak](https://flatpak.org)           |  ✅   |  ❌   |   ❌    |           |
|  9  | [Bitwarden](https://github.com/bitwarden/clients) |  🕒   |  🕒   |   🕒    |           |
| 10  |    [Conan](https://github.com/conan-io/conan)     |  ✅   |  ✅   |   ✅    |           |
| 11  |      [Conda](https://github.com/conda/conda)      |  ✅   |  ✅   |   ✅    |           |
| 12  |           [Docker](https://docker.com/)           |  ✅   |  ✅   |   ✅    |           |
| 13  |    [Julia](https://github.com/JuliaLang/julia)    |  ✅   |  ✅   |   🚧    |           |
| 14  |   [Jupyter](https://github.com/jupyter/jupyter)   |  ✅   |  ✅   |   ✅    |           |
| 15  |      [Node](https://github.com/nodejs/node)       |  ✅   |  ✅   |   🚧    |           |
| 16  |  [Podman](https://github.com/containers/podman)   |  ✅   |  ✅   |   ✅    |           |
| 17  |          [Ruby](https://ruby-lang.org/)           |  🕒   |  🕒   |   🕒    |           |
| 18  |     [Rust](https://github.com/rust-lang/rust)     |  ✅   |  ✅   |   ✅    |           |
| 19  |   [Espanso](https://github.com/espanso/espanso)   |  ✅   |  ✅   |   ✅    |           |
| 20  |        [TeXLive](https://tug.org/texlive/)        |  ✅   |  ✅   |   ✅    |           |
| 21  |   [VSCode](https://github.com/microsoft/vscode)   |  ✅   |  ✅   |   ✅    |           |
| 22  |  [Helix](https://github.com/helix-editor/helix)   |  🕒   |  🕒   |   🕒    |           |

✅: complete functionality
🚧: partial functionality
🕒: basic functionality, needs more features
❌: not exist

> ¹: Currently, on Linux only provide with Debian-family shortcuts.

Oxidizer uses Homebrew or Scoop to manage packages and software programs to bypass the requirement of administrator privilege.

## 3. File Management

![design](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer-design.png)

- `ff`
  - refresh file by `source`
- `ef`
  - file: edit by `$EDITOR` (default: VSCode)
- `bf`
  - file: browse by `bat` / `cat`
  - folder: browse by `lsd` / `ls`
- `ipf`
  - file: overwrite system configurations by customized (backup) files
- `epf`
  - file: export system configurations to back up folder
- `iif`
  - file: overwrite system configurations in by Oxidizer defaults.

For example, if you want to edit `~/.zshrc`, you can type `ef zs`.

When you use `epf zs`, `~/.zshrc` will be copied and save in `$BACKUP/shell` folder, where `$BACKUP` is the backup path that can be personalized in `$OXIDIZER/custom.sh`. As mentioned in `1. Get Started`, you can open `custom.sh` simply by `ef ox`.

The table below lists the information of specific configuration files:

|   Origin   | Abbreviation | Corresponding File  |
| :--------: | :----------: | :-----------------: |
|  oxidizer  |     `ox`     |     `custom.sh`     |
|    zsh     |     `zs`     |      `.zshrc`       |
| powershell |     `ps`     |    `Profile.ps1`    |
|  wezterm   |     `wz`     |    `wezterm.lua`    |
|   conda    |     `c`      |     `.condarc`      |
|    git     |     `g`      |    `.gitconfig`     |
|    git     |     `gi`     |    `.gitignore`     |
|   conan    |     `cn`     |      `default`      |
|   conan    |    `cnr`     |    `remote.json`    |
|  espanso   |     `es`     |    `default.yml`    |
|  espanso   |    `esm`     |  `match/base.yml`   |
|  espanso   |    `esx`     |   `espanso-pkgs`    |
|   helix    |     `hx`     |    `config.toml`    |
|   helix    |    `hxl`     |  `languages.toml`   |
|   julia    |     `jl`     |  `julia-pkgs.txt`   |
|   julia    |    `jls`     |    `startup.jl`     |
|   julia    |    `jlp`     |   `Project.toml`    |
|   julia    |    `jlm`     |   `Manifest.toml`   |
|   latex    |     `tl`     |   `texlive-pkgs`    |
|    node    |     `nj`     |   `node-pkgs.txt`   |
|   pueue    |     `pu`     |     `pueue.yml`     |
|   pueue    |    `pua`     | `pueue_aliases.yml` |
|   cargo    |     `cg`     |        `env`        |
|   cargo    |    `cg_`     |      `.cargo`       |
|   vscode   |     `vs`     |   `settings.json`   |
|   vscode   |    `vsk`     | `keybindings.json`  |
|   vscode   |    `vss_`    |     `snippets`      |
|   vscode   |    `vsx`     |  `vscode-pkgs.txt`  |
|   winget   |     `w`      |    `winget.json`    |
|   zellij   |     `zj`     |    `config.kdl`     |
|   zellij   |    `zjl_`    |      `layouts`      |

> `_` denotes a folder

## 4. Software management

- `init_*`
  - file: install packages/extensions by Oxidizer defaults
- `up_*`
  - file: install packages/extensions by predefined files in `$BACKUP`
- `back_*`
  - file: export package/extension info to `$BACKUP` folder

`init_*` works for `brew`, `scoop`, `conda`, `vscode`, `espanso`; `up_*` and `back_*` work for `brew`, `scoop`, `conda`, `vscode`, `espanso`, `julia`, `texlive`, `node`.

### 4.1. TeXLive

## 5. Package Management

Oxidizer aims to provide a unified interface for all package manager-related commands to reduce typing and memory burden of command-line users.

|        |   Action    | brew [b] | scoop [s] | conda [c] | npm [n] | cargo [cg] | rustup [rs] | gem [rb] | julia [jl] | conan [cn] | tlmgr [tl] |
| :----: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | -------- | :--------: | :--------: | :--------: |
|  `*h`  |    help     |    ✅    |           |    ✅     |   ✅    |     ✅     |     ✅      | ✅       |     ✅     |     ✅     |     ✅     |
| `*cf`  |   config    |    ✅    |           |    ✅     |   ✅    |            |             |          |            |            |            |
| `*is`  |   install   |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      | ✅       |     ✅     |     ✅     |     ✅     |
| `*us`  |  uninstall  |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      | ✅       |     ✅     |     ✅     |     ✅     |
| `*up`  |   update    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      | ✅       |     ✅     |     ✅     |     ✅     |
| `*ups` | update self |    ✅    |    ✅     |           |         |            |             |          |            |            |     ✅     |
| `*ls`  |    list     |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |     ✅      | ✅       |     ✅     |     ✅     |     ✅     |
| `*lv`  |   leaves    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |          |     ✅     |            |            |
| `*sc`  |   search    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |          |            |     ✅     |            |
| `*cl`  |    clean    |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |          |     ✅     |            |            |
| `*if`  |    info     |    ✅    |    ✅     |    ✅     |   ✅    |            |             |          |            |     ✅     |     ✅     |
| `*st`  |   status    |    ✅    |    ✅     |           |   ✅    |            |             |          |     ✅     |            |            |
| `*ck`  |    check    |    ✅    |    ✅     |           |   ✅    |     ✅     |     ✅      |          |            |            |     ✅     |
| `*pn`  |     pin     |    ✅    |    ✅     |           |         |            |             |          |     ✅     |            |            |
| `*upn` |    unpin    |    ✅    |    ✅     |           |         |            |             |          |     ✅     |            |            |
| `*dp`  |   depends   |    ✅    |    ✅     |    ✅     |         |            |             |          |     ✅     |            |            |
| `*xa`  |  add repo   |    ✅    |    ✅     |    ✅     |         |            |             |          |            |
| `*xrm` | remove repo |    ✅    |    ✅     |    ✅     |         |            |             |          |            |
| `*xls` |  list repo  |          |           |    ✅     |         |            |             |          |            |

Particularly, Oxidizer provides with two groups of experimental functions with suffix `p` for installing and downloading packages in parallel

- brew: `bisp`, `biscp`, `bupp`, `bupap`
- scoop: `sisp`, `supp`

For example, when you have more than 1 packages to install, instead of using `bis [pkg1] [pkg1]`, you can use `bisp [pkg1] [pkg1]` then the packages will be downloaded and installed in parallel.

Similarly, `biscp`, `bupp`, `bupap` are the parallel version of `bisc`, `bup`, `bupa`, respectively.

Before using parallel functions, `pueue` service need to be enabled by

```bash
# All OS
pueued -d
# or macOS / Linux
bss pu
```

Some package managers also have functionality of project management

|       | Action  | brew [b] | scoop [s] | conda [c] | npm [n] | cargo [cg] | rustup [rs] | julia [jl] | conan [cn] | flatpak [f] |
| :---: | :-----: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: | ----------- |
| `*ii` |  init   |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     | ✅          |
| `*b`  |  build  |          |           |           |         |     ✅     |             |     ✅     |     ✅     | ✅          |
| `*r`  |   run   |          |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |            | ✅          |
| `*e`  |  edit   |    ✅    |           |           |   ✅    |            |             |            |            |             |
| `*ts` |  test   |    ✅    |           |           |   ✅    |     ✅     |             |     ✅     |     ✅     |             |
| `*pb` | publish |          |           |           |   ✅    |     ✅     |             |            |            |             |

Some of the package managers shortcuts are included in corresponding system plugins.

- `ox-macos` [oxpm]: autoloaded, contains `mas`.
- `ox-apt` [oxpa]: autoloaded
- `ox-windows` [oxpw]: autoloaded, contains `winget`, `wsl`
- `ox-zap` [oxzp]: autoloaded
- `ox-flatpak` [oxpf]: optional

|        |   Action    | mas [m] | apt [a] | zap [zp] | flatpak [f] | winget [w] | wsl [wl] |
| :----: | :---------: | :-----: | :-----: | :------: | :---------: | :--------: | :------: |
|  `*h`  |    help     |   ✅    |   ✅    |          |             |     ✅     |    ✅    |
| `*is`  |   install   |   ✅    |   ✅    |    ✅    |     ✅      |     ✅     |    ✅    |
| `*us`  |  uninstall  |   ✅    |   ✅    |    ✅    |     ✅      |     ✅     |          |
| `*up`  |   update    |   ✅    |   ✅    |          |             |     ✅     |    ✅    |
| `*ups` | update self |         |   ✅    |          |             |     ✅     |    ✅    |
| `*ls`  |    list     |         |   ✅    |    ✅    |     ✅      |     ✅     |    ✅    |
| `*lv`  |   leaves    |         |         |          |             |            |          |
| `*sc`  |   search    |   ✅    |   ✅    |          |     ✅      |            |          |
| `*cl`  |    clean    |         |   ✅    |          |             |            |          |
| `*if`  |    info     |   ✅    |   ✅    |          |     ✅      |     ✅     |          |
| `*st`  |   status    |   ✅    |         |          |             |            |          |
| `*ck`  |    check    |         |   ✅    |          |     ✅      |            |          |
| `*dp`  |   depends   |         |   ✅    |          |             |            |          |
| `*xa`  |  add repo   |         |         |          |     ✅      |            |          |
| `*xrm` | remove repo |         |         |          |     ✅      |            |          |
| `*xls` |  list repo  |         |         |          |     ✅      |            |          |

### 1. Homebrew

- [x] Integrated `aria2` to download Homebrew Casks (require `aria2` installed)
- [x] Enable Homebrew installation by using pre-download installers

- `bis`: brew install
- `bris`: brew reinstall

suffix `c` is a flag to specify brew commands only work on casks

- `bisc`: brew install --cask
- `brisc`: brew reinstall --cask
- `bupc`: brew upgrade --cask

suffix `a` is for `all` which will force brew to upgrade every cask including ones with `auto_update` flags

- `bupa`: brew upgrade --greedy

- `bdl`: download brew cask by `aria2`
- `brp`: replace brew cache file by pre-downloaded file
- `bmr`: using brew mirror
- `bmrq`: reset brew git source to official repositories, `q` is for quit.

### 2. Conda

Note that the conda plugin is based on `mamba` (a parallel version of conda) and `conda-tree`, so you need to install mamba by

```bash
conda install -c conda-forge mamba conda-tree
```

Besides the shortcuts mentioned above in `6. Package Management`, the conda plugin also provides with Conda environment management shortcuts which start with `ce`

- `ceat`: activate environment
  - `$1` length = 0: activate `base` env
  - `$1` length = 1 or 2: activate predefined env `Conda_Env`
  - `$1` length > 2: activate new env

`Conda_Env` can be personalized in `custom.sh`

For example, assume your environment's name is `hello`, you can set

```bash
# macOS / Linux
Conda_Env[h]="hello"
# Windows
$Global:Conda_Env.h = "hello"
```

then, you will be able to manipulate the environment by

```bash
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
- `ceep`: export environment

## 1. Service Management

Oxidizer's task & service management follows the same philosophy of package management, _i.e._ to provide unified interfaces to facilitate workflows.

|        |    Action    | pueue [pu] | espanso [es] | docker<br>container [dc] | podman<br>container [pc] | brew<br>services [bs] |
| :----: | :----------: | :--------: | :----------: | :----------------------: | :----------------------: | :-------------------: |
|  `*h`  |     help     |     ✅     |      ✅      |            ✅            |            ✅            |          ✅           |
| `*df`  |     diff     |            |              |            ✅            |            ✅            |
| `*cl`  |    clean     |     ✅     |      ✅      |            ✅            |            ✅            |
| `*ls`  |     list     |            |      ✅      |            ✅            |            ✅            |
| `*st`  |    status    |     ✅     |      ✅      |            ✅            |            ✅            |                       |
|  `*s`  |    start     |     ✅     |      ✅      |            ✅            |            ✅            |          ✅           |
| `*rs`  |   restart    |     ✅     |      ✅      |            ✅            |            ✅            |          ✅           |
| `*pa`  |    pause     |     ✅     |              |            ✅            |            ✅            |
| `*upa` |   unpause    |            |              |            ✅            |            ✅            |
| `*pa`  |    pause     |     ✅     |              |            ✅            |            ✅            |
|  `*q`  | kill / stop  |     ✅     |      ✅      |            ✅            |            ✅            |          ✅           |
| `*rt`  |    reset     |     ✅     |              |                          |                          |
|  `*a`  | add / create |     ✅     |      ✅      |            ✅            |            ✅            |                       |
| `*rm`  |    remove    |     ✅     |              |            ✅            |            ✅            |
|  `*e`  |     edit     |     ✅     |      ✅      |                          |                          |                       |
| `*if`  |     info     |            |      ✅      |            ✅            |                          |
|  `*r`  |     run      |            |              |            ✅            |            ✅            |                       |
| `*at`  |    attach    |            |              |            ✅            |            ✅            |                       |

### 1.1. Pueue

### 1.2. Espanso

### 1.3. Homebrew Services

## 2. Project & Software Management

|       | Action | git [g] | docker<br>image [di] | podman<br>image [pi] | bitwarden [bw] |
| :---: | :----: | :-----: | :------------------: | :------------------: | :------------: |
| `*ii` |  init  |   ✅    |                      |                      |                |
| `*df` |  diff  |   ✅    |                      |          ✅          |                |
| `*cl` | clean  |   ✅    |                      |          ✅          |                |
| `*ls` |  list  |         |          ✅          |          ✅          |       ✅       |
| `*st` | status |   ✅    |                      |                      |                |
| `*a`  |  add   |   ✅    |                      |                      |       ✅       |
| `*rm` | remove |         |          ✅          |          ✅          |       ✅       |
| `*pl` |  pull  |   ✅    |          ✅          |          ✅          |       ✅       |
| `*ps` |  push  |   ✅    |          ✅          |          ✅          |                |
| `*cf` | config |   ✅    |                      |                      |       ✅       |

### 2.1. Git

- [x] delete ignored files in `.gitignore`: `gig`
- [x] find fat blob files: `gjk`
- [ ] integration of `git filter-repo` command
  - [x] clean files by size bigger than `gcl -s`
  - [x] clean files by id `gcl -i`
  - [x] clean files by path `gcl -p`

### 2.2. Docker/Podman image

### 2.3. Zellij

## 3. Utility Management

### 3.1. Formats

- [x] Convert markdown: `mdto`
  - [x] to PDF with Unicode (for CJK)

```bash
mdto [filename] [format]
```

## 4. System Management

### 4.1. macOS & Linux

- `update`: update system
- `clean`
  - `clean`: empty trash
  - `clean bdl`: clean `Homebrew` downloaded files
  - `clean cc`: clean cache files in `$HOME/Library/Caches/`
  - `clean log`: clean logs
  - `clean vs`: clean `VSCode` cache files
- `allow`: allow installation of uncertified apps

## 5. Writing A Plugin

A plugin in Oxidizer is referred as Oxygen, a key-value object whose key starts with `oxp`.

For a Vim plugin on macOS / Linux, you can write

```bash
Oxygen[oxpvi]=plugin_path
```

And add the _key of Oxygen_ into `PLUGINS` object in `custom.sh` like

```bash
PLUGINS=(oxp1 oxp2 oxpvi)
```

For Windows users, do these similarly

```powershell
$Global:Oxygen.oxpvi = "plugin_path"
```

And add it into `PLUGINS` object in `custom.ps1`

### 5.1. Config Files

A system / software / tool configuration file in Oxidizer is referred as Element, set it like what you do with Oxygen

```bash
# macOS / Linux
Element[vi]=$HOME/.vimrc
# Windows
$Global:Element.vi = "$HOME/.vimrc"
```

If you need to set a folder in Oxygen, plus a `_` as the suffix of the key.

```bash
# macOS / Linux
Element[vi_]=$HOME/.vim
# Windows
$Global:Element.vi_ = "$HOME/vim"
```

### 1. Backup Files

A backup file in Oxidizer is referred as Oxide whose key starts with `bk`, set it like

```bash
# macOS / Linux
Oxide[bkvi]=$BACKUP/.vimrc
# Windows
$Global:Oxide.bkvi = "$env:BACKUP/.vimrc"
```

Do remember the key in Oxygen, Element, Oxide must be consistent: `oxvi`, `vi`, `bkvi` works, others don't.

## 1. Credits

- [Mario Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- [Mike McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 2. Licence

This work is released under the GPL-v3 licence.
