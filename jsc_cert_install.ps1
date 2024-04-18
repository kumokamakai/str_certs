# Define the URLs of the files you want to download
$url1 = "https://raw.githubusercontent.com/kumokamakai/str_certs/main/root.cer"
$url2 = "https://raw.githubusercontent.com/kumokamakai/str_certs/main/intermediate.cer"

# Define the directory where you want to save the files
$destinationFolder = "C:\ProgramData\Juniper\SecureConnect\cacerts\"

# Check if the destination folder exists, create if it does not
if (-Not (Test-Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory
}

# Define the paths where the files will be saved
$file1Path = Join-Path -Path $destinationFolder -ChildPath "root.cer"
$file2Path = Join-Path -Path $destinationFolder -ChildPath "intermediate.cer"

# Download the files
Invoke-WebRequest -Uri $url1 -OutFile $file1Path
Invoke-WebRequest -Uri $url2 -OutFile $file2Path

# Output to console
Write-Host "Files downloaded to $destinationFolder"
