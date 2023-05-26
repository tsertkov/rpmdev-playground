# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos8"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "rpmdev@centos8"
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.synced_folder "my-package/", "/home/vagrant/my-package"
  config.vm.synced_folder "logs/", "/home/vagrant/logs"

  config.vm.provision "shell", inline: <<-SHELL
    dnf -y update
    dnf install -y gcc rpm-build rpm-devel \
      rpmlint make bash coreutils diffutils patch rpmdevtools \
      strace
  SHELL
end
