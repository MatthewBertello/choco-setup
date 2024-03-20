Set-ExecutionPolicy Bypass -Scope Process -Force

if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco install dotnet -y
choco install vmware-workstation-player -y
choco install notepadplusplus.install -y
choco install firefox -y
choco install googlechrome -y
choco install dart-sdk -y
choco install flutter -y
choco install bitwarden -y
choco install vscode -y
choco install steam -y
choco install leagueoflegends -y
choco install python3 -y
choco install gitkraken -y
choco install osu -y
choco install github-desktop -y
choco install geforce-experience -y
choco install vlc -y
choco install obs-studio.install -y
choco install discord.install -y
choco install autodesk-fusion360 -y
choco install prusaslicer -y
choco install lycheeslicer -y
choco install tightvnc -y
choco install make -y
choco install winscp.install -y
choco install putty.install -y
choco install wireguard -y
choco install parsec --params "/Shared" -y
choco install teamviewer -y
choco install uvtools -y
choco install steelseries-engine -y
choco install vortex -y
choco install git.install --params "'/GitAndUnixToolsOnPath'" -y
choco install msys2 -y
choco install mingw -y
choco install androidstudio -y
choco install chocolateygui --params="'/DefaultToDarkMode=$true'" -y
choco install microsoft-teams.install -y
choco install zoom -y
choco install 7zip.install -y
choco install nodejs.install -y
choco install autohotkey.install -y
choco install powertoys -y
choco install openjdk -y
choco install wiztree -y
choco install everything --params "/client-service /efu-association /start-menu-shortcuts /run-on-system-startup" -y
choco install gimp -y
choco install krita -y
choco install samsung-magician -y
choco install sublimetext4 -y
choco install arduino -y
choco install epicgameslauncher -y
choco install visualstudio2022community -y
choco install visualstudio2022-workload-nativedesktop -y
choco install visualstudio2022-workload-netcrossplat -y
choco install visualstudio2022-workload-manageddesktop -y