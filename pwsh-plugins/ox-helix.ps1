##########################################################
# config
##########################################################

# oxidizer files
$Global:Oxygen.oxhx = "$env:OXIDIZER\defaults\helix.toml"
# config files
$Global:Element.hx = "$env:APPDATA\.config\helix\config.toml"
$Global:Element.hxl = "$env:APPDATA\.config\helix\languages.toml"

##########################################################
# main
##########################################################

function hxt { hx --tutor }
