# RPM package development playground

RRM package development playground for `my-world` package.

See:

- https://rpm-packaging-guide.github.io/

## Usage

Prerequisites: vagrant, virtualbox, make

Use `make` to run common project tasks. Monitor `logs/` directory for new logs after running `make build`.

- `make up` - create and start vm with vagrant
- `make build` - build rpm inside vm placing logs in `logs/`
- `make down` - remove vm
- `make clean` - remove logs/\* files

**Full lifecycle in a single command:**

```bash
% make clean up build down && ls -l logs

Removing all files in logs/ directory
Bringing vagrant vm up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'generic/centos8'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'generic/centos8' version '4.2.16' is up to date...
==> default: Setting the name of the VM: rpmdev@centos8
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
...
Running make all command inside vm
:: Initializing rpmdev working directories
:: Uninstalling rpm package
:: Building rpm package for my-world
:: Installing rpm package with strace rpm -i
:: Filtering strace events /home/vagrant/logs/1685095113.rpmi-strace
:: Uninstalling rpm package
:: Installing rpm package with rpm -i --debug
:: Uninstalling rpm package
Destroyin vagrant vm
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
-rw-r--r--@  1   1498 May 26 11:58 1685095113.rpm-build-stderr
-rw-r--r--@  1    825 May 26 11:58 1685095113.rpm-build-stdout
-rw-r--r--@  1   7604 May 26 11:58 1685095113.rpmi-debug-stderr
-rw-r--r--@  1    167 May 26 11:58 1685095113.rpmi-debug-stdout
-rw-r--r--@  1      0 May 26 11:58 1685095113.rpmi-stderr
-rw-r--r--@  1    103 May 26 11:58 1685095113.rpmi-stdout
-rw-------@  1  30749 May 26 11:58 1685095113.rpmi-strace
```
