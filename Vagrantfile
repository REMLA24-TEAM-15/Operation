# -*- mode: ruby -*-
# vi: set ft=ruby :

# inventory_filename = "ansible/inventory.cfg"
# File.write(inventory_filename, "", mode: "w")
Vagrant.configure("2") do |config|

  # Define the controller VM
#   File.write(inventory_filename, "[controller]\n", mode: "a+")
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
  end

  num_workers = 2
#   File.write(inventory_filename, "[worker]\n", mode: "a+")
  # Define worker VMs
  (1..num_workers).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "bento/ubuntu-24.04"
      worker.vm.box_version = "202404.26.0"
      worker.vm.box_check_update = false
      worker.vm.hostname = "worker#{i}"

      ip_address = "192.168.56.#{100+i}"
      worker.vm.network "private_network", ip: ip_address, netmask: "255.255.255.0"

      worker.vm.provider "virtualbox" do |v|
        v.memory = 1024 * 6
        v.cpus = 2
      end
    end
  end
end
