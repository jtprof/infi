# -*- mode: ruby -*-
# vi: set ft=ruby :

#load config file from current folder
require 'yaml'
current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yml")

#sore groups in order
grp = configs['groups'].sort_by { |k, value| value['order'] }
settings = configs['settings']

#Prepare list of all virtual machines
vms = Array.new 

Vagrant.configure("2") do |config|
  #configure vm provider for VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
    vb.linked_clone = true
  end

  #Make changes in vagrant according with the configuration
  grp.each do |e, value|
    #prepare list of virtual machines in the current group
    value['members'] = Array.new
    value['addreses'] = Array.new
    if value['active']
      #if the group marked as active add new virtual machines
      (1..value['vmCount']).each do |machine_id|
        vm = Hash.new
        vm['name'] = "#{value['vmNameBuildTemplate']}#{machine_id}"
        vm['addr'] = "#{settings['network']}#{machine_id+value['networkBaseAddress']}"
        config.vm.define vm['name'] do |machine|
          machine.vm.box =  "centos/7"
          machine.vm.box_check_update = false
          machine.vm.synced_folder ".", "/vagrant", type: "nfs"
          machine.vm.hostname = vm['name']
          machine.vm.network "private_network", ip: vm['addr']
        end
        value['members'].push(vm['name'])
        value['addreses'].push(vm['addr'])
        vms.push(vm)
      end
    else
      #Check if the virtual machine name match with group vm pattern
      vms.each do |vm|
        if /#{value['vmNameSearchTemplate']}/.match(vm['name']) != nil
          #add vm name in group if yes
          value['members'].push(vm['name'])
          value['addreses'].push(vm['addr'])
        end
      end
    end
    if value['addsetting']
      #add new value in settings if it's configured
      settings[value['setingvar']] = value[value['ownvar']].join(',')
    end
  end

  #configure vm provisioning to ansible
  config.vm.provision :ansible do |ansible|
    verbose = "true"
    ansible.playbook = "provisioning/ldap.yml"

    #make groups config
    ansible.groups = Hash.new
    grp.each do |e, value|
      ansible.groups[e] = value['members']
      ansible.groups["#{e}:vars"] = settings
    end
  end
end
