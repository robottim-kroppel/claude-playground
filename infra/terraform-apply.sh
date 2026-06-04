#!/bin/bash
cd "$(dirname "$0")"
gcloud auth application-default login
terraform init
terraform apply -var="project_id=kroppel-ai" -var="region=us-west1" -var="zone=us-west1-c" -var="service_account_id=air-traffic-controller"
