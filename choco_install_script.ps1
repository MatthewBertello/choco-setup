# Chocolatey install script

Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Chocolatey if it is not already installed
if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

#Install Chocolatey packages
#=================================
choco install chocolateygui --params="'/DefaultToDarkMode=$true'" -y # The /DefaultToDarkMode argument sets the default theme to dark mode

#dev
choco install dart-sdk -y
choco install flutter -y
choco install make -y
choco install git.install --params "'/GitAndUnixToolsOnPath'" -y # The /GitAndUnixToolsOnPath argument adds git and unix tools to the system path
choco install mingw -y
choco install openjdk -y
choco install visualstudio2022community -y
choco install visualstudio2022-workload-nativedesktop -y
choco install visualstudio2022-workload-netcrossplat -y
choco install visualstudio2022-workload-manageddesktop -y

#misc
choco install autodesk-fusion360 -y
choco install lycheeslicer -y
choco install parsec --params "/Shared" -y # The /Shared argument allows connections from the lock screen
choco install everything --params "/client-service /efu-association /start-menu-shortcuts /run-on-system-startup" -y # The /client-service argument installs the Everything service, the /efu-association argument associates the .efu file extension with Everything, the /start-menu-shortcuts argument creates start menu shortcuts, and the /run-on-system-startup argument runs Everything on system startup
choco install nerd-fonts-robotomono -y
#================================

# Winget install script
# Based on this gist: https://gist.github.com/codebytes/29bf18015f6e93fca9421df73c6e512c

# Check if winget is installed and install it if it is not installed or if it is an older version
# Based on this gist: https://gist.github.com/crutkas/6c2096eae387e544bd05cde246f23901
$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.10.0.0") {
    "Installing winget Dependencies"
    Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

    $releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri $releases_url
    $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('msixbundle') } | Select-Object -First 1

    "Installing winget from $($latestRelease.browser_download_url)"
    Add-AppxPackage -Path $latestRelease.browser_download_url
}
else {
    "winget already installed"
}


# The list of apps to install by id
$apps = @(
    #general
    @{name = "Mozilla.Firefox" },
    @{name = "Google.Chrome" },
    @{name = "Bitwarden.Bitwarden" },
    @{name = "Discord.Discord" },
    @{name = "VideoLAN.VLC" },
    @{name = "Microsoft.Teams" },
    @{name = "Zoom.Zoom" },
    @{name = "7zip.7zip" },
    @{name = "Microsoft.PowerToys" },
    @{name = "Microsoft.WindowsTerminal" },
    @{name = "9MSMLRH6LZF3"; source = "msstore" }, # Windows notepad
    @{name = "NordSecurity.NordVPN" },
    @{name = "9WZDNCRD29V9" }, # Microsoft 365 (Office)
    @{name = "Google.QuickShare" },

    #dev
    @{name = "Notepad++.Notepad++" }, 
    @{name = "Microsoft.VisualStudioCode" },
    @{name = "Mozilla.Firefox.DeveloperEdition" },
    @{name = "python3" },
    @{name = "Axosoft.GitKraken" },
    @{name = "GitHub.GitHubDesktop" },
    @{name = "PuTTY.PuTTY" },
    @{name = "Google.AndroidStudio" },
    @{name = "CoreyButler.NVMforWindows" },
    @{name = "SublimeHQ.SublimeText.4" },
    @{name = "ArduinoSA.IDE.stable" },
    @{name = "Docker.DockerDesktop" },
    @{name = "GitHub.cli" },

    #games
    @{name = "Valve.Steam" },
    @{name = "RiotGames.LeagueOfLegends.NA" },
    @{name = "Peppy.Osu!" },
    @{name = "NexusMods.Vortex" },
    @{name = "EpicGames.EpicGamesLauncher" },
    
    #desktop only
    @{name = "Nvidia.GeForceExperience" },
    @{name = "SteelSeries.GG" },
    @{name = "Samsung.SamsungMagician" },
    
    #misc
    @{name = "Prusa3D.PrusaSlicer" },
    @{name = "PTRTECH.UVtools" },
    @{name = "VMware.WorkstationPlayer" }, 
    @{name = "obs" },
    @{name = "GlavSoft.TightVNC" },
    @{name = "WinSCP.WinSCP" },
    @{name = "WireGuard.WireGuard" },
    @{name = "TeamViewer.TeamViewer" },
    @{name = "AutoHotkey.AutoHotkey" },
    @{name = "AntibodySoftware.WizTree" },
    @{name = "GIMP.GIMP" },
    @{name = "KDE.Krita" },
    @{name = "JanDeDobbeleer.OhMyPosh" },
    @{name = "9N9WCLWDQS5J" } # Bluetooth audio receiver
);

# Loop through the list of apps and install them
Foreach ($app in $apps) {
    Write-host "Installing:" $app.name
    # Winget documentation found at https://learn.microsoft.com/en-us/windows/package-manager/winget/install
    # --exact : Uses the exact string in the query, including checking for case-sensitivity. It will not use the default behavior of a substring.
    # --silent : Runs the installer in silent mode. This suppresses all UI. The default experience shows installer progress.
    # --source : Restricts the search to the source name provided. Must be followed by the source name.
    # --accept-package-agreements : Used to accept the license agreement, and avoid the prompt.
    if ($null -ne $app.source) {
        # If the app has a specific source, install it from that source
        winget install --exact --silent $app.name --source $app.source --accept-package-agreements
    }
    else {
        # If the app does not have a source then install it from the default source
        winget install --exact --silent $app.name --accept-package-agreements
    }
}

# Install Windows Subsystem for Linux
wsl --install