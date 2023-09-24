## Scenario 1

**Requirements:**
Deploy a pod that requires a gpu of RTX_A6000 or H100_NVLINK_80GB.
Prefer a node that has two RTX_A6000 as the first choice.
Prefer a node with an H100_NVLINK_80GB as second choice.

**Environment**
All nodes are available.


```bash
# Deploy 001.yaml

kubectl apply -f ./001.yaml
kubectl get pods -o wide
```

Pod should be scheduled successfully.

```bash
# Cleanup

kubectl delete -f ./001.yaml
```


## Scenario 2

**Requirements:**
Deploy a pod that requires a gpu of RTX_A6000 or H100_NVLINK_80GB.
Prefer a node that has two RTX_A6000 as the first choice.
Prefer a node with an H100_NVLINK_80GB as second choice.

**Environment**
The RTX_A6000 node is unavailable.


```bash

node_name=$(kubectl get nodes --selector gpu.nvidia.com/class="RTX_A6000" --no-headers -o custom-columns=":metadata.name")
kubectl taint nodes $node_name ready=false:NoSchedule --overwrite

```

Pod will be scheduled on the H100_NVLINK_80GB node.

```bash
# Cleanup
kubectl delete -f ./001.yaml
kubectl taint nodes $node_name ready=false:NoSchedule- --overwrite
```