# Operations

## Repositories
https://github.com/orgs/REMLA24-TEAM-15/repositories

## Prerequisites 
The set up below requires the following things to be installed on the machine:
1. [MiniKube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download)
2. [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
3. [Vagrant](https://developer.hashicorp.com/vagrant/docs/installation)
4. [Istio](https://istio.io/latest/docs/setup/install/)
5. [Helm](https://helm.sh/docs/intro/install/)


## Get started quick
```sh
./local_istio_minikube_deploy.sh
```
This command will deploy the following services in a local cluster using minikube:
- 2 instances of url-app helm chart (testing-one, testing-two)
  - Both instances deploy differnt ML models.
  - The versions of the ML model are shown in the app frontend
  - To directly access the services, append contents of [this file](https://github.com/REMLA24-TEAM-15/Operation/blob/main/etc_hosts.txt) to your /etc/hosts
- Istio service mesh with various endpoints
  - Please follow the instructions to tunnel into the istio services using the instructions given [here](https://github.com/REMLA24-TEAM-15/Operation/blob/main/local_istio_minikube_deploy.sh)
  - `/testing-one`: Routes to `testing-one-url-app-serv:8080`
  - `/testing-two`: Routes to `testing-two-url-app-serv:8080`
  - `/testing-url-app`: Routes to `testing-one-url-app-serv:8080` with 90% weight, and `testing-two-url-app-serv:8080` with 10% weight
  - `/mirroring-url-app`: Routes to `testing-one-url-app-serv:8080` with mirroring to `testing-two-url-app-serv:8080`
- Prometheus & Grafana
  - To directly access the services, append contents of [this file](https://github.com/REMLA24-TEAM-15/Operation/blob/main/etc_hosts.txt) to your /etc/hosts
  - Grafana has two custom dashboards
    - [URL App](http://grafana-urlapp.local/d/_eX4mpl3/url-app-dashboard?orgId=1&refresh=5s)
    - [Istio](http://grafana-urlapp.local/d/G8wLrJIZk/istio-mesh-dashboard?orgId=1&var-datasource=prometheus)
- A python [file](https://github.com/REMLA24-TEAM-15/Operation/blob/main/query_generator.py) is used to generate queries and test various models artificially
  - Remeber to change the IP address in the python file to the correct IP address for Istio.
  - For testing models without routing through istio, ensure /etc/hosts has been updated as mentioned above.

## URL App Helm Chart
A helm chart has been made to deploy the URL app and model deployments. The app of a particular helm chart installation can communicated with the corresponding model deployment only - this is by design.

For experimenting new models (Continous experimentation), the URL to a different ML model (Release.joblib) file can be supplied.

The path to the model can be specified in url.mlModel.url in the values.yaml file. Illustrated in [testing-one](https://github.com/REMLA24-TEAM-15/Operation/blob/main/kubernetes/charts/testing-one-values.yaml) and [testing-two](https://github.com/REMLA24-TEAM-15/Operation/blob/main/kubernetes/charts/testing-two-values.yaml)

## Vagrant & Ansible provisioning
First set a k3s token
```sh
$env:K3S_TOKEN=<your_k3s_token>
```
The Virtual machines can be created and provisioned using the command
```sh
vagrant up
```
One controller and 2 worker nodes are defined. The number of worker nodes can be increased by changing num_workers [here](https://github.com/REMLA24-TEAM-15/Operation/blob/main/Vagrantfile#L28). The nodes connect to each other using K3s with the controller node acting as the K3s server.
The required helm charts, prometheus and grafana are automatically deployed using ansible playbooks
