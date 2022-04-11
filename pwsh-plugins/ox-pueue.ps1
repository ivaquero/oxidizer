##########################################################
# config
##########################################################

# oxidizer files
$global:Oxygen.oxpu = "$env:OXIDIZER/defaults/pueue.yml"
$global:Oxygen.oxpua = "$env:OXIDIZER/defaults/pueue_aliases.yml"

# config files
$global:Element.pu = "$env:APPDATA/pueue/pueue.yml"
$global:Element.pual = "$env:APPDATA/Preferences/pueue/pueue_aliases.yml"

# backup files
$global:Oxide.bkpu = "$env:BACKUP/pueue/pueue.yml"
$global:Oxide.bkpua = "$env:BACKUP/pueue/pueue_aliases.yml"

##########################################################
# main
##########################################################

function puh { pueue help }
function pua { pueue add $args }
function purm { pueue remove $args }
function pus { pueue start $args }
function purs { pueue restart $args }
function pupa { pueue pause $args }
function pust { pueue status }
function pucl { pueue clean; pueue status }
function pue { pueue edit }
function puq { pueue kill $args }
function purs { pueue reset }
