# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Define the controller VM
  config.vm.define "controller" do |controller|
    controller.vm.box = "bento/ubuntu-24.04"
    controller.vm.box_version = "202404.26.0"
    controller.vm.box_check_update = false
    controller.vm.hostname = "controller"
    ip_address_cont = "192.168.56.10"
    controller.vm.network "private_network", ip: ip_address_cont, netmask: "255.255.255.0"
    controller.vm.provider "virtualbox" do |v|
      v.memory = 1024 * 4
      v.cpus = 2
    end
    controller.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/server-setup.yml"
      ansible.extra_vars = {
        k3s_node_name: "controller",
        k3s_external_ip: ip_address_cont,
        k3s_token: ENV['K3S_TOKEN']
      }
    end
  end

  num_workers = 2
  # Define worker VMs
  (1..num_workers).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "bento/ubuntu-24.04"
      worker.vm.box_version = "202404.26.0"
      worker.vm.box_check_update = false
      worker.vm.hostname = "worker#{i}"

      ip_address = "192.168.56.#{100 + i}"
      worker.vm.network "private_network", ip: ip_address, netmask: "255.255.255.0"

      worker.vm.provider "virtualbox" do |v|
        v.memory = 1024 * 6
        v.cpus = 2
      end
      worker.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbooks/worker-setup.yml"
        ansible.extra_vars = {
          k3s_node_name: "worker#{i}",
          k3s_url: "https://192.168.56.10:6443",
          k3s_token: ENV['K3S_TOKEN'],
        }
      end
    end
  end
end
