# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |v|
    v.memory = 1024
    v.cpus = 1
  end
  
  config.vm.define "main" do |main|
    main.vm.box = "generic/debian10"
    main.vm.hostname = "nodemain"
    main.vm.network "forwarded_port", guest: 80, host: 3000
    main.vm.network "forwarded_port", guest: 8404, host: 8404
    main.vm.network :private_network, ip: "192.168.122.10"
    config.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "playbooks/loadbalancer.yml"
    end
  end

  (1..2).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.box = "generic/debian10"
      node.vm.network :private_network, ip: "192.168.122.#{10+i}"
      config.vm.provision "ansible" do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "playbooks/servernode.yml"
      end
    end
  end
end
