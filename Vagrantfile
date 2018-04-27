# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #config.vm.box = "centos/7"
  #config.vm.synced_folder ".", "/vagrant", type: "nfs"
  #config.vm.box_check_update = false

  #config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  #config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
    vb.linked_clone = true
  end

  config.vm.define "ldapsrv01" do |ldapsrv01|
    ldapsrv01.vm.box =  "centos/7"
    ldapsrv01.vm.synced_folder ".", "/vagrant", type: "nfs"
    #ldapsrv01.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    ldapsrv01.vm.network "private_network", ip: "192.168.33.254"
  end
  
  config.vm.define "ldapsrv02" do |ldapsrv02|
    ldapsrv02.vm.box =  "centos/7"
    ldapsrv02.vm.synced_folder ".", "/vagrant", type: "nfs"
    #ldapsrv02.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    ldapsrv02.vm.network "private_network", ip: "192.168.33.253"
  end
  
#  config.vm.provision "shell", inline: <<-SHELL
#     yum upgrade -y
#     yum install mc -y
#     #apt-get install -y apache2
#  SHELL
end
