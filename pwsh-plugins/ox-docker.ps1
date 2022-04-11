function dk { docker }
function dkif { docker info }
function dksc { docker search }

##########################################################
# containers
##########################################################

function dkc { docker container }
function dkcls { docker container ls }
function dkcat { docker container attach $args }
function dkcs { docker container start $args }
function dkcrs { docker container restart $args }
function dkcst { docker container stats $args }
function dkcrm { docker container rm $args }
function dkcpa { docker container pause $args }
function dkcupa { docker container unpause $args }
function dkcq { docker container kill $args }
function dkcup { docker container update $args }
function dkcdf { docker container diff $args }
function dkccl { docker container prune $args }
function dkccr { docker container create --name $args }
function dkcr { docker container run -it --name $args }

##########################################################
# images
##########################################################

function dki { docker image }
function dkils { docker image ls }
function dkirm { docker image rm $args }
function dkicl { docker image prune $args }
function dkib { docker image build $args }
function dkipl { docker pull $args }
function dkips { docker push $args }
