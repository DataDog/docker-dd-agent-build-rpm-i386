# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "opscode_centos-5.11-i386_chef-provisionerless"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/vmware/opscode_centos-5.11-i386_chef-provisionerless.box"
  config.vm.provision "shell",
    inline: "chmod +x /vagrant/make-docker-image.sh && sudo /vagrant/make-docker-image.sh"
end
