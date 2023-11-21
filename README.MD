# Conventions
### What is a project ? 
```text
a project is a repo of code, a project is a one to one with repo 
```

### types of projects ? 
```text
projects can be packages which used into other project, application level project which building and managing binaries because an application project doesn't have to manage one binary
```

### about go.mod ? 
```text
your project cannot maintain more than one go.mod file in the entire project, even if you have folders that contains another go.mod in addition to the root one, this will cause a lot of errors
```

### about golang environment .. 
- if we run `go env` we will got a lot of paths :- <br>
    - we can find the source code of all the dependencies we installed before on this path 
    ```cmd
    GOMODCACHE=C:\Users\gamil\go\pkg\mod
    ```

    - when we run `go mod tidy` to download the dependencies we need, this is gonna happen: 


# branch | working-with-kind

## lets explore the kind-config.yaml file : 
```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/vlalpha4
``` 
➜ Explanation <br>
```text
kind: This is a YAML keyword that is used to specify the type of object that you are creating. In this case, you are creating a Kind cluster.

Cluster: This is the name of the type of object that you are creating. In this case, you are creating a Cluster.

apiVersion: This is a YAML keyword that is used to specify the version of the API that you are using. In this case, you are using the v1alpha4 API.

kind.x-k8s.io/vlalpha4: This is the full name of the API that you are using. The kind.x-k8s.io part of the name is the vendor prefix for Kind, and the vlalpha4 part of the name is the API version.
```

now if i updated the Makefile and start using kind by running the following commands i will got the following results : 
```sh
➜ go-k8s git:(working-with-kind) ✗ make kind-up
kind create cluster --image kindest/node:v1.21.1@sha256:69860bda5563ac81e3c0057d654b5253219618a22ec3a346306239bba8cfa1a6 --name fg-starter-cluster --config infra/k8s/kind/kind-config.yaml
Creating cluster "fg-starter-cluster" ...
 ✓ Ensuring node image (kindest/node:v1.21.1) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-fg-starter-cluster"
You can now use your cluster with:

kubectl cluster-info --context kind-fg-starter-cluster

Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/
➜ go-k8s git:(working-with-kind) make kind-status
kubectl get nodes -o wide
NAME                               STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION                      CONTAINER-RUNTIME
fg-starter-cluster-control-plane   Ready    control-plane,master   2m19s   v1.21.1   172.18.0.2    <none>        Ubuntu 21.04   5.10.16.3-microsoft-standard-WSL2   containerd://1.5.2
kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE    SELECTOR
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   2m7s   <none>
➜ go-k8s git:(working-with-kind)
```