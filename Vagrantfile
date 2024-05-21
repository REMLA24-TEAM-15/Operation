# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  current_dir = File.expand_path(File.dirname(__FILE__))
  num_workers = 2
  controller_ssh_prvkey_path = "#{current_dir}/keys/id_controller"
  worker_ssh_prvkey_path = "#{current_dir}/keys/id_worker"

  controller_ssh_prvkey = File.readlines(controller_ssh_prvkey_path)
#   puts "SSH controller: #{controller_ssh_prvkey}"

  worker_ssh_prvkey = File.read(worker_ssh_prvkey_path)
#   puts "SSH worker: #{worker_ssh_prvkey}"

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
#     controller.ssh.insert_key = false
#     controller.ssh.private_key_path = controller_ssh_prvkey_path
    controller.vm.provision "shell", inline: <<-SHELL
      # Add your public key to authorized_keys
      mkdir -p /home/vagrant/.ssh
      chmod 700 /home/vagrant/.ssh
      echo #{controller_ssh_prvkey} >> /home/vagrant/.ssh/authorized_keys
      chmod 600 /home/vagrant/.ssh/authorized_keys
      chown -R vagrant:vagrant /home/vagrant/.ssh
    SHELL
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
#       worker.ssh.insert_key = false
#       worker.ssh.private_key_path = worker_ssh_prvkey_path

      worker.vm.provision "shell", inline: <<-SHELL
        # Add your public key to authorized_keys
        mkdir -p /home/vagrant/.ssh
        chmod 700 /home/vagrant/.ssh
        cat /vagrant/keys/id_worker.pub >> /home/vagrant/.ssh/authorized_keys
        chmod 600 /home/vagrant/.ssh/authorized_keys
        chown -R vagrant:vagrant /home/vagrant/.ssh
      SHELL
    end
  end

  # SSH setup
  config.ssh.keys_only = true
end
