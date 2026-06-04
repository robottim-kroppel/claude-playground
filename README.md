# Start Here

This repo is for bootstrapping an AI agent environment on GCP.  If starting from nothing, then do these things, in order:

1) create a Google Workspace user "robot.tim@DOMAIN"
2) create a Google Workspace security group "gcp-devops@DOMAIN" and add yourself (not robot.tim) to it
3) create a Google Workspace security group "gcp-operators@DOMAIN" and add robot.tim to it
4) create a github SSH key with access to this repo and add that SSH key as a secret in GCP Secret Manager with the name "git-bootstrapping-key" so the VM can bootstrap itself from it
4) run ./install-terraform-prerequisites.sh
5) run ./infra/bootstrap-devops.sh and log in as yourself (not robot.tim) when asked
6) run ./infra/terraform-apply.sh and log in as yourself if asked
7) ssh to the air traffic controller vm with: "tk"

The basic idea is to give the AI agent a VM and a login (robot.tim) that has all the power it needs to get tasks done but does not have any power at all to alter the infrastructure it sits on (which can only be changed by yourself)

The air traffic controller is meant to be a very small, very cheap VM that just runs all the time.  If more powerful stuff needs to get done, then the air traffic controller would spin up a more powerful VM long enough to get it done, and then spin it back down again.  Or would call a Cloud Run based web service, or do something else much more on demand and cheaper.
