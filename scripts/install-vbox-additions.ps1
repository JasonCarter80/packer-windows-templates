$targetDir = "C:\Temp\VirtualBox"
$fileName = "$targetDir\VBoxWindowsAdditions-amd64.exe"
$a = New-Item -ItemType Directory -Force -Path $targetDir

(New-Object System.Net.WebClient).DownloadFile("http://download.virtualbox.org/virtualbox/5.1.6/VBoxGuestAdditions_5.1.6.iso", "C:\Users\vagrant\VBoxGuestAdditions.iso")

$before = (Get-Volume).DriveLetter
Mount-DiskImage -ImagePath C:\Users\vagrant\VBoxGuestAdditions.iso 
$after = (Get-Volume).DriveLetter
$driveLetter = compare $before $after -Passthru
$a = Copy-Item "$($driveLetter):\*64.exe" $targetDir -Force 

if(Test-Path $fileName)
{
    Write-Host "Installing Oracle Cert"
    certutil -addstore -f "TrustedPublisher" A:\oracle.cer
	Write-Host "Installing VirtualBox Guest Additions"
	Start-Process -FilePath $fileName -ArgumentList "/S"  -Wait
	Write-Host "Cleaning Up"
	Write-Host ".....not really...TODO"
} 
else 
{
	Write-Host "Guest additions not uploaded"
}