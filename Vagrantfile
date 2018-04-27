# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
    vb.linked_clone = true
  end

  N = 2
  (1..N).each do |machine_id|
    config.vm.define "ldapsrv#{machine_id}" do |machine|
      machine.vm.box =  "centos/7"
      machine.vm.synced_folder ".", "/vagrant", type: "nfs"
      machine.vm.hostname = "ldapsrv#{machine_id}"
      machine.vm.network "private_network", ip: "192.168.33.#{255-machine_id}"
    end
  end
      
end
