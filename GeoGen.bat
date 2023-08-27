@echo off
if exist "Output" rmdir /s /q "Output"
mkdir "Output\GeoGen"
bin\GeoGen.MainLauncher.exe "settings.json" || exit
for %%f in (Output\GeoGen\*) do bin\GeoGenIntegration.exe "%%f" "Output"
