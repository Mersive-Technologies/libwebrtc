function ErrorOnExeFailure {
  if (-not $?)
  {
    throw 'Last EXE Call Failed!'
  }
}

Write-Host "Fetching git tags"
git fetch --tags
ErrorOnExeFailure

Write-Host "Configuring with CMake"
mkdir out
cd out
cmake .. -G "Visual Studio 15 2017" -DTARGET_CPU=x64
ErrorOnExeFailure

Write-Host "Performing Build"
msbuild libwebrtc.sln /p:Configuration=Release /p:Platform=x64 /target:ALL_BUILD
ErrorOnExeFailure
