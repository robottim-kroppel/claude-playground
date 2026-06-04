#!/bin/bash
cd "$(dirname "$0")"
terraform init
terraform apply -var="project_id=kroppel-ai"
