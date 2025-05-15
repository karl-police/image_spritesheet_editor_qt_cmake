<#
    This file generates ui Headers
    Just like Qt would do; Except that I can control it and run it whenever I want
    without relying on CMake, and then I can have the Header files in Visual Studio IDE
    along with the autocomplete
#>


# Set Path to Qt
$Qt_bin_dir = "D:\Programme\Qt\6.9.0\msvc2022_64\bin"
$env:PATH = "$env:PATH;$Qt_bin_dir"

# For editing convenience
# Note these paths are based on the Project's Path
$_DEFINEABLE_SearchRootDir = "./resources/"
$_DEFINEABLE_outputDir = "./out/ui/"




# Get this script's current path.
$currentRootPath = $PSScriptRoot
# Get the Parent
$currentRootPath = Split-Path $PSScriptRoot -Parent

# Set it as the current path.
$currentPath = $currentRootPath



# Resolve is important here for the function below.
# Otherwise "./" will cause the Substring to cut off too much.

# Define where to look for .ui files
$searchPathDir = Join-Path $currentPath "$_DEFINEABLE_SearchRootDir" -Resolve

# Set the output path for ui files.
$outputRootPathDir = Join-Path $currentPath "$_DEFINEABLE_outputDir"


# Normalize path from resolved path
# Regular "Resolve" would error
function ResolvePathNormalize {
    param (
        [Parameter(Mandatory=$true)]
        $rawPath
    )

    return (New-Object -TypeName System.IO.FileInfo -ArgumentList $rawPath).FullName
}


# Log input and output.
function LogPaths {
    param (
        $inputPath,
        $outputPath
    )
    
    Write-Host "Input: $inputPath"
    Write-Host "Output: $outputPath"
}


Get-ChildItem -Path $searchPathDir -Recurse -Filter "*.ui" | ForEach-Object {
    $inputFileFullPath = $_.FullName

    # We want the path from the folder we're searching inside from, and move it into a "ui" folder.
    # Substring the FullName with the length of the root search directory.
    # It's important to have this processed through "Resolve" first
    $pathMirrorPiece = $inputFileFullPath.Substring($searchPathDir.Length)
    #Write-Host $pathMirrorPiece
    

    # Shape the output filename
    $outputFileName = "ui_$($_.BaseName).h"

    # If the piece is empty, it means the file is directly under the search root directory
    $pathMirrorPiece = Split-Path $pathMirrorPiece -Parent

    #if (-not [string]::IsNullOrWhiteSpace($pathMirrorPiece)) {}
    $pathMirrorPiece = Join-Path "." $pathMirrorPiece # make relative adds "./"
    $pathMirrorPiece = Join-Path $pathMirrorPiece $outputFileName
    #Write-Host $pathMirrorPiece


    # Prepare Mirror Path
    $outputFullPath = Join-Path $outputRootPathDir $pathMirrorPiece
    # Get parent of the file's path e.g. /etc/file1.txt would give /etc/
    # Because otherwise New-Item will create paths even if it's the filename
    $outputFullPath_Parent = Split-Path $outputFullPath -Parent 
    

    # Normalize
    $inputFileFullPath = ResolvePathNormalize $inputFileFullPath
    $outputFullPath = ResolvePathNormalize $outputFullPath
    $outputFullPath_Parent = ResolvePathNormalize $outputFullPath_Parent
    Write-Host ""

    # Logging
    LogPaths -inputPath $inputFileFullPath -outputPath $outputFullPath

    # Create the directories if they don't already exist.
    if (-not (Test-Path $outputFullPath_Parent)) {
        New-Item -Path $outputFullPath_Parent -ItemType Directory | Out-Null
    }

    # Run uic
    # Note: If a file has an error, uic will not output anything.
    uic "$inputFileFullPath" --output "$outputFullPath"
}


Write-Host ""
Write-Host ""
Write-Host "Output finished at: $(ResolvePathNormalize $outputRootPathDir)"

pause