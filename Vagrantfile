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
    ip_address_cont = "192.168.56.10"
    controller.vm.network "private_network", ip: ip_address_cont, netmask: "255.255.255.0"
    controller.vm.provider "virtualbox" do |v|
      v.memory = 1024 * 4
      v.cpus = 1
    end

    controller.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/k8s-setup.yml"
      ansible.compatibility_mode = "2.0"
      ansible.groups = {
        "controller_group" => ["controller"]
      }
      ansible.extra_vars = {
            cont_ip: ip_address_cont,
            node_name: "controller"
        }
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

      ip_address = "192.168.56.#{100+i}"
      worker.vm.network "private_network", ip: ip_address, netmask: "255.255.255.0"

      worker.vm.provider "virtualbox" do |v|
        v.memory = 1024 * 6
        v.cpus = 2
      end

#       File.write(inventory_filename, "worker#{i} vagrant@#{ip_address}\n", mode: "a+")
      worker.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbooks/k8s-setup.yml"
#         ansible.inventory_path = "ansible/inventory.cfg"
        ansible.compatibility_mode = "2.0"
        ansible.groups = {
          "worker_group" => ["worker#{i}"]
        }
        ansible.extra_vars = {
            cont_ip: "192.168.56.10",
            node_name: "worker#{i}"
        }
      end
    end
  end
end
