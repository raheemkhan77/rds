## creating Ec2 instance
resource "aws_instance" "devec2" {
  ami           = "ami-005e54dee72cc1d00"  
  instance_type = "m5.xlarge"
  associate_public_ip_address = true
  vpc_security_group_ids = [ "sgr-09bf3d0994968a732" , "sgr-0fba24e3deb3bd92b"   ]
   count         = "2"
   tags = {
     "Name" = "dev-server ${count.index}"
   }
  
}
/* commenting key pair block 
# create a key pair
resource "aws_key_pair" "dev.ec2keypair" {
  key_name = "dev-ec2key"
  public_key = "ssh-rsa
  some key value to be generated using ssh- keygen and copy the whole key here" 
  
}

*/

/* elastci ip in case needed
# attaching elastic ip 
 resource  "aws_eip" "myeip" {
  vpc= true
  instance = "${aws_instance.devec2.id}"
 }
 */
