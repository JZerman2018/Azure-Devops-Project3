## Azure-Devops-Project3: Ensuring Quality Releases

### Project Overview
In this project, I will demonstrate the skills learned about ensuring quality releases in the Udacity DevOps Engineer for Microsoft Azure Nanodegree. Using Microsoft Azure, I will create a VM using Terraform and deploy an app to Azure AppService. I will then test environments and run automated tests. I will also utilize monitoring tools to provide insight into my application's behavior by querying custom log files.

### Dependencies

* Python
* Terraform
* JMeter
* Postman
* Selenium
* Azure DevOps
* Azure CLI

### Project Steps

1. Create a Service Principal for Terraform and replace the below values in the terraform/environments/test/terraform.tfvars files with the output from  the Azure CLI.
    * subscription_id
    * client_id
    * client_secret
    * tenant_id

    Login to Azure:\
`az login`

    Create the password based authentication service principal for your project:\
    `az ad sp create-for-rbac --name SPProject3`\
    Make note of the password because it can't be retrieved, only reset.

2.
