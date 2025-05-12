# Variables
$imagePath = "\\SRV-DEPLOY\Deploy$\Images\Win10_22H2.wim"
$scriptsPath = "\\SRV-DEPLOY\Deploy$\Scripts"

# 1. Partitionnement
Start-Process -FilePath "diskpart" -ArgumentList "/s $scriptsPath\partition.txt" -Wait -NoNewWindow

# 2. Application de l'image
dism /apply-image /imagefile:$imagePath /index:1 /applydir:D:\

# 3. Configuration du boot
bcdboot D:\Windows /s S: /f UEFI

# 4. Post-installation
Copy-Item "$scriptsPath\Join-Domain.ps1" -Destination "D:\Windows\Setup\Scripts\"

# 5. Redémarrage
Write-Output "Déploiement terminé. Redémarrage dans 10 secondes..."
Start-Sleep -Seconds 10
Restart-Computer -Force