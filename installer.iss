[Setup]
AppName=Aim Pointer Game
AppVersion=1.0
DefaultDirName={autopf}\Aim Pointer Game
DefaultGroupName=Aim Pointer Game
OutputBaseFilename=AimPointerGameSetup
SetupIconFile=dist\main.ico
Compression=lzma
SolidCompression=yes

[Files]
Source: "dist\aim_pointer_game.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\SDL2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\SDL2_ttf.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\SDL2_mixer.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\sound.mp3"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\font.otf"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\main.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Aim Pointer Game"; Filename: "{app}\aim_pointer_game.exe"; IconFilename: "{app}\main.ico"
Name: "{group}\Uninstall Aim Pointer Game"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\aim_pointer_game.exe"; Description: "Launch Aim Pointer Game"; Flags: nowait postinstall skipifsilent shellexec
