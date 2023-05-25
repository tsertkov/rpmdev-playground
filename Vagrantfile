# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos8"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "rpmdev@centos8"
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.synced_folder "my-world/", "/home/vagrant/my-world"
  config.vm.synced_folder "logs/", "/home/vagrant/logs"

  config.vm.provision "shell", inline: <<-SHELL
    yum -y update
    yum install -y gcc rpm-build rpm-devel \
      rpmlint make bash coreutils diffutils patch rpmdevtools \
      strace
  SHELL
end
