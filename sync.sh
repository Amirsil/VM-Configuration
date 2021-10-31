#!/bin/sh

# Apply all new changes to relevent machines in the inventory using GitOps.
git pull origin main
ansible-playbook configure.yaml
