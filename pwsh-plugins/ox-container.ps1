if (Get-Command docker -ErrorAction SilentlyContinue) {
    $OX_CONTAINER = 'docker'
}

if (Get-Command podman -ErrorAction SilentlyContinue) {
    $OX_CONTAINER = 'podman'
}

function cth { . $OX_CONTAINER --help }
function ctif { . $OX_CONTAINER info }

##########################################################
# containers
##########################################################}

function ctc { . $OX_CONTAINER container }
function ctch { . $OX_CONTAINER container --help }
function ctcls { . $OX_CONTAINER container ls }
function ctcat { . $OX_CONTAINER container attach }
function ctcr { . $OX_CONTAINER container run -it --name }
function ctcs { . $OX_CONTAINER container start }
function ctcrs { . $OX_CONTAINER container restart }
function ctcst { . $OX_CONTAINER container stats }
function ctcpa { . $OX_CONTAINER container pause }
function ctcupa { . $OX_CONTAINER container unpause }
function ctcq { . $OX_CONTAINER container kill }
function ctcdf { . $OX_CONTAINER container diff }
function ctccl { . $OX_CONTAINER container prune }
function ctca { . $OX_CONTAINER container create --name }
function ctcrm { . $OX_CONTAINER container rm }
function ctcif { . $OX_CONTAINER container inspect }
function ctcii { . $OX_CONTAINER container init }

##########################################################
# images
##########################################################

function cti { . $OX_CONTAINER image }
function ctih { . $OX_CONTAINER image --help }
function ctisc { . $OX_CONTAINER image search }
function ctils { . $OX_CONTAINER image list }
function ctirm { . $OX_CONTAINER image rm }
function cticl { . $OX_CONTAINER image prune }
function ctidf { . $OX_CONTAINER image diff }
function ctiif { . $OX_CONTAINER image inspect }
function ctib { . $OX_CONTAINER image build }
function ctcup { . $OX_CONTAINER image update }
function ctipl { . $OX_CONTAINER image pull }
function ctips { . $OX_CONTAINER image push }
