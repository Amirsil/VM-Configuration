# VM-Configuration
Ansible playbook for configuration of a brand new Linux virtual machine, including custom bash prompt and useful shortcuts and vim configurations

To use it, install Ansible first with
```pip install ansible```

Get your new useless machine's public ssh key using

```ssh-copy-id root@machine.foo```

Run the playbook on the target hosts by running:

```ansible-playbook configure.yaml --extra-vars "hosts=<hosts/groups>"```

Then finally, run ```sync.sh```, which will run the Ansible Playbook idempotently
