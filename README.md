# Terraform

Repo for managing Infra. Envisioned to manage any infrastructure, this repo currently manages Kubernetes Cluster deployed in Personal Oracle Compute Engine. 

## Oracle Cloud
Oracle provides free `Compute Engine` along with `200GB Block Storage` which is suitable for hosting personal projects and for learning purposes. The shape of the VM can be customised based on the needs. As per the [Oracle Free Tier](https://www.oracle.com/in/cloud/free/#free-cloud-trial) documentation, Arm-based VMs can have max 4 OCPU's and 24GB memory. Max 4 VM's can be created with these resources. Currently, we have created an Arm-based ubuntu Compute instance with 2 OCPU count and 12GB memory. 
`Block Storages` are detachable and can be attached to any Compute Instances. Oracle provides 200GB free block storage in total with max of 50GB per block storage. Currently, one Block storage is attached to our Compute Instance. Each compute instance will have 50GB `Boot Volume` as well. 


### Virtual Cloud Network
<br/>
 
![vpc](/docs/assets/vpc-light.svg#gh-light-mode-only)
![vpc](/docs/assets/vpc-dark.svg#gh-dark-mode-only)

Above diagram illustrates the inbound traffic flow. i.e from external network to the compute instance via a public subnet. 

### Compute Instance 

An ephemeral public IP address is assigned to the compute instance which is `144.24.128.160`

A full-fledged kubernetes cluster has been setup using `kubeadm`. This is the only componenet present in the VM. All deployments are done in kubernetes. 


### Kubernetes

Steps involved in kubernetes cluster setup : 
- Install `kubeadm`
    - kubeadm is a tool to create and manage Kubernetes clusters. It performs the actions necessary to get a minimum viable, secure cluster up and running 
    - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
- Install `containerd`
    - In order for the pods to run, we need a container runtime that conforms with CRI (container runtime interface). 
    - We chose containerd since it is light weight and doesn't add complexity of installing docker runtime. 
    - https://github.com/containerd/containerd/blob/main/docs/getting-started.md
- Install `kubectl`
    - kubectl is a tool that allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs.
- Install `calico` network plugin
    - In order for the PODs to communicate with each other, kubernetes needs a network interface that complies with Container Network Interface(CNI). Out of many plugins, have chose calico since it is easier to install.

#### Cluster

Once k8s cluster is setup, we need to configure it to communicate with outside world and manage deployments. 

- Install `helm`
    - Helm is a package manager for kubernetes. It allows to bundle all k8 resources of an application into a single chart so that deployment would be easier. 
- Install `terraform`
    - Terraform is a tool that allows to manage the infrastructure as a code. It can be used to manage any infra like aws, oracle, k8s using terraform providers
    - Terraform stores the state of the resources in a place. When we run terraform plan and if there is a diff between the current state and the code, it would give us the details of the diff in resources. (addition, deletion or updation of resources)
    - Terraform server itself doesn't store the state. We need to configure a storage so that terraform stores in it. AWS s3 can be used to store. Terraform cloud also provides a way to store the state. We have used Terraform cloud since it provides a free plan. 
- Install `atlantis`
    - Atlantis is a terraform Pull Request automation. It allows to run terraform commands right from github. 
    - Command output would be posted as comments in the PR itself. 
    - Follow the official documentation of atlantis and install the server in the VM and configure it to communicate with terraform server. 
    - Configure github actions to provide permission for atlantis to read or write comments within a PR

### Terraform helm provider

- Configure terraform cloud workspace so that it uses terraform cloud to store and sync the state
- Install helm provider (hashicorp/helm)
- Helm provider needs k8s cluster credentials to connect to it. Credentials are passed to the provider via terraform secret added in terraform cloud. 
- Post this, just add modules with necessary resources to deploy applications to the cluster. 

### Ingress

- Have chose `traefik` as ingress for the cluster to communicate with outside world.
- Configured traefik to listen to host network at ports 80 and 443
- To add a domain, have used `ngrok` tunnel within the host machine that listens to port 80 and 443.
- Free Domain name allocated is `https://gently-concise-dogfish.ngrok-free.app`. All traffic to this domain will go via ngrok cloud and reach port 443 which will then be forwarded to traefik and then to the respective cluster service reaching the PODs

![Traefik](/docs/assets/traefik-light.svg#gh-light-mode-only)
![Traefik](/docs/assets/traefik-dark.svg#gh-dark-mode-only)


*Note: Cluster setup has been done by following the Official documentation of kubernetes*


![compute-instance](/docs/assets/compute-instance-light.svg#gh-light-mode-only)

![compute-instance](/docs/assets/compute-instance-dark.svg#gh-dark-mode-only)