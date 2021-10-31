#!/bin/sh

git pull origin main
ansible-playbook configure.yaml
