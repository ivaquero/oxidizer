# config files
Element[nvv]=$HOME/.config/nvim/init.vim
Element[nv]=$HOME/.config/nvim/lua/init.lua
Element[nvp]=$HOME/.config/nvim/lua/plugins.lua

# backup files
Oxide[bknvv]=$BACKUP/nvim/init.vim
Oxide[bknv]=$BACKUP/nvim/init.lua
Oxide[bknvp]=$BACKUP/nvim/plugins.lua

if [[ ! -d $BACKUP/nvim ]]; then
    mkdir -p $BACKUP/nvim
fi
