# Windows setup script

Set-ExecutionPolicy Bypass -Scope Process -Force

# Chocolatey setup script

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

#games
choco install osu -y

#desktop only
choco install samsung-magician -y

#================================
# Winget install script
# Must manually make sure that Winget is installed first

# The list of apps to install by id
$wingetPackages = @(
    #general
    @{name = "Mozilla.Firefox" },
    @{name = "Google.Chrome" },
    @{name = "Bitwarden.Bitwarden" },
    @{name = "Discord.Discord" },
    @{name = "VideoLAN.VLC" },
    @{name = "XP8BT8DW290MPQ"; source = "msstore" },
    @{name = "Zoom.Zoom" },
    @{name = "7zip.7zip" },
    @{name = "Microsoft.PowerToys" },
    @{name = "Microsoft.WindowsTerminal" },
    @{name = "9MSMLRH6LZF3"; source = "msstore" }, # Windows notepad
    @{name = "NordSecurity.NordVPN" },
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
    @{name = "9PGCV4V3BK4W"; source = "msstore" }, # DevToys

    #games
    @{name = "Valve.Steam" },
    @{name = "RiotGames.LeagueOfLegends.NA" },
    @{name = "NexusMods.Vortex" },
    @{name = "EpicGames.EpicGamesLauncher" },
    
    #desktop only
    @{name = "Nvidia.GeForceExperience" },
    @{name = "SteelSeries.GG" },
    
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
    @{name = "REALiX.HWiNFO" },
    @{name = "9NBLGGH43VHV"; source = "msstore" }, # Samsung Notes
    @{name = "UnifiedIntents.UnifiedRemote" },
    @{name = "9N9WCLWDQS5J"; source = "msstore" } # Bluetooth audio receiver
);

# Loop through the list of apps and install them
Foreach ($app in $wingetPackages) {
    # This line is commented out so errors will be displayed if they occur
    # Write-host "Installing:" $app.name

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