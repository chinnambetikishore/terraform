resource "aws_default_security_group" "default-sg" {
  
  vpc_id=var.vpc_id
  
  ingress{
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=[var.my_ip]
  }
  ingress{
    from_port=8080
    to_port=8080
    protocol="tcp"
    cidr_blocks=[var.my_ip]

  }
  egress{
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
    prefix_list_ids=[]
  }
   

}
 
data "aws_ami" "latest-amazon-linux-image" {
  most_recent= true
  owners=["amazon"]
  filter{
    name="name"
    values=[var.image_name]
  }
  filter{
    name="virtualization-type"
    values=["hvm"]
  }

   
}

output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
   
}
resource "aws_key_pair" "ssh-key"{
  key_name="server"
  public_key= file(var.public_key_location)
}
resource "aws_instance" "myapp-server" {
  ami=data.aws_ami.latest-amazon-linux-image.id
  instance_type=var.instance_type

  subnet_id=var.subnet_id
  vpc_security_group_ids=[aws_default_security_group.default-sg.id]
  availability_zone=var.avail_zone

  associate_public_ip_address=true
  key_name=aws_key_pair.ssh-key.key_name
  user_data = file("script.sh")
  

}