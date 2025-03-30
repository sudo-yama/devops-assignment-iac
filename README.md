# devops-assignment-iac

This project utilizes **Terragrunt** for Infrastructure as Code (IaC) to automate the deployment of infrastructure on Google Cloud Platform (GCP). The goal is to demonstrate best practices in modular, scalable, and maintainable infrastructure management for DevOps job applications.

## 📌 Overview

This repository contains Terraform configurations managed by **Terragrunt**, ensuring better organization, reusability, and state management. The deployment follows a structured pipeline using **GitHub Actions** to automate the process.

### **Infrastructure Modules**

- **00-gcs**: Creates a Google Cloud Storage (GCS) bucket for storing Terraform state.
- **01-vpc**: Deploys the Virtual Private Cloud (VPC) network.
- **02-rds**: Sets up a managed relational database service (RDS) instance.
- **03-gke**: Provisions a Google Kubernetes Engine (GKE) cluster.
- **04-helm**: Deploys applications using Helm on the GKE cluster.
- **05-domain**: Configures domain settings.

## ⚙️ Prerequisites

Before using this project, ensure you have:

✅ A **Google Cloud Project** (with a valid `project_id`) ✅ **Google Cloud Storage API** enabled ✅ A **Service Account JSON key** with necessary permissions (`roles/storage.admin`) ✅ **Terraform** installed (**recommended version >= 1.5.0**) ✅ **gcloud CLI** installed (for authentication & service account management)

---

## 🔧 **Step 1: Set Up Credentials for Terraform**

Terraform requires authentication to interact with Google Cloud. You can provide credentials using an environment variable.

### **Windows (PowerShell or CMD)**

Move the Service Account JSON key to a secure location, e.g.:

```powershell
C:\Users\YourUsername\develop.json
```

Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable:

**PowerShell:**

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS="C:\Users\YourUsername\develop.json"
```

**Command Prompt (CMD):**

```cmd
set GOOGLE_APPLICATION_CREDENTIALS=C:\Users\YourUsername\develop.json
```

Verify the variable is set correctly:

```powershell
echo $env:GOOGLE_APPLICATION_CREDENTIALS  # PowerShell
echo %GOOGLE_APPLICATION_CREDENTIALS%  # CMD
```

### **macOS/Linux (Bash or Zsh)**

Move the Service Account JSON key to a secure location, e.g.:

```bash
mv ~/Downloads/develop.json ~/.gcp/develop.json
```

Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable:

```bash
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/develop.json"
```

To make this setting permanent, add it to `~/.bashrc` or `~/.zshrc`:

```bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/develop.json"' >> ~/.bashrc  # For Bash
echo 'export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/develop.json"' >> ~/.zshrc  # For Zsh
```

Verify the variable is set correctly:

```bash
echo $GOOGLE_APPLICATION_CREDENTIALS
```

---

## 🏗 **Step 2: Initialize and Apply the Terraform Configuration**

Once credentials are set, proceed with Terraform commands:

```bash
cd devops-assignment-iac/environment/01-dev/
terragrunt init
terragrunt apply -auto-approve --terragrunt-working-dir=00-gcs
terragrunt apply -auto-approve --terragrunt-working-dir=01-vpc
terragrunt apply -auto-approve --terragrunt-working-dir=02-rds
terragrunt apply -auto-approve --terragrunt-working-dir=03-gke
terragrunt apply -auto-approve --terragrunt-working-dir=04-helm
terragrunt apply -auto-approve --terragrunt-working-dir=05-domain
```

---

## 🚀 **GitHub Actions Pipeline**

This repository includes a **GitHub Actions** workflow (`.github/workflows/terraform.yml`) that automates deployments when pushing to specific branches:

### **Trigger Conditions:**

- `develop` → Deploys infrastructure for the **development** environment
- `staging` → Deploys infrastructure for the **staging** environment
- `main` → Deploys infrastructure for the **production** environment

### **Pipeline Steps:**

1. **Checkout Code**: Retrieves the latest repository state
2. **Setup Terraform**: Installs Terraform (v1.5.0)
3. **Install Terragrunt**: Downloads and configures Terragrunt (v0.47.2)
4. **Authenticate with GCP**: Uses a Service Account key for GCP authentication
5. **Deploy Infrastructure Modules**:
   - GCS (Remote Backend)
   - VPC
   - RDS
   - GKE Cluster
   - Helm-based deployments
   - Domain Configuration

---

## 📜 **License**

This project is licensed under the **MIT License**.

---

## 📞 **Contact**

For any issues or questions, feel free to create an **Issue** in this repository.

🎯 **Happy DevOps-ing!** 🚀

