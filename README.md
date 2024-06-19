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


#### Kubernetes

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
    


*Note: Cluster setup has been done by following the Official documentation of kubernetes*


![compute-instance](/docs/assets//compute-instance-light.svg#gh-light-mode-only)

![compute-instance](/docs/assets//compute-instance-dark.svg#gh-dark-mode-only)