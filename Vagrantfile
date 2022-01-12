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
    main.vm.network :private_network, ip: "192.168.44.10"
    main.vm.provision :shell, privileged: true, inline: $install_main_tools
  end

  (1..3).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.box = "generic/debian10"
      node.vm.network :private_network, ip: "192.168.44.#{10+i}"
      node.vm.provision :shell, privileged: true, inline: $install_node_tools
    end
  end
end

#install haproxy
$install_main_tools = <<-SHELL
apt update
apt install -y gnupg
curl https://haproxy.debian.net/bernat.debian.org.gpg \
| gpg --dearmor > /usr/share/keyrings/haproxy.debian.net.gpg
echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
http://haproxy.debian.net buster-backports-2.5 main \
 > /etc/apt/sources.list.d/haproxy.list
apt update
apt install -y haproxy
SHELL

$install_node_tools = <<-SHELL
apt update
apt install -y apache2
SHELL
