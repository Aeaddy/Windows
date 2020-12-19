$RCP = "\\hyperv1\Media\source files\Certificates\wildcardServerAuth.pfx"
$LCP = "$env:TEMP\wildcardServerAuth.pfx"
$testPath = (Test-Path $LCP)
if ($testPath -eq $false) { Copy-Item $RCP $LCP -Force }
$A1 = [string][char[]][int[]]("80.97.115.115.119.111.114.100.49.50.51".Split(".")) -replace " "
$A2 = ConvertTo-SecureString -String $A1 -AsPlainText -Force
Import-PFXCertificate -FilePath $LCP -CertStoreLocation Cert:\LocalMachine\My -Exportable -Password $A2

