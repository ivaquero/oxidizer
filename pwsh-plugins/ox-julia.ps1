##########################################################
# config
##########################################################

if (Get-Command julia -ErrorAction SilentlyContinue) {
    $Global:OX_ELEMENT.jl = "$HOME\.julia\config\startup.jl"
    $Global:OX_ELEMENT.jlm = "$HOME\.julia\environments\v$(julia -v | rg --only-matching '\d.\d')\Manifest.toml"
    $Global:OX_ELEMENT.jlp = "$HOME\.julia\environments\v$(julia -v | rg --only-matching '\d.\d')\Project.toml"
}

function up_julia {
    echo "Update Julia by $($Global:OX_OXIDE.bkjlx)"
    $pkgs = (cat $($Global:OX_OXIDE.bkjlx) | sd '`n' '\", \"')
    $pkgs_vec = echo [`"$pkgs`"] | sd '\[' '[\"' | sd ', \"]' ']'
    $cmd = echo "using Pkg; Pkg.add($pkgs_vec)"
    julia --eval `"$cmd`"
}

function back_julia {
    echo "Backup Julia to $($Global:OX_OXIDE.bkjlx)"
    cat $Global:OX_ELEMENT.jlp | rg --only-matching '\w.*=' | sd '[= ]' ' ' > "$($Global:OX_OXIDE.bkjlx)"
}

##########################################################
# packages
##########################################################

function jl {
    julia --quiet
}
function jlh {
    julia --help
}
function jlr {
    param ( $cmd )
    julia --eval $cmd
}
function jlcl {
    julia --eval 'using Pkg; Pkg.gc()'
}
function jlst {
    julia --eval 'using Pkg; Pkg.status()'
}


# install packages
function jlis {
    $pkgs = (echo `"$args`" | sd ' ' '\", \"')
    $cmd = (echo "using Pkg; Pkg.add([$pkgs])")
    # echo "$cmd"
    julia --eval `"$cmd`"
}

# uninstall packages
function jlus {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.rm([$pkgs])")
    # echo "$cmd"
    julia --eval `"$cmd`"
}

# update packages
function jlup {
    if ([string]::IsNullOrEmpty($args)) {
        julia --eval 'using Pkg; Pkg.update()'
    }
    else {
        $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
        $cmd = $(echo "using Pkg; Pkg.update([$pkgs])")
        # echo "$cmd"
        julia --eval `"$cmd`"
    }
}

# list leave packages
function jllv {
    cat $Global:OX_ELEMENT.jlp | rg --only-matching '\w+ =' | sd ' =' ' '
}

# list packages
function jlls {
    cat $Global:OX_ELEMENT.jlm | rg --only-matching 'deps\.\w+' | sd 'deps\.' ''
}

# dependencies of package
function jldp {
    local cmd=$(echo "using PkgDependency; PkgDependency.tree(\"$args[1]\") |> println")
    # echo "$cmd"
    julia --eval "$cmd"
}

function jlrdp {
    local cmd=$(echo "using PkgDependency; PkgDependency.tree(\"$args[1]\"; reverse=true) |> println")
    # echo "$cmd"
    julia --eval "$cmd"
}

function jlpn {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.pin([$pkgs])")
    # echo "$cmd"
    julia --eval `"$cmd`"
}

function jlupn {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.free([$pkgs])")
    # echo "$cmd"
    julia --eval `"$cmd`"
}

# calculate mature rate
function jlmt {
    $num_total = (cat $Global:OX_ELEMENT.jlm | rg "version =" | wc -l)
    echo "total: $num_total"
    $num_immature = (cat $Global:OX_ELEMENT.jlm | rg '\"0\.' | wc -l)
    $ratio = $num_immature / $num_total * 100
    $mature_rate = '{ 0:N0 }' -f $(100 - $ratio)
    echo "mature rate: $mature_rate %"
}

##########################################################
# packages
##########################################################

# build project
function jlb {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.build([$pkgs])")
    # echo "$cmd"
    julia --eval `"$cmd`"
}

# test project
function jlts {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.test([$pkgs])")
    # echo "$cmd"
    julia --eval `"$cmd`"
}
