##########################################################
# config
##########################################################

$Global:OX_ELEMENT.g = "$HOME\.gitconfig"

##########################################################
# query & setting
##########################################################

function gst { git status $args }
function gcf { git config $args }

##########################################################
# project management
##########################################################

function gii { git init $args }
# ui
function gui { gitui }

##########################################################
# item management
##########################################################

function gdf { git diff $args }
function gpl { git pull $args }
function gps { git push $args }
function gcm { git commit $args }

# git add
function ga {
    if ([string]::IsNullOrEmpty($args)) { git add . }
    else { git add $args }
}

##########################################################
# clean
##########################################################

# clean files
function gcl {
    Switch ( $args[1] ) {
        --his {
            git checkout --orphan new
            git add -A
            git commit -am "🎉 New Start"
            if ([string]::IsNullOrEmpty($args[2])) { $branch = master }
            else { $branch = $args[2] }
            git branch -D $branch
            git branch -m $branch
            git push -f origin $branch
        }
        --ig {
            git rm -rf --cached .
            git add .
        }
        Default { git clean $args }
    }
}

function grpb() {
    git remote add origin $args[1]
    if ([string]::IsNullOrEmpty($args[2])) { $branch = master }
    else { $branch = $args[2] }
    git pull $args[1] $branch
    git push --set-upstream origin $branch
}

# list fat files
function gjk {
    param ( $num )
    if ([string]::IsNullOrEmpty($num)) { $number = 10 }
    else { $number = $num }

    git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | Where-Object { $_ -like 'blob*' } | Sort-Object { [int]($_ -split '\s+')[2] } | Select-Object -Last $number
}

##########################################################
# tag
##########################################################

function gt { git tag $args }
function gtls { git tag --list }
function gta { git tag --annotate $args }
function gtrm { git tag --delete $args }
function gte { git tag --edit $args }
function gtcl { git tag --cleanup $args }
