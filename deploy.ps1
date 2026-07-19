$ErrorActionPreference = "Stop"
Write-Host "Building Flutter web app..."
flutter build web --release --base-href /EDUPOL/

Write-Host "Preparing deployment folder..."
if (Test-Path "tmp_deploy") { Remove-Item -Recurse -Force "tmp_deploy" }
New-Item -ItemType Directory -Force -Path "tmp_deploy" | Out-Null
Copy-Item -Path "build\web\*" -Destination "tmp_deploy" -Recurse
Set-Location "tmp_deploy"

Write-Host "Initializing git and pushing to gh-pages..."
git init
git add .
git commit -m "Deploy to GitHub Pages"
git push https://github.com/pnp-edu/EDUPOL.git HEAD:gh-pages --force

Set-Location ..
Remove-Item -Recurse -Force "tmp_deploy"
Write-Host "Deployed successfully to GitHub Pages!"
