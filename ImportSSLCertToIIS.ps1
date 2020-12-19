$templateName = 'JamWebCert'
$cert = Get-ChildItem 'Cert:\LocalMachine\My' | Where-Object{ $_.Extensions | Where-Object{ ($_.Oid.FriendlyName -eq 'Certificate Template Information') -and ($_.Format(0) -match $templateName) }}
#$thumbprint = $cert.Thumbprint
$iisSite = "WSUS Administration"

$sysinfo = Get-WmiObject -Class Win32_ComputerSystem
$server = “{0}.{1}” -f $sysinfo.Name, $sysinfo.Domain

New-WebBinding -name $iisSite -Protocol https -HostHeader $server -Port 8531 -SslFlags 1
$binding = Get-WebBinding -Name $iisSite -Protocol https  
if ($binding) {
    $binding.AddSslCertificate($cert.GetCertHashString(), "my")
}
