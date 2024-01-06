## Writing A Plugin

A plugin in Oxidizer is referred as OX_OXYGEN, a key-value object whose key starts with `oxp`.

For a Vim plugin on macOS / Linux, you can write

```sh
OX_OXYGEN[oxpvi]="plugin_path"
```

And add the _key of OX_OXYGEN_ into `OX_PLUGINS` object in `custom.sh` like

```sh
OX_PLUGINS=(oxp1 oxp2 oxpvi)
```

For Windows users, do these similarly

```powershell
$Global:OX_OXYGEN.oxpvi = "plugin_path"
```

And add it into `OX_PLUGINS` object in `custom.ps1`

### Config Files

A system / software / tool configuration file in Oxidizer is referred as `OX_ELEMENT`, set it like what you do with `OX_OXYGEN`

```sh
# macOS / Linux
OX_ELEMENT[vi]=$HOME/.vimrc
# Windows
$Global:OX_ELEMENT.vi = "$HOME/.vimrc"
```

If you need to set a folder in OX*OXYGEN, plus a `*` as the suffix of the key.

```sh
# macOS / Linux
OX_ELEMENT[vi_]=$HOME/.vim
# Windows
$Global:OX_ELEMENT.vi_ = "$HOME/vim"
```

### Backup Files

A backup file in Oxidizer is referred as OX_OXIDE whose key starts with `bk`, set it like

```sh
# macOS / Linux
OX_OXIDE[bkvi]=$OX_BACKUP/.vimrc
# Windows
$Global:OX_OXIDE.bkvi = "$env:OX_BACKUP/.vimrc"
```

Do remember the key in `OX_OXYGEN`, `OX_ELEMENT`, `OX_OXIDE` must be consistent: `oxvi`, `vi`, `bkvi` works, others don't.
