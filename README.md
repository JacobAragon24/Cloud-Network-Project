# Cloud-Network-Project
Azure Cloud Network

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![image](https://user-images.githubusercontent.com/93610565/157133100-0f980584-c70d-4595-9461-7f704cdb3418.png)


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible file may be used to install only certain pieces of it, such as Filebeat.

  - https://github.com/JacobAragon24/Cloud-Network-Project/tree/main/Ansible

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.
- The load balancer in this instance is a good way to mitigate DoS attacks as it will evenly distribute traffic to the webservers. 
- The load balancer also acts as a health probe, checking that the machines behind the load balancer are functioning properly before sending traffic to them. 
- The jump box machine is used as a gateway router forcing traffic through that single machine which makes it easier to secure and monitor traffic rather than securing and monitoring each individual machine.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the machine metrics and system files.
- Filebeat is used to collect data about the machines system files, this will help to make sure that our important documents haven't been changed or tampered with. 
- Metricbeat is used to collect data about the machines metrics such as CPU usage and uptime, this way we can insure the availability of our DVWA application that have been configured on each Web VM. 

The configuration details of each machine may be found below.
Note: The Web Servers have the same public IP Address because they're all behind the load balancer.

|    Name    |  Function  |               IP Address               | Operating System |
|:----------:|:----------:|:--------------------------------------:|:----------------:|
| Jump Box   |   Gateway  | Public: 20.127.21.57 Private: 10.1.0.6 |       Linux      |
|    Web-1   | Web Server | Public: 20.127.78.21 Private: 10.1.0.4 |       Linux      |
|    Web-2   | Web Server | Public: 20.127.78.21 Private: 10.1.0.5 |       Linux      |
|    Web-3   | Web Server | Public: 20.127.78.21 Private: 10.1.0.7 |       Linux      |
| Elk-Server | Monitoring | Public: 104.42.31.58 Private: 10.0.0.4 |       Linux      |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Workstation IP: 24.50.25.41

Machines within the network can only be accessed by Jump Box.
- The Jump Box VM was the only machine allowed access to the other machines in the environment with the IP Address of 10.1.0.6. 

A summary of the access policies in place can be found in the table below.

|    Name    | Publicly Accessible | Allowed IP Addresses |
|:----------:|:-------------------:|:--------------------:|
|   Jumpbox  |         Yes         |      24.50.25.41     |
|    Web-1   |          No         |       10.1.0.6       |
|    Web-2   |          No         |       10.1.0.6       |
|    Web-3   |          No         |       10.1.0.6       |
| Elk-Server |         Yes         | 10.1.0.6 24.50.25.41 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The automated ansible-playbook is advantageous because it will run the required tasks all at once instead of indivually running the multitude of commands required to configure the ELK machine.  

The playbook implements the following tasks:
- Use apt to install docker.io
- Use apt to install python3-pip
- Use pip to install docker module 
- Use sysctl to change the value of memory at your disposal to the max amount availible (262144)
- Use docker container to download the ELK container image sebp/elk:761 published on ports 5601:5601 9200:9200 5044:5044 with an restart policy of always
- Use systemd to enable service docker on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![image](https://user-images.githubusercontent.com/93610565/157108073-13e8f5b3-68d7-40b4-a397-ff1fcd5627c8.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 IP Address: 10.1.0.4
- Web-2 IP Address: 10.1.0.5
- Web-3 IP Address: 10.1.0.7

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is used to collect data about the machines system files such as syslogs, sudo commands, ssh logins and new users and groups When installed and running properly it should appear as the screenshot below: 

![image](https://user-images.githubusercontent.com/93610565/157132660-8b038692-4325-4078-80f8-e0bf350787cc.png)


- Metricbeat is used to collect data about the machines metrics such as CPU usage and Memory usage. When installed and running properly it should appear as the screenshot below:

![image](https://user-images.githubusercontent.com/93610565/157132343-2d2b052f-71c3-42f6-8296-95a76245a624.png)



### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the hosts file to ansible.
- Update the hosts file to include a new hosts section elk server called 'elk' then add the elk IP address: 10.0.0.4 followed by ansible_python_interpreter=/usr/bin/python3
- Run the playbook, and navigate to your ELK VM and run a docker ps command to check that the installation worked as expected.
- To see that ELK VM is up and running you can navigate to the URL http://104.42.31.5:5601/app/kibana and the it should appear as the screenshot below: 

![image](https://user-images.githubusercontent.com/93610565/157131755-ca3c9941-f1a9-476a-ac58-d9e3f50649d7.png)

