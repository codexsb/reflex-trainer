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
Source: "dist\libopusfile-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libmpg123-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libmodplug-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libfreetype-6.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libharfbuzz-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libogg-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libopus-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libbrotlidec.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libbz2-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libpng16-16.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\zlib1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libglib-2.0-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libgraphite2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libintl-8.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libiconv-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libpcre2-8-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libbrotlicommon.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libstdc++-6.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libgcc_s_seh-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\libwinpthread-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\sound.mp3"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\font.otf"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\main.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Aim Pointer Game"; Filename: "{app}\aim_pointer_game.exe"; IconFilename: "{app}\main.ico"
Name: "{group}\Uninstall Aim Pointer Game"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\aim_pointer_game.exe"; Description: "Launch Aim Pointer Game"; Flags: nowait postinstall skipifsilent shellexec
