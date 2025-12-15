if ($($env:OS).Contains('Windows')) {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Output 'Scoop Already Installed'
    }
    else {
        Write-Output 'Scoop Not Found. Installing...'
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm

        $f_scoop = Join-Path $HOME 'install.ps1'
        $dir_scoop = 'C:\Scoop'

        if ( $env:scoop_mirror ) {
            Invoke-WebRequest 'https://gitee.com/glsnames/scoop-installer/raw/master/bin/install.ps1' -UseBasicParsing -OutFile $f_scoop

            scoop config SCOOP_REPO 'https://gitee.com/glsnames/scoop-installer'
        }
        else {
            Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Install/master/install.ps1' -UseBasicParsing -OutFile $f_scoop
        }
        if ( $env:scoop_test ) { & $f_scoop -RunAsAdmin -ScoopDir $dir_scoop }
        else { & $f_scoop -ScoopDir $dir_scoop }
    }

    scoop install aria2 7zip

    # add additional buckets
    if ( $env:scoop_mirror ) {
        $scoopBuckets = @('nerd-fonts https://gitee.com/scoop-bucket/nerd-fonts', 'extras https://gitee.com/scoop-bucket/extras.git')
    }
    else {
        $scoopBuckets = @('nerd-fonts', 'extras')
    }

    foreach ( $bucket in $scoopBuckets ) {
        scoop bucket add $bucket
    }

    scoop bucket add main-plus https://github.com/Scoopforge/Main-Plus
    scoop bucket add extras-plus https://github.com/Scoopforge/Extras-Plus

    if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
        $env:OXIDIZER = "$HOME\oxidizer"
        Write-Output '# oxidizer' >> $Global:OX_SHELL
        Write-Output 'export OXIDIZER=${HOME}/oxidizer' >> $Global:OX_SHELL
        Write-Output 'source ${OXIDIZER}/oxidizer.sh' >> $Global:OX_SHELL
    }
    $pkgs = cat "$env:OXIDIZER\defaults\install.txt"

    foreach ( $pkg in $pkgs ) {
        switch ($pkg) {
            ripgrep { $cmd = 'rg' }
            tlrc { $cmd = 'tldr' }
            zoxide { $cmd = 'z' }
            default { $cmd = $pkg }
        }
        if (Get-Command $cmd -ErrorAction SilentlyContinue) {
            Write-Output "$pkg installed, skipping..."
        }
        else {
            Write-Output "$pkg not found, installing..."
            scoop install $pkg
        }
        scoop install busybox sudo scoop-completion scoop-search
    }
}

if (Get-Command scoop -ErrorAction SilentlyContinue ) {
    Write-Output 'Import-Module scoop-completion' >> $PROFILE
    Write-Output 'Invoke-Expression (&scoop-search --hook)' >> $PROFILE
}

###################################################
# Update PowerShell Settings
###################################################

Remove-Item alias:cp -Force -ErrorAction SilentlyContinue

Write-Output "Adding oxidizer into $PROFILE..."

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Force -Path $PROFILE
}

Write-Output '# oxidizer' >> $PROFILE

if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    if ($($env:OS).Contains('Windows')) {
        Write-Output '
        $env:OXIDIZER = "$HOME\oxidizer"' >> $PROFILE
    }
    else {
        Write-Output '
        $env:OXIDIZER = "$env:HOME\oxidizer"' >> $PROFILE
    }
}
else {
    Write-Output '
        $env:OXIDIZER = "$env:OXIDIZER"' >> $PROFILE
}

Write-Output ". $env:OXIDIZER\oxidizer.ps1" >> $PROFILE
Write-Output 'Adding Custom settings...'

if (!(Test-Path -Path "$env:OXIDIZER\custom.json")) {
    Copy-Item -R -v "$env:OXIDIZER\defaults\default.json" "$env:OXIDIZER\custom.json"
}

###################################################
# Load Plugins
###################################################

Set-Location $env:OXIDIZER

if ($($env:OS).Contains('Windows')) {
    git clone --depth=1 https://github.com/ivaquero/oxplugins-pwsh.git ./addons
}
else { git clone --depth=1 https://github.com/ivaquero/oxplugins.git ./plugins }

###################################################
# Extras Steps
###################################################

if ($($env:OS).Contains('Windows')) {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        scoop install vscode
        reg import "$dir_scoop\apps\vscode\current\install-associations.reg"
        reg import "$dir_scoop\apps\vscode\current\install-context.reg"
        reg import "$dir_scoop\apps\vscode\current\install-github-integration.reg"
    }
}

. $PROFILE

Write-Output 'oxidizer installation complete!'
Write-Output "Don't forget to restart your terminal and hit 'edf ox' to tweak your preferences.\n"
Write-Output "Finally, run 'upox' function to activate the plugins. Enjoy!"
