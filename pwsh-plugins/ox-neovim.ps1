# config files
$global:Element.nvv = "$env:BASE/.config/nvim/init.vim"
$global:Element.nv = "$env:BASE/.config/nvim/lua/init.lua"
$global:Element.nvp = "$env:BASE/.config/nvim/lua/plugins.lua"

# backup files
$global:Oxide.bknv = "$env:BACKUP/nvim/init.lua"
$global:Oxide.bknvp = "$env:BACKUP/nvim/plugins.lua"

if ( !(Test-Path "$env:BACKUP/nvim") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP/nvim"
}
