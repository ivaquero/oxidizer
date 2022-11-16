# Oxidizer

基于 Rust 工具链的简单 & 可扩展 Dotfile 管理方案（欢迎 PR 和 Fork）

## 1. 从这里开始

对 macOS / Linux (Intel)

```bash
git clone --depth=1 https://github.com/ivaquero/oxidizer.git $OXIDIZER && bash $OXIDIZER/install.sh

# 自定义安装路径
export OXIDIZER=$HOME/oxidizer
```

- 对中国大陆用户，可设置 `BREW_CN` 变量来下载安装 Homebrew：

```bash
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

```bash
ef ox
```

可使用 `upox` 命令来更新 Oxidizer

## 2. Oxidizer 的主要目标

- 跨平台（主要基于 Rust 工具链）
- 最少依赖 & 最少安装
- 可扩展架构
- 统一接口 & 丝滑操作
- 超级快！（当前载入时间 < 1 秒）

## 3. 氧化进度

### 3.1. 命令行替换（推荐以下所有）

☑️ 表示默认安装

- [x] 使用 `bat` 替换 `cat`
- [x] 使用 `dust` 替换 `du`
- [x] 使用 `fd` 替换 `find`
- [x] 使用 `lsd --tree` 替换 `tree`
- [x] 使用 `lsd` 替换 `ls`
- [x] 使用 `ripgrep` 替换 `grep`
- [x] 使用 `sd` 替换 `sed`
- [x] 使用 `tealdeer` 替换 `tldr` 和 `man`
- [x] 使用 `zoxide` 替换 `cd` 和 `z.lua`
- [ ] 使用 `tokei` 替换 `cloc`
- [ ] 使用 `starship` 替换 `powerline10k` 和 `ohmyposh`
- [ ] 使用 `tectonic` 替换 `xetex` 和 `xelatex`

### 3.2. 软件替换

- [x] 使用 `gitui` 替换 `lazygit`
- [x] 使用 `bottom` 替换 `top` 和 `htop`
- [ ] 使用 `wezTerm` 或 `alacritty` 替换 `iterm2` 和 `windows terminal`
- [ ] 使用 `helix` 替换 `neovim`
- [ ] 使用 `zellij` 替换 `tmux`（目前不支持 Windows）
- [ ] 使用 `joshuto` 替换 `ranger`（目前不支持 Windows）

> `Nushell` 是一个 Rust 编写的全平台 Shell，但其目前不支持动态地址，而且其插件只支持 Rust 和 Python，而不是其内置的 Nu 语言。

### 3.3. 其他实用的 Rust 工具

- [x] `pueue`：命令行并行任务管理器
- [x] `hyperfine`：命令行性能测试工具
- [ ] `navi`：交互式命令行工具小抄
- [ ] `espanso`：输入法扩展器（推荐尝试）

### 3.4. 插件总结

|     |                      Plugin                       | Linux | macOS | Windows | Autoload？ |
| :-: | :-----------------------------------------------: | :---: | :---: | :-----: | :--------: |
|  1  |     [Brew](https://github.com/Homebrew/brew)      |  ✅   |  ✅   |   ❌    |     ✅     |
|  2  | [Scoop](https://github.com/ScoopInstaller/Scoop)  |  ❌   |  ❌   |   ✅    |     ✅     |
|  3  |     [Zap](https://github.com/srevinsaju/zap)      |  ✅   |  ❌   |   ❌    |     ✅     |
|  4  |     [Pueue](https://github.com/Nukesor/pueue)     |  ✅   |  ✅   |   ✅    |     ✅     |
|  5  |                      System                       |  ✅¹  |  ✅   |   ✅    |     ✅     |
|  6  |                      Utility                      |  ✅   |  ✅   |   ✅    |     ✅     |
|  7  |            [Git](https://git-scm.com/)            |  ✅   |  ✅   |   ✅    |            |
|  8  | [Bitwarden](https://github.com/bitwarden/clients) |  🕒   |  🕒   |   🕒    |            |
|  9  |    [Conan](https://github.com/conan-io/conan)     |  ✅   |  ✅   |   ✅    |            |
| 10  |      [Conda](https://github.com/conda/conda)      |  ✅   |  ✅   |   ✅    |            |
| 11  |           [Docker](https://docker.com/)           |  ✅   |  ✅   |   ✅    |            |
| 12  |    [Julia](https://github.com/JuliaLang/julia)    |  ✅   |  ✅   |   🚧    |            |
| 13  |   [Jupyter](https://github.com/jupyter/jupyter)   |  ✅   |  ✅   |   ✅    |            |
| 14  |      [Node](https://github.com/nodejs/node)       |  ✅   |  ✅   |   🚧    |            |
| 15  |  [Podman](https://github.com/containers/podman)   |  ✅   |  ✅   |   ✅    |            |
| 16  |          [Ruby](https://ruby-lang.org/)           |  🕒   |  🕒   |   🕒    |            |
| 17  |     [Rust](https://github.com/rust-lang/rust)     |  ✅   |  ✅   |   ✅    |            |
| 18  |   [Espanso](https://github.com/espanso/espanso)   |  ✅   |  ✅   |   ✅    |            |
| 19  |        [TeXLive](https://tug.org/texlive/)        |  ✅   |  ✅   |   ✅    |            |
| 20  |   [VSCode](https://github.com/microsoft/vscode)   |  ✅   |  ✅   |   ✅    |            |
| 21  |                      Formats                      |  🕒   |  🕒   |   🕒    |            |
| 22  |  [Helix](https://github.com/helix-editor/helix)   |  🕒   |  🕒   |   🕒    |            |

✅：完整功能
🚧：部分功能
🕒：基础功能，有待补充
❌：不存在

> ¹：目前在 Linux 只提供 Debian 系的相关快捷操作

Oxidizer 通过 Homebrew 或 Scoop 管理包和软件，以绕过管理员权限的要求。

## 4. 文件管理

![design](https://raw.githubusercontent.com/ivaquero/blog-bio/master/tutorials/images/cmd/oxidizer-design.png)

- `ff`
  - 通过 `source` 刷新
- `ef`
  - 通过 `$EDITOR` 编辑（默认：VSCode）
- `bf`
  - 通过 `bat`/`cat` 浏览文件
  - 文件夹：通过 `lsd`/`ls` 浏览
- `ipf`
  - 文件：在 `$OX_OXYGEN` 中覆盖对应的 `$OX_ELEMENT` 文件配置
- `epf`
  - 文件：在 `$OX_ELEMENT` 中覆盖对应的 `$OX_OXYGEN` 文件配置

例如，当你想编辑 `~/.zshrc`，键入 `ef zs`。

当你使用 `epf zs`，`~/.zshrc` 会被复制并保存到 `$OX_BACKUP/shell` 文件夹。其中，`$OX_BACKUP` 是可以在 `$OXIDIZER/custom.sh` 中自定义的备份路径。通过 `epf ox` 即可轻松打开 `custom.sh` 文件。

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
|     conan      |  `cn`  |          `default`           |
|     conan      | `cnr`  |        `remote.json`         |
|    espanso     |  `es`  |        `default.yml`         |
|    espanso     | `esx`  |       `match/base.yml`       |
|    espanso     | `esx_` |       `match/packages`       |
|     helix      |  `hx`  |        `config.toml`         |
|     helix      | `hxl`  |       `languages.toml`       |
|     julia      |  `jl`  |       `julia-pkgs.txt`       |
|     julia      | `jls`  |         `startup.jl`         |
|     julia      | `jlp`  |        `Project.toml`        |
|     julia      | `jlm`  |       `Manifest.toml`        |
|    jupyter     |  `jn`  | `jupyter_notebook_config.py` |
|     latex      |  `tl`  |        `texlive-pkgs`        |
|      node      |  `nj`  |       `node-pkgs.txt`        |
|     pueue      |  `pu`  |         `pueue.yml`          |
|     pueue      | `pua`  |     `pueue_aliases.yml`      |
|     cargo      |  `cg`  |            `env`             |
|     cargo      | `cg_`  |           `.cargo`           |
|     vscode     |  `vs`  |       `settings.json`        |
|     vscode     | `vsk`  |      `keybindings.json`      |
|     vscode     | `vss_` |          `snippets`          |
|     vscode     | `vsx`  |      `vscode-pkgs.txt`       |
|     winget     |  `w`   |        `winget.json`         |

## 5. 软件管理

- `init_*`
  - 文件：安装 Oxidizer 自带的配置文件，
- `up_*`
  - 文件：安装自定义文件夹 `$OX_BACKUP` 中的配置文件
- `back_*`
  - 文件：将配置文件保存至自定义文件夹 `$OX_BACKUP`

`init_*` 适用于 `brew`，`scoop`，`conda`；`up_*`和`back_*`适用于`brew`，`scoop`，`conda`，`vscode`，`espanso`，`julia`，`texlive`，`node`

### 5.1. VSCode

## 6. 包管理

Oxidizer 致力于为各个包管理器提供统一的接口，以减轻敲击和记忆负担。

|        |    操作     | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | gem `gm` | julia `jl` | conan `cn` | tlmgr `tl` |
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

特别地，Oxidizer 提供两组后缀为`p`的实验性函数，用于并行安装和下载软件包

- brew：`bisp`, `biscp`, `bupp`, `bupap`
- scoop：`sisp`, `supp`

例如，当需要安装 2 个及以上的包时，可以使用 `bisp [pkg1] [pkg1]` 代替 `bis [pkg1] [pkg1]`，进行并行下载安装。

同理，`biscp`, `bupp`, `bupap` 分别为 `bisc`, `bup`, `bupa` 的并行版本。

使用并行功能前，需要启动 pueue 服务

```bash
# All OS
pueued -d
# or macOS / Linux
bss pu
```

一些包管理器还有项目管理功能

|       |  对应操作   | brew `b` | scoop `s` | conda `c` | npm `n` | cargo `cg` | rustup `rs` | julia `jl` | conan `cn` |
| :---: | :---------: | :------: | :-------: | :-------: | :-----: | :--------: | :---------: | :--------: | :--------: |
| `*ii` | init/create |    ✅    |    ✅     |    ✅     |   ✅    |     ✅     |             |            |     ✅     |
| `*b`  |    build    |          |           |           |         |     ✅     |             |     ✅     |     ✅     |
| `*r`  |     run     |          |           |    ✅     |   ✅    |     ✅     |     ✅      |     ✅     |            |
| `*e`  |    edit     |    ✅    |           |           |   ✅    |            |             |            |            |
| `*ts` |    test     |    ✅    |           |           |   ✅    |     ✅     |             |     ✅     |     ✅     |
| `*pb` |   publish   |          |           |           |   ✅    |     ✅     |             |            |            |

部分快捷命令被包含在对应的系统扩展中

- `ox-macos` `oxpm`：自启动，包含 `mas`
- `ox-apt` `oxpa`：自启动，包含 `apt`
- `ox-windows` `oxpw`：自启动，包含 `winget`、`wsl`·
- `ox-flatpak` `oxpf`：可选

|        |  对应操作   | mas `m` | apt `a` | flatpak `f` | winget `w` | wsl `wl` |
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

### 6.1. Homebrew 管理

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

### 6.2. Conda 环境管理

请注意，Conda 插件基于 `mamba` 和 `conda-tree` 包，需要预先安装

```bash
conda install -c conda-forge mamba conda-tree
```

除了上面 `6. 包管理` 提及的 Conda 命令，Conda 插件还提供了 Conda 环境管理的快捷命令，均以 `ce` 开头

- `ceat`：激活环境
  - 变量长度 = 0：激活 `环境`
  - 变量长度 = 1 或 2：激活 `custom.sh` 中的预定义环境 `OX_CONDA_ENV`
  - 变量长度 > 2：激活指定环境
- `cerat`：重新激活环境，使用同 `ceat`
- `ceq`：退出环境
- `cerm`：删除环境，使用同 `ceat`，但不会删除 `base` 环境
- `cesd`：更改 conda-forge 子目录
  - `i`：使用 `x86_64`（M1 罗塞塔转译）环境
  - 非 `i`：使用 `arm64` 环境
- `ceep`：导出环境信息，同 `conda env export environment`

## 7. 服务管理

|        |   对应操作   | pueue `pu` | espanso `es` | docker<br>container `dc` | podman<br>container `pc` | brew<br>services `bs` |
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

### 7.1. Pueue

### 7.2. Espanso

### 7.3. Homebrew Services

## 8. 项目 & 软件管理

|       | 对应操作 | git `g` | docker<br>image `di` | podman<br>image `pi` | bitwarden `bw` |
| :---: | :------: | :-----: | :------------------: | :------------------: | :------------: |
| `*ii` |   init   |   ✅    |                      |                      |                |
| `*df` |   diff   |   ✅    |                      |          ✅          |                |
| `*cl` |  clean   |   ✅    |                      |          ✅          |                |
| `*ls` |   list   |         |          ✅          |          ✅          |       ✅       |
| `*st` |  status  |   ✅    |                      |                      |                |
| `*a`  |   add    |   ✅    |                      |                      |       ✅       |
| `*rm` |  remove  |         |          ✅          |          ✅          |       ✅       |
| `*pl` |   pull   |   ✅    |          ✅          |          ✅          |       ✅       |
| `*ps` |   push   |   ✅    |          ✅          |          ✅          |                |
| `*cf` |  config  |   ✅    |                      |                      |       ✅       |

### 8.1. Git

- [x] delete ignored files in `.gitignore`: `gig`
- [x] find fat blob files: `gjk`
- [ ] integration of `git filter-repo` command
  - [x] clean files by size bigger than `gcl -s`
  - [x] clean files by id `gcl -i`
  - [x] clean files by path `gcl -p`

### 8.2. Docker image

## 9. 工具管理

### 9.1. Formats

- [x] 转换 markdown
  - [x] 转换至含有 Unicode 的 PDF（中文）

```bash
mdto `文件名` `格式`
```

## 10. 系统管理

### 10.1. macOS & Linux

- `update`：更新系统
- `clean`：
  - `clean`：清理垃圾
  - `clean bdl`：清理 Homebrew 下载文件
  - `clean log`：清理日志
  - `clean cc`：清理缓存
  - `clean vs`：清理 VSCode 缓存
- `allow`：允许运行非官方来源 App

### 10.2. Linux

## 11. 自定义插件

## 12. 致谢

- `Mario`Catuogno's Clean-macOS](https://github.com/MarioCatuogno/Clean-macOS)
- `Mike`McQuaid's dotfiles](https://github.com/MikeMcQuaid/dotfiles)

## 13. 许可

这个项目在 GPL-v3 许可下发布
