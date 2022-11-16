##########################################################
# config
##########################################################

Element[jl]=$HOME/.julia/config/startup.jl
Element[jlp]=$HOME/.julia/environments/v$(julia -v | rg --only-matching "\d.\d")/Project.toml
Element[jlm]=$HOME/.julia/environments/v$(julia -v | rg --only-matching "\d.\d")/Manifest.toml

up_julia() {
    echo "Update Julia by ${OX_OXIDE[bkjl]}"
    local pkgs=[\"$(cat ${OX_OXIDE[bkjl]} | sd '\n' '", "')\"]
    local pkgs_vec=$(echo $pkgs | sd ', ""' '')
    local cmd=$(echo 'using Pkg; Pkg.add(,,)' | sd ',,' "$pkgs_vec")
    julia --eval "$cmd"
}

back_julia() {
    echo "Backup Julia to ${OX_OXIDE[bkjl]}"
    cat ${Element[jlp]} | rg --only-matching "\w.*=" | sd "[= ]" "" >${OX_OXIDE[bkjl]}
}

##########################################################
# packages
##########################################################

alias jl="julia --quiet"
alias jlh="julia --help"
alias jlr="julia --eval"
alias jlcl="julia --eval 'using Pkg; Pkg.gc()'"
alias jlst="julia --eval 'using Pkg; Pkg.status()'"

# install packages
jlis() {
    local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
    local cmd=$(echo 'using Pkg; Pkg.add([,,])' | sd ',,' "$pkgs")
    echo "$cmd"
    julia --eval "$cmd"
}

# uninstall packages
jlus() {
    local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
    local cmd=$(echo 'using Pkg; Pkg.rm([,,])' | sd ',,' "$pkgs")
    echo "$cmd"
    julia --eval "$cmd"
}

# update packages
jlup() {
    if [ -z $@ ]; then
        julia --eval "using Pkg; Pkg.update()"
    else
        local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
        local cmd=$(echo 'using Pkg; Pkg.update([,,])' | sd ',,' "$pkgs")
        echo "$cmd"
        julia --eval "$cmd"
    fi
}

# list leave packages
jllv() {
    cat ${Element[jlp]} | rg --only-matching "\w+ =" | sd " =" " "
}

# list packages
jlls() {
    cat ${Element[jlm]} | rg --only-matching "deps\.\w+" | sd "deps\." ""
}

# dependencies of package
jldp() {
    local cmd=$(echo "using PkgDependency; PkgDependency.tree(\"$1\")")
    echo "$cmd"
    julia --eval "$cmd"
}

jlpn() {
    local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
    local cmd=$(echo 'using Pkg; Pkg.pin([,,])' | sd ',,' "$pkgs")
    echo "$cmd"
    julia --eval "$cmd"
}

jlupn() {
    local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
    local cmd=$(echo 'using Pkg; Pkg.free([,,])' | sd ',,' "$pkgs")
    echo "$cmd"
    julia --eval "$cmd"
}

# calculate mature rate
jlmt() {
    local num_total=$(cat ${Element[jlm]} | rg "version =" | wc -l)
    echo "total: $num_total"
    local num_immature=$(cat ${Element[jlm]} | rg '"0\.' | wc -l)
    local mature_rate=$((100 - num_immature * 100 / num_total))
    echo "mature rate: $mature_rate %"
}

##########################################################
# project
##########################################################

# build project
jlb() {
    local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
    local cmd=$(echo 'using Pkg; Pkg.build([,,])' | sd ',,' "$pkgs")
    echo "$cmd"
    julia --eval "$cmd"
}

# test project
jlts() {
    local pkgs=$(echo \"$@\" | sd ' ' '\", \"')
    local cmd=$(echo 'using Pkg; Pkg.test([,,])' | sd ',,' "$pkgs")
    echo "$cmd"
    julia --eval "$cmd"
}
