
## Worker1
export K3S_TOKEN=12345
export K3S_URL=https://192.168.56.10:6443
export INSTALL_K3S_EXEC="--token 12345 --server $K3S_URL"
export K3S_NODE_NAME="worker1"
curl -sfL https://get.k3s.io | sh -



## Worker2
export K3S_TOKEN=12345
export K3S_URL=https://192.168.56.10:6443
export INSTALL_K3S_EXEC="--token 12345 --server $K3S_URL"
export K3S_NODE_NAME="worker2"
curl -sfL https://get.k3s.io | sh -


curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

minikube start