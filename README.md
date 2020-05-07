# New App 2

## Installation:

### Prerequisites:

- Terraform
- Ansible

Clone this repository
Save your credentials.json file inside this repo, on root folder.

Edit terraform.tfvars acoording your project

### Deploy:

sh deploy.sh

### After steps:

Navigate to <Public IP>:8080 of Jenkins Instance **(terraform output public_ip)**

Create Kubeconfig credentials following this guide https://plugins.jenkins.io/kubernetes-cd/

Create new Pipeline using the repo https://github.com/carlosrv999/java-sample.git.

Execute Build of Pipeline.
