##########################################################
# text
##########################################################

function pdls {
    Write-Output 'input-formats\n'
    pandoc --list-input-formats
    Write-Output 'output-formats\n'
    pandoc --list-output-formats
}

if ([string]::IsNullOrEmpty($env:OX_FONT)) {
    $env:OX_FONT = "Arial Unicode MS"
}

function font { param ( $the_font ) $env:OX_FONT = $the_font }

##########################################################
# markdown
##########################################################

function mdto {
    param ( $format, $file )
    $name = (Get-Item $file).BaseName
    Switch ( $format ) {
        pdf {
            pandoc $file -o ($name + "." + $format) --pdf-engine=xelatex -V CJKmainfont=$env:OX_FONT
        }
        html {
            pandoc $file -o ($name + "." + $format) --standalone --mathjax --shift-heading-level-by=-1
        }
        docx {
            pandoc $file -o ($name + "." + $format)
        }
        Default {
            pandoc $file -o ($name + "." + $format)
        }
    }
}

##########################################################
# audio
##########################################################

function tomp3 {
    param ( $file, $bitrate )
    $name = (Get-Item $file).BaseName
    if ([string]::IsNullOrEmpty($cbr)) { $bitrate = "192K" }
    else { $cbr = $bitrate + "K" }

    ffmpeg -i $file -c:a libmp3lame -b:a $cbr $name.mp3
}
