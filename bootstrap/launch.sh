kind create cluster --config kind-config.yaml

helm install traefik ../charts/traefik \
    -n traefik \
    --create-namespace \
    --values=traefik.values.yaml

# helm install cert-manager ../charts/cert-manager \
#     -n cert-manager \
#     --create-namespace \
#     --values=cert-manager.values.yaml

helm install argo-cd ../charts/argo-cd \
    -n argo-cd \
    --create-namespace \
    --values=argo-cd.values.yaml