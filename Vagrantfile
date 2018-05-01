# -*- mode: ruby -*-
# vi: set ft=ruby :

#TODO 20180429
# => 1. Define IP as base from external
# => 2. Fix groups variable duplication
# => 3. Define domain name and fqdn from external
# => 4. define machine name template from external

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yaml")
#vagrant_config = configs['configs'][configs['configs']['use']]


Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
    vb.linked_clone = true
  end

  N = 3
  (1..N).each do |machine_id|
    config.vm.define "ldapsrv#{machine_id}" do |machine|
      machine.vm.box =  "centos/7"
      machine.vm.box_check_update = false
      machine.vm.synced_folder ".", "/vagrant", type: "nfs"
	  ldap_master = "#{allvms_cfg['network']}#{254}"
	  
	  if machine_id == 1 or machine_id == 2
		ldap_servers.insert(0, "#{allvms_cfg['network']}#{255-machine_id}")
		machine.vm.hostname = "ldapsrv#{machine_id}" 
		machine.vm.network "private_network", ip: "#{allvms_cfg['network']}#{255-machine_id}"
	  else
		machine.vm.hostname = "workstation#{machine_id}"
		machine.vm.network "private_network", ip: "#{allvms_cfg['network']}#{101+machine_id}" 
	  end
	  if if machine_id == N machine.vm.provision :ansible do |ansible|
		verbose = "true"
		ansible.limit = "all"
		ansible.playbook = "provisioning/ldap.yml"

		ansible.groups = {
		
	  end
    end
  end

  config.vm.provision :ansible do |ansible|
    verbose = "true"
    ansible.limit = "all"
    ansible.playbook = "provisioning/ldap.yml"

    ansible.groups = {
      "allvms" => ["ldapsrv[1:2]", "workstation[1..10]"],
      "ldapservers" => ["ldapsrv[1..2]"],
      "ldapmasters" => ["ldapsrv1"],
      "ldapslaves" => ["ldapsrv2"],
      "ldapclients" => ["workstation[1..10]"],
      "allvms:vars" => {
                        "dn_Suffix" => "dc=infi-test,dc=local",
                        "ldap_master" => "192.168.33.254",
                        "ldap_slave" => "192.168.33.253",
                        "ldap_service" => "slapd",
                        "ldap_port" => 339,
                        "dn_repluser" => "repluser",
                        "dn_repluserFullName" => "User for ldap replication",
                        "SSHAreplPWD" => "{SSHA}nR+wYuff6LRH2zkn54wvcz0b2VsyOkuC", #UniQue#Passw0rd
                        "SSHARootPWD" => "{SSHA}7P/9Hf7ckkGn87/jaje9CqcCcjRn65wP",#ldp#passw0rd
                        "dn_admin" => "cn=ldapadm,dc=infi-test,dc=local",
                        "dn_dc" => "infi-test",
                        "dn_firstOU" => "FirstOU",
                        "dn_firstGroup" => "Bifurcation",
                        "dn_user" => "flyx",
                        "dn_userFullName" => "Huge unpredictible Fluctuation",
                        "SSHAuserPWD" => "{SSHA}xqAQU/brcjDTr0NuTUS9MhDNEWRa9llI", #Unique#Passw0rd
                        "dn_replretry" => "30 5 300 3",
                        "dn_replinterval" => "00:00:05:00",
                        },
      "ldapservers:vars" => {
                        "dn_Suffix" => "dc=infi-test,dc=local",
                        "ldap_master" => "192.168.33.254",
                        "ldap_slave" => "192.168.33.253",
                        "ldap_service" => "slapd",
                        "ldap_port" => 339,
                        "dn_repluser" => "repluser",
                        "dn_repluserFullName" => "User for ldap replication",
                        "SSHAreplPWD" => "{SSHA}nR+wYuff6LRH2zkn54wvcz0b2VsyOkuC", #UniQue#Passw0rd
                        "SSHARootPWD" => "{SSHA}7P/9Hf7ckkGn87/jaje9CqcCcjRn65wP",#ldp#passw0rd
                        "dn_admin" => "cn=ldapadm,dc=infi-test,dc=local",
                        "dn_dc" => "infi-test",
                        "dn_firstOU" => "FirstOU",
                        "dn_firstGroup" => "Bifurcation",
                        "dn_user" => "flyx",
                        "dn_userFullName" => "Huge unpredictible Fluctuation",
                        "SSHAuserPWD" => "{SSHA}xqAQU/brcjDTr0NuTUS9MhDNEWRa9llI", #Unique#Passw0rd
                        "dn_replretry" => "30 5 300 3",
                        "dn_replinterval" => "00:00:05:00",
                      },
      "ldapmasters:vars" => {
                        "dn_Suffix" => "dc=infi-test,dc=local",
                        "ldap_master" => "192.168.33.254",
                        "ldap_slave" => "192.168.33.253",
                        "ldap_service" => "slapd",
                        "ldap_port" => 339,
                        "dn_repluser" => "repluser",
                        "dn_repluserFullName" => "User for ldap replication",
                        "SSHAreplPWD" => "{SSHA}nR+wYuff6LRH2zkn54wvcz0b2VsyOkuC", #UniQue#Passw0rd
                        "SSHARootPWD" => "{SSHA}7P/9Hf7ckkGn87/jaje9CqcCcjRn65wP",#ldp#passw0rd
                        "dn_admin" => "cn=ldapadm,dc=infi-test,dc=local",
                        "dn_dc" => "infi-test",
                        "dn_firstOU" => "FirstOU",
                        "dn_firstGroup" => "Bifurcation",
                        "dn_user" => "flyx",
                        "dn_userFullName" => "Huge unpredictible Fluctuation",
                        "SSHAuserPWD" => "{SSHA}xqAQU/brcjDTr0NuTUS9MhDNEWRa9llI", #Unique#Passw0rd
                        "dn_replretry" => "30 5 300 3",
                        "dn_replinterval" => "00:00:05:00",
                      },
      "ldapslaves:vars" => {
                        "dn_Suffix" => "dc=infi-test,dc=local",
                        "ldap_master" => "192.168.33.254",
                        "ldap_slave" => "192.168.33.253",
                        "ldap_service" => "slapd",
                        "ldap_port" => 339,
                        "dn_repluser" => "repluser",
                        "dn_repluserFullName" => "User for ldap replication",
                        "SSHAreplPWD" => "{SSHA}nR+wYuff6LRH2zkn54wvcz0b2VsyOkuC", #UniQue#Passw0rd
                        "SSHARootPWD" => "{SSHA}7P/9Hf7ckkGn87/jaje9CqcCcjRn65wP",#ldp#passw0rd
                        "dn_admin" => "cn=ldapadm,dc=infi-test,dc=local",
                        "dn_dc" => "infi-test",
                        "dn_firstOU" => "FirstOU",
                        "dn_firstGroup" => "Bifurcation",
                        "dn_user" => "flyx",
                        "dn_userFullName" => "Huge unpredictible Fluctuation",
                        "SSHAuserPWD" => "{SSHA}xqAQU/brcjDTr0NuTUS9MhDNEWRa9llI", #Unique#Passw0rd
                        "dn_replretry" => "30 5 300 3",
                        "dn_replinterval" => "00:00:05:00",
                      },
    }
  end

end
