minikube delete

minikube start --memory=8192 --cpus=4 --driver=docker
minikube addons enable ingress
minikube addons enable metrics-server

/bin/bash ./kubernetes/charts/istio_commands.sh

helm repo add prom-repo https://prometheus-community.github.io/helm-charts
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update

sleep 10

helm install -f kubernetes/charts/urlapp-kube-prom-stack-values.yaml prometheus prom-repo/kube-prometheus-stack
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
helm install -f kubernetes/charts/testing-one-values.yaml testing-one kubernetes/charts/url_model

helm install -f kubernetes/charts/testing-two-values.yaml testing-two kubernetes/charts/url_model


kubectl apply -f kubernetes/charts/grafana_dashboard.yaml
kubectl apply -f kubernetes/charts/istio_setup.yaml
