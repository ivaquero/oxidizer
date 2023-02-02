##########################################################
# config
##########################################################

$Global:OX_OXYGEN.oxc = "$env:OXIDIZER\defaults\.condarc"
$Global:OX_OXYGEN.oxce = "$env:OXIDIZER\defaults\conda-base.txt"
# config files
$Global:OX_ELEMENT.c = "$HOME\.condarc"


if (Get-Command mamba -ErrorAction SilentlyContinue) {
    $Global:OX_CONDA="mamba"
}
else {
     Write-Output 'Suggestion: install mamba for better experience.'
    $Global:OX_CONDA="conda"
}


function init_conda {
    Write-Output 'Initialize Conda by Oxidizer configuration'
    $pkgs = cat $($Global:OX_OXYGEN.oxce) | sd "`n" ' '
    Write-Output "Installing $pkgs"
    Invoke-Expression ". $Global:OX_CONDA install $pkgs"
}

function up_conda {
    param ( $the_env, $the_file )
    if ([string]::IsNullOrEmpty( $the_env )) {
        $cenv = 'base'
        $conda_file = "$Global:OX_OXIDE.bkceb"
    }
    elseif ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        $cenv = $Global:OX_CONDA_ENV.$the_env
        $conda_file = "$Global:OX_OXIDE.bkce$the_env"
    }
    else {
        $cenv = $the_env
        $conda_file = $the_file
    }

    Write-Output "Update Conda Env $cenv by $conda_file"
    $pkg = cat $conda_file | sd "`n" ' '
    Write-Output "Installing $pkg"
    Invoke-Expression ". $Global:OX_CONDA install $pkgs"
}

function back_conda {
    param ( $the_env, $the_file )
    if ([string]::IsNullOrEmpty( $the_env )) {
        $cenv = 'base'
        $conda_file = "$Global:OX_OXIDE.bkceb"
    }
    elseif ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        $cenv = $Global:OX_CONDA_ENV.$the_env
        $conda_file = "$Global:OX_OXIDE.bkce$the_env"
    }
    else {
        $cenv = $the_env
        $conda_file = $the_file
    }

    Write-Output "Backup Conda Env $cenv to $conda_file"
    $pkg = $(conda tree -n $cenv leaves)
    $pkg.Replace("[',\[\]]", '') | sd ' ' "`n" > "$conda_file"
}

##########################################################
# packages
##########################################################

function ch { conda --help }
function ccf { conda config $args }
function cif { conda info }
function cis { . $Global:OX_CONDA install $args }
function cus { . $Global:OX_CONDA uninstall $args }
function csc { . $Global:OX_CONDA search $args }
function cdp { . $Global:OX_CONDA repoquery depends $pkg }
# specific
function crdp { . $Global:OX_CONDA repoquery whoneeds $pkg }

# clean packages
function ccl {
    param ( $cmd )
    Switch ( $cmd ) {
        -l { conda clean --logfiles }
        -i { conda clean --index-cache }
        -p { conda clean --packages }
        -t { conda clean --tarballs }
        -f { conda clean --force-pkgs-dirs }
        -a { conda clean --all }
        Default {
            conda clean --packages
            conda clean --tarballs
        }
    }
}

# update packages
function cup {
    if ([string]::IsNullOrEmpty( $args[1] )) { . $Global:OX_CONDA update --all }
    else {
        ceat $args[1]
        . $Global:OX_CONDA update --all $args[2]
        conda deactivate
    }
}

Remove-Item alias:cls -Force -ErrorAction SilentlyContinue
Remove-Item alias:clv -Force -ErrorAction SilentlyContinue
# list packages
# $1=name
function cls {
    param ( $the_env )
    if ([string]::IsNullOrEmpty( $the_env )) { conda list }
    elseif ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        conda list -n $Global:OX_CONDA_ENV.$the_env
    }
    else { conda list -n $the_env }
}

# list leave packages
# $1=name
function clv {
    param ( $the_env )
    if ([string]::IsNullOrEmpty( $the_env )) { conda-tree leaves }
    elseif ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        conda-tree -n $Global:OX_CONDA_ENV.$the_env leaves
    }
    else { conda-tree -n $the_env leaves }
}

function cmt {
    param ( $the_env )
    $num_total = (Clear-Host $the_env | Measure-Object -Line).Line
    Write-Output "total: $num_total"
    $num_immature = (Clear-Host $the_env | rg '\s0\.\d' | Measure-Object -Line).Line
    $ratio = $num_immature / $num_total * 100
    $mature_rate = '{0:N0}' -f $(100 - $ratio)
    Write-Output "mature rate: $mature_rate %"
}

##########################################################
# extension
##########################################################

function cxa { conda config --add channels $args }
function cxrm { conda config --remove channels $args }
function cxls { conda config --get channels }

##########################################################
# project
##########################################################

function cii { conda init $args }
function cr { conda run $args }

##########################################################
# environments
##########################################################

# activate environment: $1=name
function ceat {
    param ( $the_env )
    if ([string]::IsNullOrEmpty( $the_env )) {
        conda activate base; clear
    }
    elseif ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        conda activate $Global:OX_CONDA_ENV.$the_env; clear
    }
    else {
        conda activate $the_env; clear
    }
}

# reactivate environment: $1=name
function cerat {
    param ( $the_env )
    conda deactivate
    ceat $the_env
}

# create environment: $1=name
function cecr {
    param ( $the_env )

    if ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        conda create -n $Global:OX_CONDA_ENV.$the_env
    }
    else {
        conda create -n $the_env
    }
    ceat $the_env
}

# delete environment: $1=name
function cerm {
    param ( $the_env )
    conda deactivate
    if ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        conda env remove -n $Global:OX_CONDA_ENV.$the_env
    }
    else { conda env remove -n $the_env }
}

# change environment subdir
function cesd {
    param ( $arch )
    Switch ( $arch ) {
        a { conda env config vars set CONDA_SUBDIR=win-arm64 }
        i { conda env config vars set CONDA_SUBDIR=win-64 }
    }
}

# export environment: $1=name
function ceep {
    param ( $the_env )
    if ([string]::IsNullOrEmpty( $the_env )) { $cenv = base }
    elseif ( $( $the_env | Measure-Object -Character).Character -lt 2 ) {
        $cenv = $Global:OX_CONDA_ENV.$the_env
    }
    else { $cenv = $1 }
    conda env export -n $cenv -f $env:OX_BACKUP\install\$cenv-win.yml
}

# rename environment
function cern {
    param ( $old, $new )
    if ( $old.contains('\') ) { conda rename --prefix $old $new }
    else { conda rename --name $old $new }
}
function cels { conda env list }
function ceq { conda deactivate; clear }
function cedf { conda compare $args }
