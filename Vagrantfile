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

  N = 1
  (1..N).each do |machine_id|
    config.vm.define "ldapsrv#{machine_id}" do |machine|
      machine.vm.box =  "centos/7"
      machine.vm.box_check_update = false
      #machine.ssh.username = "root"
      #machine.ssh.password = "vagrant"
      #machine.ssh.insert_key = "true"
      machine.vm.synced_folder ".", "/vagrant", type: "nfs"
      machine.vm.hostname = "ldapsrv#{machine_id}"
      machine.vm.network "private_network", ip: "192.168.33.#{255-machine_id}"
    end
  end


  config.vm.provision :ansible do |ansible|
    verbose = "true"
    ansible.limit = "all"
    ansible.playbook = "provisioning/ldap.yml"

    ansible.groups = {
      "allvms" => ["ldapsrv[1:2]", "workstation[1..10]"],
      "ldapservers" => ["ldapsrv1"],
      "ldapclients" => ["mworkstation[1..10]"],
      "group1:vars" => {"ldap_service" => "slapd",
                        "ldap_port" => 339}
    }
  end

end
