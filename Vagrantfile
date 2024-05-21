# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Define the controller VM
  config.vm.define "controller" do |controller|
    controller.vm.box = "bento/ubuntu-24.04"
    controller.vm.box_version = "202404.26.0"
    controller.vm.box_check_update = false

    controller.vm.network "private_network", ip: "192.168.56.0"
    controller.vm.network "forwarded_port", guest: 22, host: 2222, disabled: true

    controller.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 1
    end

    controller.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/k8s-setup.yml"
      ansible.inventory_path = "ansible/inventory.cfg"
      ansible.compatibility_mode = "2.0"
      ansible.groups = {
        "controller" => ["controller"]
      }
    end
  end

  # Define worker VMs
  (1..num_workers).each do |i|
    config.vm.define "node#{i}" do |worker|
      worker.vm.box = "bento/ubuntu-24.04"
      worker.vm.box_version = "202404.26.0"
      worker.vm.box_check_update = false

      worker.vm.network "private_network", ip: "192.168.56.#{i}"
      worker.vm.network "forwarded_port", guest: 22, host: (2200 + i), disabled: true

      worker.vm.provider "virtualbox" do |v|
        v.memory = 6144
        v.cpus = 2
      end

      worker.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbooks/k8s-setup.yml"
        ansible.inventory_path = "ansible/inventory.cfg"
        ansible.compatibility_mode = "2.0"
        ansible.groups = {
          "worker" => ["worker#{i}"]
        }
      end
    end
  end
end
