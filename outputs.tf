output "master_public_ip" {
  value = aws_instance.minio-nodes.public_ip
}
