##########################################################
# config
##########################################################

function up_bitwarden { bw import $args }
function back_bitwarden { bw export $args }
function bwcf { bw config $args }

##########################################################
# query
##########################################################

function bwsc {
    param ( $cmd, $obj )
    Switch ( $cmd ) {
        -h { bw get --help }
        -u { bw get username $obj }
        -p { bw get password $obj }
        -n { bw get notes $obj }
        Default { bw get item $obj --pretty }
    }
}

function bwst { bw status --pretty }
function bwh { bw --help }

##########################################################
# project management
##########################################################

function bwup { bw sync }

##########################################################
# item management
##########################################################

function bwe {
    param ( $cmd, $obj )
    Switch ( $cmd ) {
        -f { bw edit folder $obj }
        Default { bw edit item $obj }
    }
}

function bwrm {
    param ( $cmd, $obj )
    Switch ( $cmd ) {
        -f { bw delete folder $obj }
        Default { bw delete item $obj }
    }
}

function bwa { bw create $args }
function bwls { bw list $args }
