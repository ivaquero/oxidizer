##########################################################
# basic settings
##########################################################

# default editor, can be changed by function `ched()`
$env:EDITOR = 'code'
# terminal editor
$env:EDITOR_T = 'vi'

##########################################################
# common aliases
##########################################################

# shortcuts
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function cat { bat $args }
# function ls { lsd $args }
function ll { lsd -l $args }
function la { lsd -a $args }
function lla { lsd -la $args }
function e { Write-Output $args }
function rr { rm -rf $args }
function c { clear }

# tools
Remove-Item alias:man -Force -ErrorAction SilentlyContinue
function man { tldr $args }
function hf { hyperfine $args }

# oxidizer
# export config
function epf { oxf $args }
# import config
function ipf { rdf $args }
# initialize config
function iif { clzf $args }
