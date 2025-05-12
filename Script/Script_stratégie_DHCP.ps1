# Nom d’hôte du serveur DHCP
$DhcpServerName = "SRV-PXE"
# Adresse IP du serveur WDS (PXE)
$PxeServerIp = "192.168.20.133"
# Adresse réseau de l’étendue DHCP ciblée
$scope = "192.168.20.0"

# Ajouter les différentes Classes
Add-DhcpServerv4Class -ComputerName $DhcpServerName -Name "PXEClient - UEFI x64" -Type Vendor -Data "PXEClient:Arch:00007" -Description "PXEClient:Arch:00007"
Add-DhcpServerv4Class -ComputerName $DhcpServerName -Name "PXEClient - UEFI x86" -Type Vendor -Data "PXEClient:Arch:00006" -Description "PXEClient:Arch:00006"
Add-DhcpServerv4Class -ComputerName $DhcpServerName -Name "PXEClient - BIOS x86 et x64" -Type Vendor -Data "PXEClient:Arch:00000" -Description "PXEClient:Arch:00000"

# Ajouter les Options pour les clients BIOS X86 et X64
$PolicyNameBIOS = "PXEClient - BIOS x86 et x64"
Add-DhcpServerv4Policy -ComputerName $DhcpServerName -ScopeId $scope -Name $PolicyNameBIOS -Description "Options DHCP pour boot BIOS x86 et x64" -Condition Or -VendorClass EQ, "PXEClient - BIOS x86 et x64"
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 066 -Value $PxeServerIp -PolicyName $PolicyNameBIOS
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 067 -Value boot\x64\wdsmgfw.efi -PolicyName $PolicyNameBIOS

# Ajouter les Options pour les clients  UEFI x86
$PolicyNameUEFIx86 = "PXEClient - UEFI x86"
Add-DhcpServerv4Policy -ComputerName $DhcpServerName -ScopeId $scope -Name $PolicyNameUEFIx86 -Description "Options DHCP pour boot UEFI x86" -Condition Or -VendorClass EQ, "PXEClient - UEFI x86"
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 060 -Value PXEClient -PolicyName $PolicyNameUEFIx86
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 066 -Value $PxeServerIp -PolicyName $PolicyNameUEFIx86
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 067 -Value boot\x86\wdsmgfw.efi -PolicyName $PolicyNameUEFIx86

# Ajouter les Options pour les clients  UEFI x64
$PolicyNameUEFIx64 = "PXEClient - UEFI x64"
Add-DhcpServerv4Policy -ComputerName $DhcpServerName -ScopeId $scope -Name $PolicyNameUEFIx64 -Description "Options DHCP pour boot UEFI x64" -Condition Or -VendorClass EQ, "PXEClient - UEFI x64"
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 060 -Value PXEClient -PolicyName $PolicyNameUEFIx64
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 066 -Value $PxeServerIp -PolicyName $PolicyNameUEFIx64
Set-DhcpServerv4OptionValue -ComputerName $DhcpServerName -ScopeId $scope -OptionId 067 -Value boot\x64\wdsmgfw.efi -PolicyName $PolicyNameUEFIx64
