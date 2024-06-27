echo "Deleting any existing Minikube cluster"
minikube delete

echo "Starting a new Minikube cluster with 8192MB memory, 4 CPUs, using Docker as the driver"
minikube start --memory=8192 --cpus=4 --driver=docker

echo "Enabling the Ingress addon in Minikube"
minikube addons enable ingress

echo "Enabling the Metrics Server addon in Minikube"
minikube addons enable metrics-server

echo "Running Istio setup commands from istio_commands.sh script"
/bin/bash ./kubernetes/charts/istio_commands.sh

echo "Adding the Prometheus Helm repository"
helm repo add prom-repo https://prometheus-community.github.io/helm-charts

echo "Adding the Kubernetes Dashboard Helm repository"
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

echo "Updating Helm repositories"
helm repo update

echo "Waiting for 10 seconds to ensure required pods are deployed"
sleep 10

echo "Installing the Prometheus stack with custom values in the 'prometheus' namespace"
kubectl create namespace prometheus
helm install -f kubernetes/charts/urlapp-kube-prom-stack-values.yaml prometheus prom-repo/kube-prometheus-stack -n prometheus

echo "Installing the Kubernetes Dashboard in the 'kubernetes-dashboard' namespace"
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

echo "Installing the 'testing-one' Helm chart with custom values"
helm install -f kubernetes/charts/testing-one-values.yaml testing-one kubernetes/charts/url_model

echo "Installing the 'testing-two' Helm chart with custom values"
helm install -f kubernetes/charts/testing-two-values.yaml testing-two kubernetes/charts/url_model

echo "Applying Grafana dashboard configuration from grafana_dashboard.yaml"
kubectl apply -f kubernetes/charts/grafana_dashboard.yaml
kubectl apply -f kubernetes/charts/istio_grafana.yaml


echo "Applying Istio setup configuration from istio_setup.yaml"
kubectl apply -f kubernetes/charts/istio_setup.yaml

echo "To access services on Istio, Run: "
echo "minikube tunnel"

echo "To get the IP on which the Istio services are running, Run: "
echo "kubectl get svc istio-ingressgateway -n istio-system"

echo "See ReadMe for the endpoints available for Istio"