#!/bin/bash
set -euo pipefail

# Homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Terraform (via official HashiCorp tap)
if ! command -v terraform &>/dev/null; then
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
fi

# Google Cloud SDK (provides gcloud, needed for auth and Secret Manager access)
if ! command -v gcloud &>/dev/null; then
  brew install --cask google-cloud-sdk
fi

echo "All prerequisites installed."
echo ""
echo "If this is your first time, authenticate with GCP by running:"
echo "  gcloud auth application-default login"
