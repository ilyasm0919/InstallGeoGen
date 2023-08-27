# Ask user for options
$geometry = $Host.UI.PromptForChoice("Geometry", "Do you want to install Geometry?", ("&Yes", "&No"), 0)
$extending = $Host.UI.PromptForChoice("Simplifier", "Do you want to install Geometry Extending?", ("&Yes", "&No"), 0)

# Prepare
$source = "https://github.com/ilyasm0919/InstallGeoGen/raw/main"
$release = "https://github.com/ilyasm0919/InstallGeoGen/releases/latest/download"
$releaseGeometry = "https://github.com/ilyasm0919/Geometry/releases/latest/download"
$inferenceRules = "Source/Library/GeoGen.TheoremProver.InferenceRuleProvider/Rules"
$introductionRules = "Source/Library/GeoGen.TheoremProver.ObjectIntroductionRuleProvider/Rules"

# Download settings, example of input and runner
Invoke-WebRequest "$source/GeoGen/settings.json" -OutFile "settings.json"
Invoke-WebRequest "$source/GeoGen/input.txt" -OutFile "input.txt"
Invoke-WebRequest "$source/GeoGen.bat" -OutFile "GeoGen.bat"

# Download and unpack GeoGen
Invoke-WebRequest "$release/GeoGen.zip" -OutFile "GeoGen.zip"
Expand-Archive "GeoGen.zip" -DestinationPath "bin"
Remove-Item "GeoGen.zip"
Set-Location "bin"

# Download integration
Invoke-WebRequest "$releaseGeometry/GeoGenIntegration.exe" -OutFile "GeoGenIntegration.exe"

# Download GeoGen rules
git init
git remote add origin "https://github.com/PatrikBak/GeoGen"
git sparse-checkout set $inferenceRules $introductionRules
git pull origin master
Copy-Item -Path $inferenceRules -Destination "InferenceRules" -Recurse
Copy-Item -Path "$introductionRules\*" -Destination "."
Remove-Item (".git", "Source") -Recurse -Force

# Download Geometry Extending and add to runner
if ($extending -eq 0) {
    Invoke-WebRequest "$release/GeometryExtending.exe" -OutFile "GeometryExtending.exe"
    Add-Content "..\GeoGen.bat" -Value "bin\GeometryExtending.exe Output\"
}

# Download Geometry and run installer
if ($geometry -eq 0) {
    Invoke-WebRequest "$releaseGeometry/Geometry.Desktop.exe" -OutFile "GeometryInstaller.exe"
    .\GeometryInstaller.exe
}

# Restore location
Set-Location ".."
