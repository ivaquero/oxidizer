if test "$(command -v docker)"; then
    export OX_CONTAINER="docker"
fi

if test "$(command -v podman)"; then
    export OX_CONTAINER="podman"
fi

alias cth="${OX_CONTAINER} --help"
alias ctif="${OX_CONTAINER} info"

##########################################################
# containers
##########################################################

alias ctc="${OX_CONTAINER} container"
alias ctch="${OX_CONTAINER} container --help"
alias ctcls="${OX_CONTAINER} container ls"
alias ctcat="${OX_CONTAINER} container attach"
alias ctcr="${OX_CONTAINER} container run -it --name"
alias ctcs="${OX_CONTAINER} container start"
alias ctcrs="${OX_CONTAINER} container restart"
alias ctcst="${OX_CONTAINER} container stats"
alias ctcpa="${OX_CONTAINER} container pause"
alias ctcupa="${OX_CONTAINER} container unpause"
alias ctcq="${OX_CONTAINER} container kill"
alias ctcdf="${OX_CONTAINER} container diff"
alias ctccl="${OX_CONTAINER} container prune"
alias ctca="${OX_CONTAINER} container create --name"
alias ctcrm="${OX_CONTAINER} container rm"
alias ctcif="${OX_CONTAINER} container inspect"
alias ctcii="${OX_CONTAINER} container init"

##########################################################
# images
##########################################################

alias cti="${OX_CONTAINER} image"
alias ctih="${OX_CONTAINER} image --help"
alias ctisc="${OX_CONTAINER} image search"
alias ctils="${OX_CONTAINER} image list"
alias ctirm="${OX_CONTAINER} image rm"
alias cticl="${OX_CONTAINER} image prune"
alias ctidf="${OX_CONTAINER} image diff"
alias ctiif="${OX_CONTAINER} image inspect"
alias ctib="${OX_CONTAINER} image build"
alias ctcup="${OX_CONTAINER} image update"
alias ctipl="${OX_CONTAINER} image pull"
alias ctips="${OX_CONTAINER} image push"
