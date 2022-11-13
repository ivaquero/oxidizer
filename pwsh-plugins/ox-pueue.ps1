##########################################################
# config
##########################################################

$Global:Element.pu = "$env:APPDATA\pueue\pueue.yml"
$Global:Element.pua = "$env:APPDATA\pueue\pueue_aliases.yml"

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

function puh { pueue help $args }
function pue { pueue edit $args }
function purs { pueue reset }
