# Sauvegarder dans \\SRV-DEPLOY\Deploy$\Scripts\
$domain = "pxe.local"
$ou = "OU=Workstations,DC=pxe,DC=local"
$credential = New-Object System.Management.Automation.PSCredential("pxe\SVC_JoinDomain", (ConvertTo-SecureString "P@ssw0rdComplexe!" -AsPlainText -Force))

try {
    Add-Computer -DomainName $domain -Credential $credential -OUPath $ou -Force -ErrorAction Stop
    Write-Output "[SUCCESS] Machine jointe au domaine $domain"
} catch {
    Write-Output "[ERROR] Échec de jonction : $_"
    exit 1
}

