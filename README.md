# Install GeoGen

This is an automated script to install [GeoGen](https://github.com/PatrikBak/GeoGen/) and integrate with [Geometry](https://github.com/ilyasm0919/Geometry/). It can also install [Geometry Extending](https://github.com/GrafGeometr/GeometryExtending).

You don't need anything, just Windows and the internet connection. It is recommended to install in an empty directory.

## Install using the PowerShell command

Run the following PowerShell command from the installation location:

```
Invoke-WebRequest -UseBasicParsing "https://github.com/ilyasm0919/InstallGeoGen/raw/main/install.ps1" | Invoke-Expression
```

## Install using a PowerShell script

Download and run [`install.ps1`](https://github.com/ilyasm0919/InstallGeoGen/tree/main/install.ps1) from the installation location.

## Run GeoGen

Put your initial configuration in the `input.txt` and run the `GeoGen.bat`. The output files will be located in the `Output` folder. You can open them with `Geometry` program (`Open with` > `Look for another app on this PC` > `Geometry Desktop` > `Geometry Desktop.exe`)
