# Azure-Devops-Project3: Ensuring Quality Releases

## Project Overview

In this project, I will demonstrate the skills learned about ensuring quality releases in the Udacity Nanodegree: DevOps Engineer for Microsoft Azure. Using Microsoft Azure, I will create a VM using Terraform and deploy an app to Azure AppService. I will then test environments and run automated tests. I will also utilize monitoring tools to provide insight into my application's behavior by querying custom log files.

### Dependencies

* Python
* Terraform
* JMeter
* Postman
* Selenium
* Azure DevOps
* Azure CLI

### Project Steps

#### Installation & Configuration

Configure the storage account and state backend. Replace the values below in terraform/environments/test/main.tf files with the output from the Azure CLI:

    * storage_account_name
    * container_name
    * access_key

Create a Service Principal for Terraform and replace the below values in the terraform/environments/test/terraform.tfvars files with the output from  the Azure CLI.

    * subscription_id
    * client_id
    * client_secret
    * tenant_id

Login to Azure:<br>
**`az login`**

Create the password based authentication service principal for your project: <br>
    **`az ad sp create-for-rbac --name SPProject3`**<br>
Make note of the password because it can't be retrieved, only reset.

#### Azure DevOps

1. Import the **`azure-pipelines.yaml`** and **`StarterAPIs.json`** files into Azure DevOps.
2. Create a new Azure Pipeline from the **`azure-pipelines.yaml`** file.

#### Selenium

1. [Download the latest Chrome driver](https://sites.google.com/a/chromium.org/chromedriver/).
        **`pip install -U selenium`**
2. You can test Selenium by executing the **`login.py`** file in the Selenium folder to view a demo site.

#### JMeter

1. [Install JMeter](https://jmeter.apache.org/download_jmeter.cgi).
2. Replace the APPSERVICEURL with the Url of your AppService once it's deployed.

#### Postman

[Install Postman](https://www.postman.com/downloads/).

