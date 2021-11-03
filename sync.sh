#!/bin/sh

### Apply all new changes to relevent machines in the inventory using GitOps.

# If git repo is up to date, and the hosts configutation file
# for ansible hasn't changed, nothing happens in order to achieve idempotency 
if [[ $(git stash; git pull origin main 2>/dev/null) == *"up-to-date"* ]] && \
   [[ -z $(diff /etc/ansible/hosts .hosts 2>&1) ]]; then
	echo Already Synced
else	
	ansible-playbook configure.yaml
	cp /etc/ansible/hosts .hosts
fi
