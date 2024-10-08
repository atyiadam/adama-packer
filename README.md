### Requirements

- Packer: v1.11.2

### Plugins

From the root directory run:
```
$ packer init .
```

### Validate

```
$ packer validate -var-file templates/ubuntu-live-server-amd64-24_04_1/values.auto.pkrvars.hcl templates/ubuntu-live-server-amd64-24_04_1/.
```

### Build

From the root directory run:
```
$ packer build -var-file templates/<template_folder>/values.auto.pkrvars.hcl templates/<template_folder>/
``
