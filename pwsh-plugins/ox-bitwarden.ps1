##########################################################
# main
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

function bwsy { bw sync }
function bwh { bw --help }
function bwst { bw status --pretty }
