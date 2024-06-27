# Operations

## Repositories
https://github.com/orgs/REMLA24-TEAM-15/repositories

## Get started quick
```sh
./local_istio_minikube_deploy.sh
```
This command will deploy the following services in a local cluster using minikube:
- 2 instances of url-app helm chart (testing-one, testing-two)
  - Both instances deploy differnt ML models.
  - The versions of the ML model are shown in the app frontend
  - To directly access the services, append contents of [this file]() to your /etc/hosts
- Istio service mesh with various endpoints
  - Please follow the instructions to tunnel into the istio services using the instructions given [here](https://github.com/REMLA24-TEAM-15/Operation/blob/main/local_istio_minikube_deploy.sh)
  - `/testing-one`: Routes to `testing-one-url-app-serv:8080`
  - `/testing-two`: Routes to `testing-two-url-app-serv:8080`
  - `/testing-url-app`: Routes to `testing-one-url-app-serv:8080` with 90% weight, and `testing-two-url-app-serv:8080` with 10% weight
  - `/mirroring-url-app`: Routes to `testing-one-url-app-serv:8080` with mirroring to `testing-two-url-app-serv:8080`
- Prometheus & Grafana
  - To directly access the services, append contents of [this file]() to your /etc/hosts
  - Grafana has two custom dashboards
    - [URL App]()



## URL App Helm Chart
A helm chart has been made to deploy the URL app and model deployments. The app of a particular helm chart installation can communicated with the corresponding model deployment only - this is by design.

For experimenting new models (Continous experimentation), the URL to a different ML model (Release.joblib) file can be supplied.

The path to the model can be specified in url.mlModel.url in the values.yaml file. Illustrated in [testing-one](https://github.com/REMLA24-TEAM-15/Operation/blob/main/kubernetes/charts/testing-one-values.yaml) and [testing-two](https://github.com/REMLA24-TEAM-15/Operation/blob/main/kubernetes/charts/testing-two-values.yaml)

## Vagrant & Ansible provisioning
The Virtual machines can be created and provisioned using the command
```sh
vagrant up
```
One controller and 2 worker nodes are defined. The number of worker nodes can be increased by changing num_workers [here](https://github.com/REMLA24-TEAM-15/Operation/blob/main/Vagrantfile#L28). The nodes connect to each other using K3s with the controller node acting as the K3s server.
The required helm charts, prometheus and grafana are automatically deployed using ansible playbooks

## Monitoring
