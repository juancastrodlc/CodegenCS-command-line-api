#!/usr/bin/env pwsh

# Detect platform
$isWindowsPlatform = [System.Runtime.InteropServices.RuntimeInformation]::IsOSPlatform([System.Runtime.InteropServices.OSPlatform]::Windows)

# Cross-platform NuGet packages cleanup
if ($isWindowsPlatform) {
    Remove-Item -Recurse "$env:USERPROFILE\.nuget\packages\System.CommandLine*" -Force -ErrorAction SilentlyContinue
} else {
    Remove-Item -Recurse "$env:HOME/.nuget/packages/System.CommandLine*" -Force -ErrorAction SilentlyContinue
}

# build and pack dotnet-interactive
dotnet clean
dotnet pack  /p:PackageVersion=2.0.0-dev

# copy the dotnet-interactive packages to the temp directory
$tempDir = [System.IO.Path]::GetTempPath()
Get-ChildItem -Recurse -Filter *.nupkg | Copy-Item -Destination $tempDir -Force

