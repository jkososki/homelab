# Homelab

A kubernetes home lab using KIND.


## Requirements

The following are needed to use this homelab:  

1. [Docker](https://www.docker.com/get-started/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/)
3. [KIND](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
3. [Helm](https://helm.sh/docs/intro/install/)

## Setup

### Create Certificates
   
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

### Update the Hosts File [ OPTIONAL ]

If you would like to add additional domains, update the host file to include them.

Example:

```plaintext
127.0.0.1   whoami.localhost
```

### Create Kind Cluster

   Run the `homelab` script to create a new cluster.  This script bootstrap the cluster.  The cluster will contain the following:  

   - Traefik
   - ...

#### Test the Cluster

   Once the cluster has been initialized you can access the Traefik dashboard at `http://localhost:9000/dashboard/#/`.  
   You can also install the `whoami` project:

   ```bash
   kubectl apply -f utils/whoami/whoami.yaml
   ```

   This will test the certs & ingress.  `https://whoami.homelab.localhost` .

