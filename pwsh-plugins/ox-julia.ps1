##########################################################
# config
##########################################################

$Global:Element.jls = "$HOME\.julia\config\startup.jl"
$Global:Element.jlm = "$HOME\.julia\environments\v$(julia -v | rg --only-matching '\d.\d')\Manifest.toml"
$Global:Element.jlp = "$HOME\.julia\environments\v$(julia -v | rg --only-matching '\d.\d')\Project.toml"

function up_julia {
    Write-Output "Update Julia by $($Global:Oxide.bkjl)"
    $pkgs = (cat $($Global:Oxide.bkjl) | sd '`n' '\", \"')
    $pkgs_vec = Write-Output [`"$pkgs`"] | sd '\[' '[\"' | sd ', \"]' ']'
    $cmd = Write-Output "using Pkg; Pkg.add($pkgs_vec)"
    julia --eval `"$cmd`"
}

function back_julia {
    Write-Output "Backup Julia to $($Global:Oxide.bkjl)"
    cat $Global:Element.jlp | rg --only-matching '\w.*=' | sd '[= ]' ' ' | Out-File -FilePath "$($Global:Oxide.bkjl)"
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
    param ( $cmd)
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
    $pkgs = (Write-Output `"$args`" | sd ' ' '\", \"')
    $cmd = (Write-Output "using Pkg; Pkg.add([$pkgs])")
    Write-Output "$cmd"
    julia --eval `"$cmd`"
}

# uninstall packages
function jlus {
    $pkgs = $(Write-Output `"$args`" | sd ' ' '\", \"')
    $cmd = $(Write-Output "using Pkg; Pkg.rm([$pkgs])")
    Write-Output "$cmd"
    julia --eval `"$cmd`"
}

# update packages
function jlup {
    if ([string]::IsNullOrEmpty($args)) {
        julia --eval 'using Pkg; Pkg.update()'
    }
    else {
        $pkgs = $(Write-Output `"$args`" | sd ' ' '\", \"')
        $cmd = $(Write-Output "using Pkg; Pkg.update([$pkgs])")
        Write-Output "$cmd"
        julia --eval `"$cmd`"
    }
}

# list leave packages
function jllv {
    cat $Global:Element.jlp | rg --only-matching '\w+ =' | sd ' =' ' '
}

# list packages
function jlls {
    cat $Global:Element.jlm | rg --only-matching 'deps\.\w+' | sd 'deps\.' ''
}

# dependencies of package
function jldp {
    local cmd=$(Write-Output 'using PkgDependency; PkgDependency.tree(\'$1\")")
    Write-Output "$cmd"
    julia --eval "$cmd"
}

function jlpn {
    $pkgs = $(Write-Output `"$args`" | sd ' ' '\", \"')
    $cmd = $(Write-Output "using Pkg; Pkg.pin([$pkgs])")
    Write-Output "$cmd"
    julia --eval `"$cmd`"
}

function jlupn {
    param ( $pkgs)
    $pkgs = $(Write-Output `"$args`" | sd ' ' '\", \"')
    $cmd = $(Write-Output "using Pkg; Pkg.free([$pkgs])")
    Write-Output "$cmd"
    julia --eval `"$cmd`"
}

# calculate mature rate
function jlmt {
    $num_total = (cat $Global:Element.jlm | rg '\[\[' | Measure-Object -Line).Line
    Write-Output "total: $num_total"
    $num_immature = (cat $Global:Element.jlm | rg '\"0\.' | Measure-Object -Line).Line
    $ratio = $num_immature / $num_total * 100
    $mature_rate = '{ 0:N0 }' -f $(100 - $ratio)
    Write-Output "mature rate: $mature_rate %"
}

##########################################################
# packages
##########################################################

# build project
function jlb {
    $pkgs = $(Write-Output `"$args`" | sd ' ' '\", \"')
    $cmd = $(Write-Output "using Pkg; Pkg.build([$pkgs])")
    Write-Output "$cmd"
    julia --eval `"$cmd`"
}

# test project
function jlts {
    $pkgs = $(Write-Output `"$args`" | sd ' ' '\", \"')
    $cmd = $(Write-Output "using Pkg; Pkg.test([$pkgs])")
    Write-Output "$cmd"
    julia --eval `"$cmd`"
}
