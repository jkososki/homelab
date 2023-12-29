# Homelab

A kubernetes home lab using KIND.


## Requirements

The following are needed to use this homelab:  

1. [Docker](https://www.docker.com/get-started/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/)
3. [KIND](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
3. [Helm](https://helm.sh/docs/intro/install/)

## Setup

The general setup steps are:

1. Create & trust certificates.
3. Bootstrap the cluster.

### Create & Trust Certificates
   
   Certificates can be setup using the bootstrap/make_certs script.  This script will use [minica](https://github.com/jsha/minica) to create a certificate authority and wildcard certificates for localhost.

   ```bash
   bootstrap/make_certs
   ```

   This will create the following files:  
   - bootstrap/minica-key.pem
   - bootstrap/minica.pem
   - bootstrap/localhost/cert.pem
   - bootstrap/localhost/key.pem

   Add `bootstrap/minica.pem` to your trust store to allow your browser to trust your applications.  


## Bootstrap the Cluster

Bootstrap the cluster by running the `homelab` script.  

Running the `homelab` script will do the following:  
1. Generate SSH Host keys for a git server.
2. Generate SSH Keys for Argo to access the git server.
3. Deploy a Kind Cluster
4. Deploy a git server with the homelab repo.  
   The homelab repo will be mounted from the local disk.  Changes committed locally will be picked up by the Argo deployment.
5. Deploy ArgoCD
6. Deploy the cluster-applications (bootstrap/cluster-apps)

The `cluster-apps` contains deployments that can be found in `/apps`.  To add a new project just create a new folder in the `/apps` directory with the following structurea:  

```plaintext
├── {app-name}                - directory named for the application.
│   ├── chart                 - directory named 'chart' that contains the helm chart
│   │   ├── ...
│   └── deploy.values.yaml    - a deployment yaml file to hold deploy configurations
```

## Accessing the Cluster

You can interact with the cluster using `kubectl`.  
You can access ArgoCD at `https://argocd.localhost:8443`
   The default username is "admin"
   The password can be obtained by running the following:
   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o json | jq -r '.data.password' | base64 -d
   ```

## Troubleshooting

### Routing & Connectivity

   Once the cluster has been initialized you can access the Traefik dashboard at `http://localhost:9000/dashboard/#/`.  
   You can also install the `whoami` project:

   ```bash
   kubectl apply -f utils/whoami/whoami.yaml
   ```

   This will test the certs & ingress.  `https://whoami.homelab.localhost` .

