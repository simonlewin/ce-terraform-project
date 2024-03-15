<div align="center">
  <h1 align="center">Cloud Engineering Terraform Project</h1>
  <p align="center">
    <img width="350" src="./media/images/journey.png">
  </p>
  <p align="center">
    <p align="center"></p>
  </p>
</div>

## Overview

This repository contains the Terraform HCL code for the infrastructure used in Week 9 project of the [Northcoders](https://northcoders.com) Cloud Engineering Bootcamp.

This project involved building a fault tolerant scalable infrastructure on Amazon Web Services (AWS) for the back-end services of a smart home automation application. The infrastructure utilizes various AWS services including:

- Virtual Private Cloud (VPC)
- Security Groups
- DynamoDB,
- Application Load Balancers
- Auto Scaling

## Components

### Networking

The network utilises a Virtual Private Cloud (VPC) with the following components:

- **Public and Private Subnets:** The VPC is divided into public and private subnets across different Availability Zones. Public subnets allow microservices to be accessed from the internet, while private subnets house internal-facing services.
- **Internet Gateway:** An internet gateway is provisioned to facilitate outbound internet traffic for the public subnets.
- **NAT Gateway:** A NAT gateway is deployed to enable outbound internet access for resources in the private subnets. This ensures private services can access external resources while maintaining security.

This configuration provides a secure and scalable network foundation for the microservices application.

### Security Group Configuration

Security groups manage inbound and outbound network traffic for the application.

- **Web Server Security Group:** This group allows inbound HTTP (TCP port 80) and HTTPS (TCP port 443) traffic for communication with the application. It also allows outbound traffic for the web servers to access external resources.
- **SSH Security Group:** This group restricts inbound traffic to SSH (TCP port 22) connections originating from a single, specified IP address. This enhances security by limiting remote access to authorized users.

This configuration provides a balance between accessibility for web traffic and maintaining strict security for remote administration.

### DynamoDB Tables

DynamoDB tables provisioned using Terraform store data for the smart home application.

- **Heating:** This table stores information about heating zones within the smart home. The data model includes attributes for zone ID, location, and desired temperature.
- **Lighting:** This table stores information about individual lighting locations within the smart home. The data model includes light ID, location, and whether the light is on or off.

By leveraging DynamoDB, the application benefits from a scalable and NoSQL database solution for managing smart home data.

### Launch Templates

Launch Templates configured using Terraform manage the deployment of EC2 instances for the smart home application.

Each service uses a dedicated Launch Template:

- **Heating Service:** This template uses a custom AMI with the configuration for the heating service API endpoint.
- **Lighting Service:** Similar to the heating service, a custom AMI for the lighting service API endpoint is used.
- **Status Service:** A separate Launch Template defines the AMI for a status service which interacts with the heating and lighting service to manage the application status and provides a front-end to the authorisation service.
- **Authorisation Service:** Another Launch Template manages deployment of the authorization service AMI in a private subnet.

These Launch Templates ensure consistent configuration and efficient management of EC2 instances for each smart home service. This approach provides a modular and scalable solution for deploying the application's backend infrastructure.

### Application Load Balancers and Target Groups

Application Load Balancers (ALBs) and Target Groups using Terraform achieve scalability and efficient traffic distribution for the smart home application.

**Load Balancers:**

- **Public Application Load Balancer:** A public-facing ALB is deployed to distribute incoming internet traffic across healthy EC2 instances running the smart home service APIs (heating, lighting, etc.).
- **Internal Application Load Balancer:** An internal, private ALB operates within the VPC. It distributes internal network traffic amongst EC2 instances hosting the various services (status, authorization, etc.).

**Target Groups:**

- Each ALB is associated with target groups for the auto scaling groups running the corresponding service. Path-based routing rules within the ALBs direct incoming traffic to the appropriate target group based on the request path.

This combination of ALBs and target groups ensures efficient traffic management and scalability for both public and internal components of the smart home application.

### Auto Scaling

Auto Scaling groups implemented with Terraform achieve automatic scaling of the application's backend infrastructure.

**Auto Scaling Groups:**

- An Auto Scaling group is configured for each smart home service (heating, lighting, etc.). These groups manage a pool of EC2 instances running the corresponding service's backend logic.
- By defining minimum and maximum instance capacities, Auto Scaling automatically scales the number of instances up or down based on scaling policies. This ensures the application has sufficient resources to handle changing traffic demands while optimising costs during low usage periods.

This implementation provides dynamic scaling capabilities, allowing the infrastructure to adapt to the changing needs of the smart home application.
