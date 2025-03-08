### Requirements

- Packer: v1.11.2

### Plugins

From the root directory run:
```
$ packer init .
```

### Validate

```
$ packer validate -var node=<PROXMOX_NODE_NAME> -var vm_id=<VM_ID> -var-file templates/<TEMPLATE>/values.auto.pkrvars.hcl templates/<TEMPLATE>/.
```

### Build

From the root directory run:
```
$ packer build -var node=<PROXMOX_NODE_NAME> -var vm_id=<VM_ID> -var-file templates/<TEMPLATE>/values.auto.pkrvars.hcl templates/<TEMPLATE>/.
```
