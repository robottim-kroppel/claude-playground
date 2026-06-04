#!/bin/bash
# NOTE: gcp-devops@${GCP_DOMAIN} must already exist as a Google Workspace / Cloud Identity
# account before this script can assign roles to it. gcloud cannot create Google accounts.
set -euo pipefail

PROJECT_ID="kroppel-ai"
GCP_DOMAIN="kroppel.net"
DEVOPS_PRINCIPAL="user:gcp-devops@${GCP_DOMAIN}"
TF_BACKEND_BUCKET="terraform-backend"

project_roles=(
  "roles/serviceusage.serviceUsageAdmin"  # google_project_service
  "roles/iam.serviceAccountAdmin"         # google_service_account
  "roles/iam.serviceAccountUser"          # attaching SA to compute instance
  "roles/resourcemanager.projectIamAdmin" # google_project_iam_member
  "roles/secretmanager.admin"             # google_secret_manager_secret / _version
  "roles/compute.instanceAdmin.v1"        # google_compute_instance
)

for role in "${project_roles[@]}"; do
  gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member="$DEVOPS_PRINCIPAL" \
    --role="$role"
done

gcloud storage buckets add-iam-policy-binding "gs://$TF_BACKEND_BUCKET" \
  --member="$DEVOPS_PRINCIPAL" \
  --role="roles/storage.objectAdmin"
