function dif { docker info }
function dsc { docker search $args }

##########################################################
# containers
##########################################################

function dc { docker container $args }
function dcls { docker container ls }
function dcat { docker container attach $args }
function dcs { docker container start $args }
function dcrs { docker container restart $args }
function dcst { docker container stats $args }
function dcrm { docker container rm $args }
function dcpa { docker container pause $args }
function dcupa { docker container unpause $args }
function dcq { docker container kill $args }
function dcup { docker container update $args }
function dcdf { docker container diff $args }
function dccl { docker container prune $args }
function dccr { docker container create --name $args }
function dcr { docker container run -it --name $args }

##########################################################
# images
##########################################################

function di { docker image $args }
function dils { docker image ls }
function dirm { docker image rm $args }
function dicl { docker image prune $args }
function dib { docker image build $args }
function dipl { docker pull $args }
function dips { docker push $args }
