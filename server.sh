export K3S_NODE_NAME="controller"
export K3S_EXTERNAL_IP=192.168.56.10
export INSTALL_K3S_EXEC="--token 12345 --write-kubeconfig ~/.kube/config --write-kubeconfig-mode 666 --tls-san $K3S_EXTERNAL_IP --kube-apiserver-arg service-node-port-range=1-65000 --kube-apiserver-arg advertise-address=$K3S_EXTERNAL_IP --kube-apiserver-arg external-hostname=$K3S_EXTERNAL_IP"
curl -sfL https://get.k3s.io |  sh -

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

helm repo add prom-repo https://prometheus-community.github.io/helm-charts
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update

helm install -f /vagrant/kubernetes/charts/urlapp-kube-prom-stack-values.yaml prometheus prom-repo/kube-prometheus-stack
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
helm install testing-one /vagrant/kubernetes/charts/url_model

minikube service controllerprom-kube-promet-prometheus --url

10.0.2.15 grafana-urlapp.local
10.0.2.15 prometheus-urlapp.local
10.0.2.15 testing-one-urlapp.local