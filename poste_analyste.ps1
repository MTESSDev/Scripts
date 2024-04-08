Write-Host "-----Deplacement pour l'installation dans : ${Env:USERPROFILE} -----" 
Set-Location ${Env:USERPROFILE}

Write-Host "-----Installation de Git------ Debut" 
winget install --id Git.Git -e --source winget
Write-Host "-----Installation de Git------ Fait." 

Write-Host "-----Installation de dotnet------ Debut" 
New-Item -ItemType Directory -Force -Path "${Env:USERPROFILE}\dotnet" -ErrorAction SilentlyContinue
Set-Location ${Env:USERPROFILE}\dotnet


Write-Host "-----Installation de dotnet------ Installation..." 

# Run a separate PowerShell process because the script calls exit, so it will end the current PowerShell session.
&powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -InstallDir ${Env:USERPROFILE}\dotnet -Channel 8.0.1xx"
Write-Host "-----Installation de dotnet------ Fait." 

[Environment]::SetEnvironmentVariable("PATH", "${Env:USERPROFILE}\dotnet;${Env:PATH}", "User")
[Environment]::SetEnvironmentVariable("PATH", "${Env:USERPROFILE}\AppData\Local\Programs\Git\cmd;${Env:PATH}", "User")

Write-Host "-----Termine ! Bons tests !" 
