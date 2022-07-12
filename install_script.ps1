<#set default output encoding of >>/> to utf8#>
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$hdd_size = Read-Host -Prompt "Enter HDD in gigabytes eg 1 for 1gb ,2 for 2gb etc " 
$hdd = "hd_"+$hdd_size+"gig"
type win98.conf > win98_install.conf


echo "IMGMAKE win98.img -t $hdd" >> win98_install.conf
echo "IMGMOUNT C win98.img" >> win98_install.conf

echo "IMGMOUNT D win98.iso" >> win98_install.conf
echo "IMGMOUNT A -bootcd D" >> win98_install.conf
echo "BOOT A:" >> win98_install.conf


<#Get-Content .\win98_install.conf | Set-Content -Encoding utf8 win98_install-utf8.conf#>
<#.\dosbox-x.exe -conf .\win98_install-utf8.conf#>

.\dosbox-x.exe -conf .\win98_install.conf