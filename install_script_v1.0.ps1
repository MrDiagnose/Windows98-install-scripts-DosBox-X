<#set default output encoding of >>/> to utf8#>
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$_folder_ = "win98_scripts"
if (Test-Path $_folder_){
    Write-Host "Folder Already Exists"
}
else
{
    New-Item $_folder_ -ItemType Directory
    Write-Host "Folder Created Successfully"
}
$win98_conf={[sdl]
autolock=true

[dosbox]
title=Windows 98
memsize=128

[video]
vmemsize=8
vesa modelist width limit=0
vesa modelist height limit=0

[dos]
ver=7.1
hard drive data rate limit=0
floppy drive data rate limit=0

[cpu]
cputype=pentium_mmx
core=normal

[sblaster]
sbtype=sb16vibra

[fdc, primary]
int13fakev86io=true

[ide, primary]
int13fakeio=true
int13fakev86io=true

[ide, secondary]
int13fakeio=true
int13fakev86io=true
cd-rom insertion delay=4000

[render]
scaler=none

[autoexec]}


$hdd_size = Read-Host -Prompt "Enter HDD in gigabytes eg 1 for 1gb ,2 for 2gb etc " 
$hdd = "hd_"+$hdd_size+"gig"
<#type win98.conf > win98_install.conf#>

$install_command={IMGMOUNT C win98.img
IMGMOUNT D win98.iso
IMGMOUNT A -bootcd D
BOOT A:}

echo $win98_conf > "$_folder_\win98_install.conf"
echo "IMGMAKE win98.img -t $hdd" >> "$_folder_\win98_install.conf"
echo $install_command >> "$_folder_\win98_install.conf"


$run_command={IMGMOUNT C win98.img
IMGMOUNT D Win98.iso
BOOT C:}

echo $win98_conf > "$_folder_\win98_run.conf"
echo $run_command >> "$_folder_\win98_run.conf"

<#Get-Content .\win98_install.conf | Set-Content -Encoding utf8 win98_install-utf8.conf#>
<#.\dosbox-x.exe -conf .\win98_install-utf8.conf#>



<#echo "Powershell.exe .\install_script.ps1" > "$_folder_\install_win98.bat"#>

$run_script={start .\dosbox-x.exe -conf .\win98_run.conf
exit}

echo "@echo off" > run_win98.bat
echo "$run_script" >> run_win98.bat


.\dosbox-x.exe -conf "$_folder_\win98_install.conf"