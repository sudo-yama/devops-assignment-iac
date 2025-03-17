📌 Overview
The 000-gcs module is responsible for creating a Google Cloud Storage (GCS) bucket to serve as the Terraform Remote Backend. Instead of storing the terraform.tfstate file locally, this setup ensures state persistence in GCS, enabling collaboration and better state management.

⚙️ Prerequisites
Before using this module, ensure you have:
✅ A Google Cloud Project (with a valid project_id)
✅ Google Cloud Storage API enabled
✅ A Service Account JSON key with roles/storage.admin permission
✅ Terraform installed (recommended version >=1.3)
✅ gcloud CLI installed (for creating a Service Account)

🔑 Step 1: Set Up Credentials for Terraform
Terraform requires authentication to interact with Google Cloud. You can provide credentials using an environment variable.

Windows (PowerShell or CMD)

Move the Service Account JSON key to a secure location, e.g.:
    C:\Users\YourUsername\develop.json

Set the GOOGLE_APPLICATION_CREDENTIALS environment variable:
PowerShell:
    $env:GOOGLE_APPLICATION_CREDENTIALS="C:\Users\YourUsername\develop.json"

Command Prompt (CMD):
    set GOOGLE_APPLICATION_CREDENTIALS=C:\Users\YourUsername\develop.json

Verify the variable is set correctly:
    echo $env:GOOGLE_APPLICATION_CREDENTIALS  # PowerShell

    echo %GOOGLE_APPLICATION_CREDENTIALS%  # CMD

macOS/Linux (Bash or Zsh)

Move the Service Account JSON key to a secure location, e.g.:
    mv ~/Downloads/develop.json ~/.gcp/develop.json

Set the GOOGLE_APPLICATION_CREDENTIALS environment variable:
    export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/develop.json"

To make this setting permanent, add it to ~/.bashrc or ~/.zshrc:
    echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/develop.json"' >> ~/.bashrc  # For Bash

    echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/develop.json"' >> ~/.zshrc  # For Zsh

Verify the variable is set correctly:

echo $GOOGLE_APPLICATION_CREDENTIALS

🏗 Step 2: Initialize and Apply the Terraform Configuration
Once credentials are set, proceed with Terraform commands:

terraform init
terraform fmt -check
terraform plan
terraform apply -auto-approve

