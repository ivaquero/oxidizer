alias pdif="podman info"

##########################################################
# containers
##########################################################

alias pc="podman container"
alias pcls="podman container ls"
alias pcat="podman container attach"
alias pcs="podman container start"
alias pcrs="podman container restart"
alias pcst="podman container stats"
alias pcpa="podman container pause"
alias pcupa="podman container unpause"
alias pcq="podman container kill"
alias pcup="podman container update"
alias pcdf="podman container diff"
alias pccl="podman container prune"
alias pca="podman container create --name"
alias pcrm="podman container rm"
alias pcr="podman container run -it --name"
alias pccp="podman container cp"

##########################################################
# images
##########################################################

alias pi="podman image"
alias pisc="podman image search"
alias pils="podman image list"
alias pirm="podman image rm"
alias picl="podman image prune"
alias pib="podman image build"
alias pidf="podman image diff"
alias pipl="podman image pull"
alias pips="podman image push"
alias picp="podman image scp"
