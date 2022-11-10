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

scoop install aria2
scoop install 7zip

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
    switch ( $pkg ) {
        bottom { $cmd = 'btm' }
        ripgrep { $cmd = 'rg' }
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

Write-Output "Adding Oxidizer into $PROFILE..."

if ( !(Test-Path $PROFILE) ) {
    New-Item -ItemType File -Force -Path $PROFILE
}

Write-Output '# Oxidizer' >> $PROFILE

if ( [string]::IsNullOrEmpty($env:OXIDIZER) ) {
    if ( [Environment]::OSVersion.VersionString.Contains("Unix") ) {
        Write-Output '
        $env:OXIDIZER = "$env:HOME\oxidizer"' >> $PROFILE
    }
    else {
        Write-Output '$env:OXIDIZER = "$HOME\oxidizer"' >> $PROFILE
    }
    Write-Output '. $env:OXIDIZER\oxidizer.ps1' >> $PROFILE
}
else {
    Write-Output ". $env:OXIDIZER\oxidizer.ps1" >> $PROFILE
}

Write-Output "Adding Custom settings..."
Copy-Item -Verbose -Force -Path "$env:OXIDIZER\defaults.ps1" -Destination "$env:OXIDIZER\custom.ps1"

# loading zoxide
sd '.* STARTUP=.*' '$Global:STARTUP=1' "$env:OXIDIZER\custom.ps1"

# set path of oxidizer
sd '= .*\\oxidizer.ps1' "= $env:OXIDIZER\oxidizer.ps1" $PROFILE

Write-Output "Oxidizer installation complete!"

Write-Output "Don't forget to restart your terminal."

. $PROFILE
