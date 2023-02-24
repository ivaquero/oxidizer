if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = "$HOME\oxidizer"
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop Already Installed"
}
else {
    Write-Host "Scoop Not Found. Installing..."

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

$pkgs = Get-Content "$env:OXIDIZER\defaults\Scoopfile.txt"

ForEach ( $pkg in $pkgs ) {
    Switch ( $pkg ) {
        bottom { $cmd = 'btm' }
        ripgrep { $cmd = 'rg' }
        tealdeer { $cmd = 'tldr' }
        zoxide { $cmd = 'z' }
        Default { $cmd = $pkg }
    }
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        Write-Host "$pkg Already Installed"
    }
    else {
        Write-Host "Installing $pkg"
        scoop install $pkg
    }
}

###################################################
# Update PowerShell Settings
###################################################

echo "Adding Oxidizer into $PROFILE..."

if ( !(Test-Path $PROFILE) ) {
    New-Item -ItemType File -Force -Path $PROFILE
}

echo '# Oxidizer' >> $PROFILE

if ( [string]::IsNullOrEmpty($env:OXIDIZER) ) {
    if ( [Environment]::OSVersion.VersionString.Contains("Unix") ) {
        echo '
        $env:OXIDIZER = "$env:HOME\oxidizer"' >> $PROFILE
    }
    else {
        echo '$env:OXIDIZER = "$HOME\oxidizer"' >> $PROFILE
    }
    echo '. $env:OXIDIZER\oxidizer.ps1' >> $PROFILE
}
else {
    echo ". $env:OXIDIZER\oxidizer.ps1" >> $PROFILE
}

echo "Adding Custom settings..."
Copy-Item -Verbose -Force -Path "$env:OXIDIZER\defaults.ps1" -Destination "$env:OXIDIZER\custom.ps1"

# loading zoxide
sd '.* OX_STARTUP=.*' '$Global:OX_STARTUP=1' "$env:OXIDIZER\custom.ps1"

# set path of oxidizer
sd '= .*\\oxidizer.ps1' "= $env:OXIDIZER\oxidizer.ps1" $PROFILE

###################################################
# Loading Plugins
###################################################

. $PROFILE

if ( !(Test-Path "$env:OXIDIZER\plugins") ) {
    mkdir -p "$env:OXIDIZER\plugins"
}


curl -o "$env:OXIDIZER\plugins\ox-utils.ps1" https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/ox-utils.ps1
curl -o "$env:OXIDIZER\plugins\ox-pueue.ps1" https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/ox-pueue.ps1
curl -o "$env:OXIDIZER\plugins\ox-windows.ps1" https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/ox-windows.ps1

if ( $(uname).Contains("Windows") ) {
    curl -o "$env:OXIDIZER\plugins\ox-scoop.ps1" https://raw.githubusercontent.com/ivaquero/oxidizer-plugins/main/pwsh-plugins/ox-scoop.ps1
}

# reg import \"$dir\\install-associations.reg\"

echo "Oxidizer installation complete!"

echo "Don't forget to restart your terminal."
