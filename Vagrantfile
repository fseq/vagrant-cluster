# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |v|
    v.memory = 1024
    v.cpus = 1
  end
  
  config.vm.define "master" do |master|
    master.vm.box = "generic/debian10"
    master.vm.hostname = "nodemaster"
    master.vm.network :private_network, ip: "192.168.123.10"
  end

  for i in 1..2
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "generic/debian10"
      node.vm.network :private_network, ip: "192.168.123.#{10+i}"
    end
  end
end


