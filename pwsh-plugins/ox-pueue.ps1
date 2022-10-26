##########################################################
# config
##########################################################

# oxidizer files
$Global:Oxygen.oxpu = "$env:OXIDIZER\defaults\pueue.yml"
# config files
$Global:Element.pu = "$env:APPDATA\pueue\pueue.yml"
$Global:Element.pual = "$env:APPDATA\Preferences\pueue\pueue_aliases.yml"
# backup files
$Global:Oxide.bkpu = "$env:BACKUP\pueue\pueue.yml"
$Global:Oxide.bkpua = "$env:BACKUP\pueue\pueue_aliases.yml"

##########################################################
# management
##########################################################

function pus { pueue start $args }
function purs { pueue restart $args }
function pua { pueue add $args }
function purm { pueue remove $args }
function pupa { pueue pause $args }
function pust { pueue status }
function pucl { pueue clean; pueue status }
function puq { pueue kill $args }

##########################################################
# main
##########################################################

function puh { pueue help }
function pue { pueue edit $args }
function purs { pueue reset }
