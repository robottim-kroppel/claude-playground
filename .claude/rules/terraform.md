# terraform.md

Default to taking a declarative approach, without too many modules or layers of abstraction.

## Terminology

For clarity, assume the following more precise meanings for the following words whenever they are capitalized, instead of assuming their more general, coloquiial meaning.  When they are not capitalized, take a looser interpretation, but still biased in the direction of these definitions.

- `VPC` - the project wide VPC

## General technical approach

Make any value that is used more than twice a variable, with a default to the value that I asked for.

## Security

Store all secrets in GCP Secret Manager.  Unless explicitly instructed otherwise, configure all resources to me unroutable from the public internet.  In cases where I do ask for public routability, make that happen through a load balancer whenever feasible, except for SSH to VMs.  Unless explicitly instructed otherwise, put all resources into the same VPC and same subnet, which should be the "project wide VPC" and "project wide subnet" I created in terraform, not the default VPC and subnet.
