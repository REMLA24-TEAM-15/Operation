# Vagrant and Ansible Setup

## Todo:
The repository contains a README.md , which provides a concise documentation that includes... – An explanation on how to start the application (e.g., parameters, variables, requirements).
– Pointers to relevant files that help outsiders understand the code base.
– A list of all relevant repositories for the project.
– Add a new paragraph for each assignment as a continuous progress log that (briefly) describes which assign-
ment parts have been implemented to support the peer-review process.

## How to run

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

