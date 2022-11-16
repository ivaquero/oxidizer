##########################################################
# config
##########################################################

# config files
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
function gig {
    git rm -rf --cached .
    git add .
    git commit -m "🗑 remove all ignored files"
}

# ui
function gui { gitui }

# git clone
# dl: download
function gdl {
    param ( $url, $mode )
    Switch ( $mode ) {
        -a { git clone $url }
        Default { git clone --depth 1 $url }
    }
}

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

function gf { git filter-repo $args }

# clean files
function gcl {
    Switch ( $args[1] ) {
        -s { git filter-repo --strip-blobs-bigger-than $args[2] }
        -i { git filter-repo --strip-blobs-with-ids $args[2] }
        -p { git filter-repo --invert-paths --path-glob $args[2] }
        -a {
            git checkout --orphan new
            git add -A
            git commit -am "🎉 New Start"
            if ([string]::IsNullOrEmpty($args[2])) { $branch = master }
            else { $branch = $args[2] }
            git branch -D $branch
            git branch -m $branch
            git push -f origin $branch
        }
        Default { git repack -a -d --depth=250 --window=250 }
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
