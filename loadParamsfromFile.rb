# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yaml")

grp = configs['groups'].sort_by { |k, value| value['order'] }
settings = configs['settings']
vms = Array.new 

grp.each do |e, value|
	#puts e
	value['members'] = Array.new
	if value['active']
		(1..value['vmCount']).each do |machine_id|
			vm = Hash.new
			vm['name'] = "#{value['vmNameBuildTemplate']}#{machine_id}"
			vm['ip'] = "#{settings['network']}#{machine_id+value['networkBaseAddress']}"
			value['members'].push(vm['name'])
			vms.push(vm)
		end
	else
		vms.each do |vm|
			if /#{value['vmNameSearchTemplate']}/.match(vm['name']) != nil
				value['members'].push(vm['name'])
			end
		end
	end
end

puts vms
puts
puts grp

