## Writing A Plugin

A plugin in oxidizer is referred as OX_OXYGEN, a key-value object whose key starts with `oxp`.

For a Neovim plugin, in `config.json`, write

```json
{
    "ox_plugins_plus": {
        "cli_neovim": "plugin_path"
    }
}
```

And add the key of OX_OXYGEN into `OX_PLUGINS` object

```json
{
    "plugin_load": [
        "cli_neovim"
    ]
}
```

### Config Files

A system / software / tool configuration file in oxidizer is referred as `OX_ELEMENT`, set it like what you do with `OX_OXYGEN`

```sh
# macOS / Linux
OX_ELEMENT[nvi]=$HOME/.config/nvim/lua/config/init.lua
# Windows
$Global:OX_ELEMENT.vi = "$HOME/.config/nvim/lua/config/init.lua"
```

If you need to set a folder in OX_OXYGEN, plus a `_` as the suffix of the key.

```sh
# macOS / Linux
OX_ELEMENT[nvi_]=$HOME/.config/nvim
# Windows
$Global:OX_ELEMENT.nvi_ = "$HOME/.config/nvim"
```

### Backup Files

A backup file in oxidizer is referred as OX_OXIDE, in `config.json`, set it like

```json
{
    "ox_oxide": {
        "vi": ".vimrc"
    }
}
```

Do remember the key in `OX_OXYGEN`, `OX_ELEMENT`, `OX_OXIDE` must be identical.
