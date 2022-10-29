##########################################################
# config
##########################################################

##########################################################
# packages
##########################################################

function rbh { gem help }
function rbis { gem install }
function rbus { gem uninstall }
function rbup { gem update }

function rbls {
    if ([string]::IsNullOrEmpty($the_env)) { gem list --local }
    else { gem list }
}

##########################################################
# project
##########################################################

function rbb { gem build }
