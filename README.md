# Vagrant and Ansible Setup

To enable Ansible to access Vagrant VMs, an RSA key pair is required. Follow these steps:

1. Run the following command to generate the RSA key pair:

   ```sh
   ssh-keygen
   ```
2. Place the generated keys in the Provisioning/Keys folder. Ensure the following naming conventions:

<ul>
  <li>Public key: vagrant-key.pub</li>
  <li>Private key: vagrant-key.pem</li>
</ul> 
    
# Running the Virtual Machines

1. To start all virtual machines, follow these steps:

    Navigate to the Provisioning directory:

    ```sh
    cd Provisioning
    ```

2. Execute the following command to bring up the virtual machines:

```sh
vagrant up
```

