# Create a MinIO Server for S3-Compatible Object Hosting using Terraform

In this guide, we will learn how to install a MinIO server in Baremetal Infrastructure with Terraform in an AWS environment.

## Introduction to MinIO

MinIO is an open-source replacement for Amazon S3 (Simple Storage Service) for backing up files, as a storage back-end for tools like a container registry, or even for hosting static websites.

MinIO describes itself as:

>  100% open source, enterprise-grade, Amazon S3-compatible object storage.

MinIO offers high-performance, S3 compatible object storage.Native to Kubernetes, MinIO is the only object storage suite available on every public cloud, every Kubernetes distribution, the private cloud and the edge. MinIO is software-defined and is 100% open source under GNU AGPL v3.

For this guide, we will use AWS to host an instance, which will provide a public IP address, to which other servers or your project can connect
