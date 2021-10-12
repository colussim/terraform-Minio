resource "aws_ebs_volume" "ebs_volume1" {
  availability_zone = "${var.zone}"
  size              = "${var.volume_size}"
}


resource "aws_instance" "minio-nodes" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  key_name      = "admin"
   subnet_id = "${aws_subnet.vmtest-a.id}"
  security_groups = [
    "${aws_security_group.sg_infra.id}"
  ]
tags= {
        Name = "minio0"
    }
}

resource "aws_volume_attachment" "volume_attachement" {
          device_name = "/dev/sdh"
          volume_id   = aws_ebs_volume.ebs_volume1.id
          instance_id = aws_instance.minio-nodes.id
  }

resource "null_resource" "minio-server" {

  provisioner "remote-exec" {
  inline = [
  <<EOH

  set -x

  sudo bash -c "echo 'type=83' | sudo sfdisk /dev/nvme1n1"
  sudo mkfs.ext4 /dev/nvme1n1p1

  sudo yum install -y wget
  sudo mkdir -p /opt/minio/bin
  sudo mkdir /opt/minio/data
  sudo mount -t ext4 /dev/nvme1n1p1  /opt/minio/data
  sudo bash -c 'echo "/dev/nvme1n1p1 /opt/minio/data ext4    rw,relatime   0    2" >> /etc/fstab'

  sudo wget https://dl.minio.io/server/minio/release/linux-amd64/minio -O /opt/minio/bin/minio 
  sudo chmod +x /opt/minio/bin/minio 

  sudo wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /opt/minio/bin/mc
  sudo chmod +x /opt/minio/bin/mc

  sudo useradd -s /sbin/nologin -d /opt/minio minio
  sudo bash -c 'echo "MINIO_VOLUMES=/opt/minio/data" > /opt/minio/minio.conf'
  sudo bash -c 'echo "MINIO_ROOT_USER=Admin" >> /opt/minio/minio.conf'
  sudo bash -c 'echo "MINIO_ROOT_PASSWORD=Bench123" >> /opt/minio/minio.conf'
  sudo chown -R minio:minio /opt/minio

  sudo wget https://raw.githubusercontent.com/colussim/terraform-Minio/main/minio/minio.service -O /etc/systemd/system/minio.service  
  sudo systemctl enable minio
  sudo systemctl start minio

EOH
]
connection {
                type        = "ssh"
                user        = "centos"
                host     = aws_instance.minio-nodes.public_ip
                private_key = file(var.private_key)
        }
}

}


