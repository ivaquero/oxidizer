##########################################################
# config
##########################################################

# config files
OX_ELEMENT[g]=$HOME/.gitconfig

export GPG_TTY=$(tty)

##########################################################
# query
##########################################################

alias gst="git status"
alias gcf="git config"

##########################################################
# project management
##########################################################

alias gii="git init"

gig() {
    git rm -rf --cached .
    git add .
    git commit -m "🗑 remove all ignored files"
}

# ui
alias gui="gitui"

# git clone
# dl: download
gdl() {
    case $2 in
    -a) git clone $1 ;;
    *) git clone --depth 1 $1 ;;
    esac
}

##########################################################
# item management
##########################################################

alias gdf="git diff"
alias gpl="git pull"
alias gps="git push"
alias gcm="git commit"

# git add
ga() {
    if [ -z $1 ]; then
        git add .
    else
        git add $1
    fi
}

##########################################################
# clean
##########################################################

alias gf="git filter-repo"

# clean files
gcl() {
    case $1 in
    -s) git filter-repo --strip-blobs-bigger-than $2 ;;
    -i) git filter-repo --strip-blobs-with-ids $2 ;;
    -p) git filter-repo --invert-paths --path-glob $2 ;;
    -a)
        git checkout --orphan new
        git add -A
        git commit -am "🎉 New Start"
        if [ -z $2]; then
            branch=master
        else
            branch=$2
        fi
        git branch -D $branch
        git branch -m $branch
        git push -f origin $branch
        ;;
    *) git repack -a -d --depth=250 --window=250 ;;
    esac
}

grpb() {
    git remote add origin $1
    if [ -z $2]; then
        branch=master
    else
        branch=$2
    fi
    git pull $1 $branch
    git push --set-upstream origin $branch
}

# list fat files
#
# $1: number to display
gjk() {
    if [ -z $1 ]; then
        local number=10
    else
        local number=$1
    fi

    git rev-list --objects --all | grep -f <(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | cut -f 1 -d " " | tail -$number)
}

##########################################################
# tag
##########################################################

alias gt="git tag"
alias gtls="git tag --list"
alias gta="git tag --annotate"
alias gtrm="git tag --delete"
alias gte="git tag --edit"
alias gtcl="git tag --cleanup"
