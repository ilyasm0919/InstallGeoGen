# Ask user for options
$dotnet = $Host.UI.PromptForChoice(".NET", "Do you want to install .NET 7.0 (it is required to run GeoGen)?", ("&Yes", "&No"), 0)
$geometry = $Host.UI.PromptForChoice("Geometry", "Do you want to install Geometry?", ("&Yes", "&No"), 0)
$extending = $Host.UI.PromptForChoice("Simplifier", "Do you want to install Geometry Extending?", ("&Yes", "&No"), 0)

# Prepare
$source = "https://github.com/ilyasm0919/InstallGeoGen/raw/main"
$release = "https://github.com/ilyasm0919/InstallGeoGen/releases/latest/download"
$releaseGeometry = "https://github.com/ilyasm0919/Geometry/releases/latest/download"

# Install dotnet
if ($dotnet -eq 0) {
    winget install Microsoft.DotNet.Runtime.7
}

# Download settings, example of input and runner
Invoke-WebRequest -UseBasicParsing "$source/GeoGen/settings.json" -OutFile "settings.json"
Invoke-WebRequest -UseBasicParsing "$source/GeoGen/input.txt" -OutFile "input.txt"
Invoke-WebRequest -UseBasicParsing "$source/GeoGen.bat" -OutFile "GeoGen.bat"

# Download and unpack GeoGen
Invoke-WebRequest -UseBasicParsing "$release/GeoGen.zip" -OutFile "GeoGen.zip"
Expand-Archive "GeoGen.zip" -DestinationPath "bin"
Remove-Item "GeoGen.zip"
Set-Location "bin"

# Download integration
Invoke-WebRequest -UseBasicParsing "$releaseGeometry/GeoGenIntegration.exe" -OutFile "GeoGenIntegration.exe"

# Download Geometry Extending and add to runner
if ($extending -eq 0) {
    Invoke-WebRequest -UseBasicParsing "$release/GeometryExtending.exe" -OutFile "GeometryExtending.exe"
    Add-Content "..\GeoGen.bat" -Value "bin\GeometryExtending.exe Output\"
}

# Download Geometry and run installer
if ($geometry -eq 0) {
    Invoke-WebRequest -UseBasicParsing "$releaseGeometry/Geometry.Desktop.exe" -OutFile "GeometryInstaller.exe"
    .\GeometryInstaller.exe
}

# Restore location
Set-Location ".."
