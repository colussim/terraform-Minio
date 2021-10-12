# Create a MinIO Server for S3-Compatible Object Hosting using Terraform

In this guide, we will learn how to install a MinIO server in Baremetal Infrastructure with Terraform in an AWS environment.

## Introduction to MinIO

MinIO is an open-source replacement for Amazon S3 (Simple Storage Service) for backing up files, as a storage back-end for tools like a container registry, or even for hosting static websites.

MinIO describes itself as:

>  100% open source, enterprise-grade, Amazon S3-compatible object storage.

MinIO offers high-performance, S3 compatible object storage.Native to Kubernetes, MinIO is the only object storage suite available on every public cloud, every Kubernetes distribution, the private cloud and the edge. MinIO is software-defined and is 100% open source under GNU AGPL v3.

For this guide, we will use AWS to host an instance, which will provide a public IP address, to which other servers or your project can connect

In this post you will see :
- How to Provisioning EBS volume for MinIO instance with Terraform
- How to deploy MinIO with Terraform
- Connect to the MinIO dashboard
- Create a Bucket
- Run MySQL Backup on MinIO Bucket

## Prerequisites

Before you get started, you’ll need to have these things:
* Terraform > 0.13.x
* An AWS account with the IAM permissions
* AWS CLI : [the AWS CLI Documentation](https://github.com/aws/aws-cli/tree/v2)
* AWS key-pair [Create a key pair using Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* MySQL Database

## Initial setup

- Clone the repository and install the dependencies:
```
$> git clone https://github.com/colussim/terraform-Minio.git
$> cd terraform-Minio
terraform-Minio $> mkdir ssh-keys
terraform-Minio $>  terraform init
```

> Copy your AWS key-pair in ssh-keys directory.
> Edit the file **variables.tf** and modify if necessary the private_key variable

## Usage

Install a MinIO server :

```
$> terraform apply
null_resource.minio-server (remote-exec): + sudo systemctl enable minio
null_resource.minio-server (remote-exec): Created symlink /etc/systemd/system/multi-user.target.wants/minio.service → /etc/systemd/system/minio.service.
null_resource.minio-server (remote-exec): + sudo systemctl start minio
null_resource.minio-server: Creation complete after 1m53s [id=1123250946150979358]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.
$>
```
