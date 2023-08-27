@echo off
if exist "Output" rmdir /s /q "Output"
mkdir "Output\GeoGen"
bin\GeoGen.exe "settings.json" || exit
for %%f in (Output\*) do bin\GeoGenIntegration.exe "Output\GeoGen\%%f" "Output"
