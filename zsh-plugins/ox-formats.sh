##########################################################
# text
##########################################################

pdls() {
    echo 'input-formats\n'
    pandoc --list-input-formats
    echo 'output-formats\n'
    pandoc --list-output-formats
}

[ -z $OX_FONT ] && export OX_FONT="Arial Unicode MS"

# change font
chft() {
    export OX_FONT=$1
}

##########################################################
# markdown
##########################################################

# $1: input file, $2: output format
mdto() {
    case $1 in
    pdf)
        pandoc $2 -o ${2%%.*}.$1 --pdf-engine=xelatex -V CJKmainfont=$OX_FONT
        ;;
    html)
        pandoc $2 -o ${2%%.*}.$1 --standalone --mathjax --shift-heading-level-by=-1
        ;;
    docx)
        pandoc $2 -o ${2%%.*}.$1
        ;;
    *)
        pandoc $2 -o ${2%%.*}.$1
        ;;
    esac
}

##########################################################
# pdf
##########################################################

##########################################################
# audio
##########################################################

tomp3() {
    if [[ -z $2 ]]; then
        cbr=192K
    else
        cbr=$2K
    fi
    ffmpeg -i $1 -c:a libmp3lame -b:a $cbr ${1%%.*}.mp3
}
