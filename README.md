# Terraform

Repo for managing Infra. Envisioned to manage any infrastructure, this repo currently manages Kubernetes Cluster deployed in Personal Oracle Compute Engine. 

## Oracle Cloud
Oracle provides free `Compute Engine` along with `200GB Block Storage` which is suitable for hosting personal projects and for learning purposes. The shape of the VM can be customised based on the needs. As per the [Oracle Free Tier](https://www.oracle.com/in/cloud/free/#free-cloud-trial) documentation, Arm-based VMs can have max 4 OCPU's and 24GB memory. Max 4 VM's can be created with these resources. Currently, we have created an Arm-based Compute instance with 2 OCPU count and 12GB memory. 
`Block Storages` are detachable and can be attached to any Compute Instances. Oracle provides 200GB free block storage in total with max of 50GB per block storage. Currently, one Block storage is attached to our Compute Instance. Each compute instance will have 50GB `Boot Volume` as well


### Components of Oracle Cloud
![vpc](/docs/assets/vpc-light.svg#gh-light-mode-only)
![vpc](/docs/assets/vpc-dark.svg#gh-dark-mode-only)

