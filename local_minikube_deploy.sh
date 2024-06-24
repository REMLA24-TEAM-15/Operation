minikube start
minikube addons enable ingress
minikube addons enable metrics-server

helm repo add prom-repo https://prometheus-community.github.io/helm-charts
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update

helm install -f kubernetes/charts/urlapp-kube-prom-stack-values.yaml prometheus prom-repo/kube-prometheus-stack
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
helm install testing-one kubernetes/charts/url_model