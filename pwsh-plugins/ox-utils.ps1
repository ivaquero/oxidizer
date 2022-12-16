##########################################################
# Configuration File Utils
##########################################################

# export file
# $@=names
function epf {
    $files = $args

    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        $in_path = $Global:OX_ELEMENT.$file
        $out_path = $Global:OX_OXIDE.$bkfile

        if ( [string]::IsNullOrEmpty($out_path) ) {
            Write-Output "$out_path does not exist, please define it in custom.ps1"
        }
        elseif ( $file.EndsWith("_") ) {
            Remove-Item -Recurse $out_path
            Copy-Item -Verbose -Force -Path $in_path -Destination $out_path
        }
        else {
            $parentpath = ( Get-Item $Global:OX_ELEMENT.$file ).DirectoryName
            if (!(Test-Path $parentpath)) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $Global:OX_ELEMENT.$file -Destination $Global:OX_OXIDE.$bkfile
        }
    }
}

# import file: reverse action of `epf`
function ipf {
    $files = $args

    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        $in_path = $Global:OX_OXIDE.$bkfile
        $out_path = $Global:OX_ELEMENT.$file

        if ( $file.EndsWith("_") ) {
            Remove-Item -Recurse $out_path
            Copy-Item -Verbose -Force -Path $in_path -Destination $out_path
        }
        else {
            $parentpath = ( Get-Item $Global:OX_ELEMENT.$file ).DirectoryName
            if (!(Test-Path $parentpath)) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $Global:OX_OXIDE.$bkfile -Destination $Global:OX_ELEMENT.$file
        }
    }
}

# initialize file
function iif {
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        $in_path = $Global:OX_OXYGEN.$oxfile
        $out_path = $Global:OX_ELEMENT.$file

        $parentpath = ( Get-Item $out_path ).DirectoryName
        if ( !(Test-Path $parentpath) ) {
            New-Item -ItemType Directory -Force -Path $parentpath
        }
        Copy-Item -Verbose -Path $in_path -Destination $out_path
    }
}

# duplicate file
function dpf {
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        $bkfile = "bk" + $file
        $in_path = $Global:OX_OXYGEN.$oxfile
        $out_path = $Global:OX_OXIDE.$bkfile

        $parentpath = ( Get-Item $out_path ).DirectoryName
        if ( !(Test-Path $parentpath) ) {
            New-Item -ItemType Directory -Force -Path $parentpath
        }
        Copy-Item -Verbose -Path $in_path -Destination $out_path
    }
}

##########################################################
# Gerneral File Utils
##########################################################

# refresh file
function frf {
    & $profile
}

# browse file
function brf {
    param ( $file )
    if ( $file.EndsWith("_")  ) {
        $cmd = "ls"
    }
    else {
        $cmd = "cat"
    }
    Switch ( $file ) {
        { $file -match "ox\w{1,}" } { . $cmd $Global:OX_OXYGEN.$file }
        { $file -match "bk\w{1,}" } { . $cmd $Global:OX_OXIDE.$file }
        Default { . $cmd $Global:OX_ELEMENT.$file }
    }
}

# edit file by default editor
function edf {
    param ( $file, $mode )
    if ( $mode -eq "-t" ) { $cmd = $env:EDITOR_T }
    else { $cmd = $env:EDITOR }

    Switch ( $file ) {
        { $file -match "ox[a-z]{1,}" } { . $cmd $Global:OX_OXYGEN.$file }
        { $file -match "bk[a-z]{1,}" } { . $cmd $Global:OX_OXIDE.$file }
        Default { . $cmd $Global:OX_ELEMENT.$file }
    }
}

##########################################################
# Zip Files
##########################################################

function zpf { ouch compress $args }
function uzpf { ouch decompress $args }
function lzpf { ouch list $args }

##########################################################
# Batch Management
##########################################################

# $1=old, $2=new, $3=path
function replace {
    param ( $old, $new, $path )
    sd "$old" "$new" $(fd "$path")
}

##########################################################
# OX_PROXY utils
##########################################################

# proxy
function px {
    param ( $the_port )
    if ( $( $the_port | Measure-Object -Character).Character -lt 2 ) {
        $port = $Global:OX_PROXY.$the_port
    }
    else {
        $port = $the_port
    }
    Write-Output "using port $($Global:OX_PROXY.$the_port)"
    $env:https_proxy = "http://127.0.0.1:$port"
    $env:http_proxy = "http://127.0.0.1:$port"
    $env:all_proxy = "socks5://127.0.0.1:$port"
}

function pxq {
    Write-Output 'unset all proxies'
    $env:https_proxy = ''
    $env:http_proxy = ''
    $env:all_proxy = ''
}
