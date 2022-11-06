##########################################################
# Configuration File Utils
##########################################################

# export file
# $@=names
function epf {
    Write-Output "Overwrite Oxide by Element"
    $files = $args
    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        if ( [string]::IsNullOrEmpty($Global:Oxide.$bkfile) ) {
            Write-Output "$Global:Oxide.$bkfile does not exist, please define it in custom.ps1"
        }
        elseif ( $file.EndsWith("_") ) {
            $folder = ls $Global:Element.$file
            ForEach ( $subfile in $folder ) {
                $in_file = $Global:Element.$file + '\\' + $subfile
                $out_file = $Global:Oxide.$bkfile + '\\' + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $Global:Element.$file ).DirectoryName
            if (!(Test-Path $parentpath)) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $Global:Element.$file -Destination $Global:Oxide.$bkfile
        }
    }
}

# import file: reverse action of `epf`
function ipf {
    Write-Output "Overwrite Element by Oxide"
    $files = $args
    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $Global:Oxide.$bkfile
            ForEach ( $subfile in $folder ) {
                $in_file = $Global:Oxide.$bkfile + '\\' + $subfile
                $out_file = $Global:Element.$file + '\\' + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $Global:Element.$file ).DirectoryName
            if (!(Test-Path $parentpath)) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $Global:Oxide.$bkfile -Destination $Global:Element.$file
        }
    }
}

# initialize file
function iif {
    Write-Output "Overwrite Element by Oxygen"
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $Global:Oxygen.$oxfile
            ForEach ( $subfile in $folder ) {
                $in_file = $Global:Oxygen.$oxfile + '\\' + $subfile
                $out_file = $Global:Element.$file + '\\' + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $Global:Element.$file ).DirectoryName
            if ( !(Test-Path $parentpath) ) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $Global:Oxygen.$oxfile -Destination $Global:Element.$file
        }
    }
}

# duplicate file
function dpf {
    Write-Output "Overwrite Element by Oxygen"
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        $bkfile = "bk" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $Global:Oxygen.$oxfile
            ForEach ( $subfile in $folder ) {
                $in_file = $Global:Oxygen.$oxfile + '\\' + $subfile
                $out_file = $Global:Oxide.$bkfile + '\\' + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $Global:Oxide.$bkfile ).DirectoryName
            if ( !(Test-Path $parentpath) ) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $Global:Oxygen.$oxfile -Destination $Global:Oxide.$bkfile
        }
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
        { $file -match "ox\w{1,}" } { . $cmd $Global:Oxygen.$file }
        { $file -match "bk\w{1,}" } { . $cmd $Global:Oxide.$file }
        Default { . $cmd $Global:Element.$file }
    }
}

# edit file by default editor
function ef {
    param ( $file, $mode )
    if ( $mode -eq "-t" ) { $cmd = $env:EDITOR_T }
    else { $cmd = $env:EDITOR }

    Switch ( $file ) {
        { $file -match "ox[a-z]{1,}" } { . $cmd $Global:Oxygen.$file }
        { $file -match "bk[a-z]{1,}" } { . $cmd $Global:Oxide.$file }
        Default { . $cmd $Global:Element.$file }
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
# Proxy utils
##########################################################

# proxy
function px {
    param ( $the_port )
    if ( $( $the_port | Measure-Object -Character).Character -lt 2 ) {
        $port = $Global:Proxy.$the_port
    }
    else {
        $port = $the_port
    }
    Write-Output "using port $Global:Proxy.$the_port"
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
