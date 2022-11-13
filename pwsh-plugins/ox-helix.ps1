##########################################################
# config
##########################################################

$Global:Oxygen.oxhx = "$env:OXIDIZER\defaults\helix.toml"
# config files
$Global:Element.hx = "$env:APPDATA\helix\config.toml"
$Global:Element.hxl = "$env:APPDATA\helix\languages.toml"

##########################################################
# main
##########################################################

function hxt { hx --tutor }
