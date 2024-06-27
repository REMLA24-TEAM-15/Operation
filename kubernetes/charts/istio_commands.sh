export PATH=/home/shantnav/Downloads/istio-1.22.0/bin:$PATH
istioctl install -y
# kubectl apply -f ~/Downloads/istio-1.22.0/samples/addons/prometheus.yaml
# kubectl apply -f ~/Downloads/istio-1.22.0/samples/addons/jaeger.yaml
# kubectl apply -f ~/Downloads/istio-1.22.0/samples/addons/kiali.yaml

kubectl label ns default istio-injection=enabled

# istioctl dashboard kiali

