variable "aws_ami" {
  description = "centos 8"
  default     = "ami-0d6e9a57f6259ba3a"
}

variable "aws_instance_type" {
  description = "Machine Type"
  default     = "t3.medium"
}

variable "private_key" {
  type        = string
  default     = "ssh-keys/id_rsa_aws"
  description = "The path to your private key"
}

variable "volume_size" {
  default = "20"
  description = "Size for volume default : 20 GB"
}

variable "zone" {
  default = "us-east-1a"
}
