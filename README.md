# VM-Configuration
Ansible playbook for configuration of a brand new Linux virtual machine, including custom bash prompt and useful shortcuts and vim configurations

To use it, install Ansible first with

```pip install ansible```

Get your new useless machine's public ssh key using

```ssh-copy-id root@machine.foo```

Add a "vms" group to your inventory at
```/etc/ansible/hosts```
And containing your new machines

```
[vms]
foo.bar
192.168.128.50
```

Then finally, run ```sync.sh```, which will run the Ansible Playbook idempotently
