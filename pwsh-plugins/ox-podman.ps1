function pkif { podman info }

##########################################################
# containers
##########################################################

function pc { podman container $args }
function pcls { podman container list }
function pcat { podman container attach $args }
function pcs { podman container start $args }
function pcrs { podman container restart $args }
function pcst { podman container stats $args }
function pcpa { podman container pause $args }
function pcupa { podman container unpause $args }
function pcq { podman container kill $args }
function pcup { podman container update $args }
function pcdf { podman container diff $args }
function pccl { podman container prune $args }
function pca { podman container create --name $args }
function pcrm { podman container rm $args }
function pcr { podman container run -it --name $args }

##########################################################
# images
##########################################################

function pi { podman image $args }
function pisc { podman image search $args }
function pils { podman image list }
function pirm { podman image rm $args }
function picl { podman image prune $args }
function pib { podman image build $args }
function pipl { podman image pull $args }
function pips { podman image push $args }
function picp { podman image scp $args }
