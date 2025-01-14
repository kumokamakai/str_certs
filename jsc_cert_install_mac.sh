#!/bin/bash

# Define the name of the script
SCRIPT_NAME="download_certificates.sh"

# Define the content of the original script
cat << 'EOF' > $SCRIPT_NAME
#!/bin/bash

# Define URLs and destination directory
ROOT_CERT_URL="https://github.com/kumokamakai/str_certs/raw/refs/heads/main/root.cer"
INTERMEDIATE_CERT_URL="https://github.com/kumokamakai/str_certs/raw/refs/heads/main/intermediate.cer"
DEST_DIR="/Library/Application Support/Juniper/SecureConnect/cacerts/"

# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo "Creating directory: $DEST_DIR"
    mkdir -p "$DEST_DIR" || { echo "Failed to create directory"; exit 1; }
fi

# Download root certificate
echo "Downloading root certificate..."
curl -L -o "${DEST_DIR}/root.cer" "$ROOT_CERT_URL" || { echo "Failed to download root certificate"; exit 1; }

# Download intermediate certificate
echo "Downloading intermediate certificate..."
curl -L -o "${DEST_DIR}/intermediate.cer" "$INTERMEDIATE_CERT_URL" || { echo "Failed to download intermediate certificate"; exit 1; }

# Confirm success
echo "Certificates have been downloaded and placed in $DEST_DIR"
EOF

# Ensure the script is executable
echo "Making the script executable..."
chmod +x $SCRIPT_NAME || { echo "Failed to make the script executable"; exit 1; }

# Run the script
echo "Running the script..."
sudo ./$SCRIPT_NAME || { echo "Failed to execute the script"; exit 1; }

# Cleanup (optional)
# Uncomment the following line if you want to remove the script after execution
# rm -f $SCRIPT_NAME

echo "Process completed successfully!"
