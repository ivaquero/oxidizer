##########################################################
# Configuration File Utils
##########################################################

# export file
# $@=names
function epf {
    Write-Output "Overwrite OX_OXIDE by Element"
    $files = $args
    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        if ( [string]::IsNullOrEmpty($Global:OX_OXIDE.$bkfile) ) {
            Write-Output "$Global:OX_OXIDE.$bkfile does not exist, please define it in custom.ps1"
        }
        elseif ( $file.EndsWith("_") ) {
            $in_folder = $Global:OX_ELEMENT.$file
            $out_folder = $Global:OX_OXIDE.$bkfile
            Remove-Item -Recurse $out_folder
            Copy-Item -Verbose -Force -Path $in_folder -Destination $out_folder
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
    Write-Output "Overwrite Element by OX_OXIDE"
    $files = $args
    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $Global:OX_OXIDE.$bkfile
            ForEach ( $subfile in $folder ) {
                $in_file = $Global:OX_OXIDE.$bkfile + '\\' + $subfile
                $out_file = $Global:OX_ELEMENT.$file + '\\' + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
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
    Write-Output "Overwrite Element by OX_OXYGEN"
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        $parentpath = ( Get-Item $Global:OX_ELEMENT.$file ).DirectoryName
        if ( !(Test-Path $parentpath) ) {
            New-Item -ItemType Directory -Force -Path $parentpath
        }
        Copy-Item -Verbose -Path $Global:OX_OXYGEN.$oxfile -Destination $Global:OX_ELEMENT.$file
    }
}

# duplicate file
function dpf {
    Write-Output "Overwrite Element by OX_OXYGEN"
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        $bkfile = "bk" + $file
        $parentpath = ( Get-Item $Global:OX_OXIDE.$bkfile ).DirectoryName
        if ( !(Test-Path $parentpath) ) {
            New-Item -ItemType Directory -Force -Path $parentpath
        }
        Copy-Item -Verbose -Path $Global:OX_OXYGEN.$oxfile -Destination $Global:OX_OXIDE.$bkfile
    }
}

##########################################################
# Gerneral File Utils
##########################################################

# refresh file
function ff {
    & $profile
}

# browse file
function bf {
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
function ef {
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
