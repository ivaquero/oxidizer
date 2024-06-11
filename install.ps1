if (!($(uname).Contains("Darwin") || $(uname).Contains("Linux"))) {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Output "Scoop Already Installed"
    }
    else {
        Write-Output "Scoop Not Found. Installing..."
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm

        $f_scoop = Join-Path $HOME "install.ps1"

        if ( $env:scoop_mirror ) {
            Invoke-WebRequest 'https://gitee.com/glsnames/scoop-installer/raw/master/bin/install.ps1' -UseBasicParsing -OutFile $f_scoop

            scoop config SCOOP_REPO 'https://gitee.com/glsnames/scoop-installer'
        }
        else {
            Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Install/master/install.ps1' -UseBasicParsing -OutFile $f_scoop
        }
        if ( $env:scoop_test ) { & $f_scoop -RunAsAdmin -ScoopDir 'C:\Scoop' }
        else { & $f_scoop -ScoopDir 'C:\Scoop' }
    }

    scoop install aria2 7zip

    # add additional buckets
    if ( $env:scoop_mirror ) {
        $scoopBuckets = @("nerd-fonts https://gitee.com/scoop-bucket/nerd-fonts", "extras https://gitee.com/scoop-bucket/extras.git")
    }
    else {
        $scoopBuckets = @("nerd-fonts", "extras")
    }

    ForEach ( $bucket in $scoopBuckets ) {
        scoop bucket add $bucket
    }

    if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
        $env:OXIDIZER = "$HOME\oxidizer"
        Write-Output '# Oxidizer' >> $env:OX_SHELL
        Write-Output 'export OXIDIZER=${HOME}/oxidizer' >> $env:OX_SHELL
        Write-Output 'source ${OXIDIZER}/oxidizer.sh' >> $env:OX_SHELL
    }
    $pkgs = cat "$env:OXIDIZER\defaults\Scoopfile.txt"

    ForEach ( $pkg in $pkgs ) {
        Switch ($pkg) {
            ripgrep { $cmd = "rg" }
            tlrc { $cmd = "tldr" }
            zoxide { $cmd = "z" }
            Default { $cmd = $pkg }
        }
        if (Get-Command $cmd -ErrorAction SilentlyContinue) {
            Write-Output "$pkg Already Installed"
        }
        else {
            Write-Output "Installing $pkg"
            scoop install $pkg
        }
        scoop install dark innounp busybox
    }
}

###################################################
# Update PowerShell Settings
###################################################

Remove-Item alias:cp -Force -ErrorAction SilentlyContinue

Write-Output "Adding Oxidizer into $PROFILE..."

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Force -Path $PROFILE
}

Write-Output '# Oxidizer' >> $PROFILE

if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    if ($(uname).Contains("Windows")) {
        Write-Output '
        $env:OXIDIZER = "$HOME\oxidizer"' >> $PROFILE
    }
    else {
        Write-Output '
        $env:OXIDIZER = "$env:HOME\oxidizer"' >> $PROFILE
    }
}

Write-Output ". $env:OXIDIZER\oxidizer.ps1" >> $PROFILE
Write-Output "Adding Custom settings..."

if (!(Test-Path -Path "$env:OXIDIZER\custom.sh")) {
    Copy-Item -R -v "$env:OXIDIZER\defaults.ps1" "$env:OXIDIZER\custom.ps1"
}

sd ".* OX_STARTUP = .*" "$Global:OX_STARTUP=1" "$env:OXIDIZER\custom.ps1"
# set path of oxidizer
# sd "s| = .*\oxidizer.ps1| = $env:OXIDIZER\oxidizer.ps1|" $OX_SHELL
# Write-Output $(cat $OX_SHELL | rg -o 'source .+')

###################################################
# Update Shell Settings
###################################################

$env:OX_SHELL = "$HOME/.bash_profile"

Write-Output "Adding Oxidizer into $env:OX_SHELL..."

if (!(Test-Path -Path $env:OX_SHELL)) {
    New-Item -ItemType File -Force -Path $env:OX_SHELL
}

Write-Output "Adding Custom settings..."

if (!(Test-Path -Path "$env:OXIDIZER\custom.sh")) {
    Copy-Item -R -v "$env:OXIDIZER\defaults.sh" "$env:OXIDIZER\custom.sh"
}

# load zoxide
sd ".* OX_STARTUP = .*" "$Global:OX_STARTUP=1" "$env:OXIDIZER\custom.sh"

###################################################
# Load Plugins
###################################################

Set-Location $env:OXIDIZER

git clone --depth=1 https://github.com/ivaquero/oxplugins.git ./plugins

git clone --depth=1 https://github.com/ivaquero/oxplugins-pwsh.git ./addons

###################################################
# Extras Steps
###################################################

if ($(uname).Contains("Windows")) {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        scoop install vscode
        reg import "C:\Scoop\apps\vscode\current\install-associations.reg"
    }
}

. $PROFILE

Write-Output "Oxidizer installation complete!"
Write-Output "Don't forget to restart your terminal and hit 'edf ox' to tweak your preferences.\n"
Write-Output "Finally, run 'upox' function to activate the plugins. Enjoy!"
