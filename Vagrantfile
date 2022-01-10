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
    master.vm.network :private_network, ip: "192.168.44.10"
    master.vm.provision :shell, privileged: true, inline: $install_master_tools
  end

  for i in 1..2
    config.vm.define "node-#{i}" do |node|
      node.vm.box = "generic/debian10"
      node.vm.network :private_network, ip: "192.168.44.#{10+i}"
      #node.vm.provision "shell", path: "provision-node.sh", args: [ i.to_s ]
    end
  end
end

#install haproxy
$install_master_tools = <<-SHELL
apt update
apt-get install -y gnupg
curl https://haproxy.debian.net/bernat.debian.org.gpg \
| gpg --dearmor > /usr/share/keyrings/haproxy.debian.net.gpg
echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
http://haproxy.debian.net buster-backports-2.5 main \
 > /etc/apt/sources.list.d/haproxy.list
apt update
apt install -y haproxy
SHELL
