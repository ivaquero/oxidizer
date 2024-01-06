if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Output "Scoop Already Installed"
}
else {
    Write-Output "Scoop Not Found. Installing..."

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

$pkgs = cat "$env:OXIDIZER\defaults\Scoopfile.txt"

ForEach ( $pkg in $pkgs ) {
    Switch ($pkg) {
        ripgrep { $cmd = "rg" }
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
    scoop install dark innounp
}

###################################################
# Update PowerShell Settings
###################################################

$env:OX_SHELL = "$HOME/.bash_profile"

Write-Output "Adding Oxidizer into $env:OX_SHELL..."

if (!(Test-Path -Path $OX_SHELL)) {
    New-Item -ItemType File -Force -Path $env:OX_SHELL
}

Write-Output '# Oxidizer' >> $env:OX_SHELL

if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    Write-Output 'export OXIDIZER=${HOME}/oxidizer' >> $env:OX_SHELL
    Write-Output 'source ${OXIDIZER}/oxidizer.sh' >> $env:OX_SHELL
}
else {
    Write-Output 'source ${OXIDIZER}/oxidizer.sh' >> $env:OX_SHELL
}

Write-Output "Adding Custom settings..."

if (!(Test-Path -Path "$env:OXIDIZER\custom.sh")) {
    Copy-Item -R -v "$env:OXIDIZER\defaults.sh" "$env:OXIDIZER\custom.sh"
}

# load zoxide
sed -i.bak "s|.* OX_STARTUP = .*|$Global:OX_STARTUP=1|" "$env:OXIDIZER\custom.ps1"
# set path of oxidizer
# sed -i.bak "s| = .*\oxidizer.ps1| = $env:OXIDIZER\oxidizer.ps1|" $OX_SHELL
# Write-Output $(cat $OX_SHELL | rg -o 'source .+')

###################################################
# Load Plugins
###################################################

git clone --depth=1 https://github.com/ivaquero/oxplugins-zsh.git $env:OXIDIZER\plugins

Write-Output "Oxidizer installation complete!"
Write-Output "Please use it in Git Bash and hit 'edf ox' to tweak your preferences.\n"
Write-Output "Finally, run 'upox' function to activate the plugins. Enjoy!"
