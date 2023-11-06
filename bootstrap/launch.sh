#!/bin/bash -e

show_usage() {
  echo "Usage: $(basename $0) [-d domain] [--help]"
  echo "  -d, --domain    The base domain to use for the cluster."
  echo "  --help          Display this help message"
  exit 1
}

OPTIONS=$(getopt -o d:hc: --long domain:,help,cluster-name: -- "$@")

if [ $? -ne 0 ]; then
  show_usage  
fi

if [ $# -eq 0 ]; then
  echo "Invalid number of arguments."
  show_usage
fi

eval set -- "$OPTIONS"

while true; do
  case "$1" in
    -n|--cluster-name)
      CLUSTER_NAME="$2"
      shift 2
      if [ -z "$CLUSTER_NAME" ]; then
        echo "Error: The --name option requires a value."
        show_usage
      fi
      ;;
    -d|--domain)
      DOMAIN="$2"
      shift 2
      if [ -z "$DOMAIN" ]; then
        echo "Error: The --domain option requires a value."
        show_usage
      fi
      ;;
    --help)
      show_usage
      ;;
    --)
      shift
      if [ -z "$CLUSTER_NAME" ]; then
        CLUSTER_NAME="homelab"
      fi
      break
      ;;
    *)
      echo "Unknown option: $1"
      ;;
  esac
done

echo "Creating cluster $CLUSTER_NAME with domain $DOMAIN"
kind create cluster \
  -n $CLUSTER_NAME \
  --config kind-config.yaml

helm install argo-cd ../charts/argo-cd \
   -n argo-cd \
   --create-namespace \
   --values=argo-cd.values.yaml

# helm install traefik charts/traefik \
#     -n traefik \
#     --create-namespace \
#     --values=traefik.values.yaml

# helm install cert-manager ../charts/cert-manager \
#     -n cert-manager \
#     --create-namespace \
#     --values=cert-manager.values.yaml