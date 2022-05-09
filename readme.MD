# Running CMS Risk Adjustment Models via API with SAS Analytics Pro (Viya) on Azure

## Overview

This repository is an asset for those that want to install and configure SAS Analytics Pro (Viya) on Azure and connect to third party applications via SSH.

Here is what you will be able to accomplish:

1)	Deploy an Azure instance with Ubuntu
2)	Install Docker on this instance
3)	Clone the GitHub repository
4)	Install SAS Analytics Pro on Viya
5)	Configure password-less SSH on the SAS Analytics Pro Viya
6)	Build the container for the Flask application
7)	Run the Flask application container 
8)	Test password-less SHS from the Flask container to the SAS Analytics Pro on Viya
9)	Configure ports on the Azure instance to make sure it is accessible from my machine
10)	Run the application on the browser to score new patients
___
You can watch the video below for more detailed explanation on each step.

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/NLIs4cTVQjU/0.jpg)](https://www.youtube.com/watch?v=NLIs4cTVQjU)

___
Here it is a overview of this repo.

![Repository Overview](repo_overview.png)

___

### Installation

#### 1 - Install Docker

** note: execute these commands on the Linux instance command line.

```shell
sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

#### 2 - Get Project Files

** note: execute this command on the Linux instance command line.

```shell
git clone https://github.com/ldepaula3/apro_flask_azure
```

#### 2.1 - Get your SAS license file (.jwt) and paste inside aprocontainer/sasinside/ directory

#### 3 - Download images from SAS Mirror

** note: execute this command on the Linux instance command line.

```shell
sudo docker pull [SAS Mirror]/viya-4-x64_oci_linux_2-docker/sas-analytics-pro:[TAG]
```

#### 4 - Set Permissions & configure SSH - generate keys

** note: execute these commands on the Linux instance command line.

```shell
cd apro_flask_azure 

chmod 777 ssh_setup.sh

./ssh_setup.sh
```

#### 5 - Run SAS Analytics Pro on Viya Container

** note 1: execute these commands on the Linux instance command line.
** note 2: you will have to edit the file launchsas.sh (lines 3 and 11) to match the **image mirror, tag and license filename**.

```shell
cd aprocontainer 

./launchsas.sh

sudo docker logs -f sas-analytics-pro

docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sas-analytics-pro
```

#### 6 - Get inside SAS Analytics Pro on Viya container and set permissions on keys/folders

** note 1: execute these command on the Linux instance command line.
** note 2: it will then login into the container and the next 4 commands are executed inside the sas-analytics-pro container.

```shell

sudo docker exec -it sas-analytics-pro bash

su sasdemo

chmod -R 700 /data

cd data/.ssh

chmod 600 authorized_keys id_rsa id_rsa.pub 
```

#### 6.1 (optional) - Test SSH connection

** note: execute these commands inside the sas-analytics-pro container.

```shell
ssh localhost 
```
___
#### Exit and go back to linux machine where docker is running 
___

#### 7 - Build Simple-Flask container

** note 1: execute these commands on the Linux instance command line.

```shell
cd ../simple-flask

sudo docker build --tag python-docker . 
```

#### 8 - Run Simple-Flask Application container

** note 1: execute these commands on the Linux instance command line.

```shell
./launchpython.sh
```

#### 9 - Check if Simple-Flask can connect to SAS Analytics Pro container

** note 1: execute the first command on the Linux instance command line.
** note 2: it will then login into the container and the next 2 commands are executed inside the Simple Flask container.
** note 3: make sure the IP address matches the one on **simple-flask/configs/sascfg_personal.py** (as we checked on step 5)

```shell

docker exec -it [SIMPLE FLASK CONTAINER ID] bash

cd /root/.ssh

ssh sasdemo@172.17.0.2
```

#### 10 (optional) - Inspect logs from Simple-Flask container

** note 1: execute this command on the Linux instance command line.

```shell
sudo docker logs -f [CONTAINER_ID]
```

___

## Additional Resources

* [SAS Analytics Pro product page](https://www.sas.com/en_us/software/analytics-pro.html)
* [SAS Analytics Pro documentation](https://go.documentation.sas.com/doc/en/anprocdc/v_010/anprowlcm/home.htm?fromDefault=)
* [SASPy documentation](https://sassoftware.github.io/saspy)
