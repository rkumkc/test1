resource "null_resource" "null_copy_ssh" {
  #connection block to connect to azure vm instance 
  depends_on = [ azurerm_linux_virtual_machine.bastion_host_linuxvm ]
  connection {
    type = "ssh" #rdp
    host = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user =  azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    #password = 
    private_key = file("${path.module}/ssh-keys/terrafrom-azure.pem")
  }
#once i make the connection we need to upload the ssh key
  provisioner "file" {
   # source = "ssh-keys/terrafrom-azure.pem" #local machine
    source = "ssh-keys/terrafrom-azure.pem"
    destination = "/tmp/terrafrom-azure.pem" #it will upload in the bastion server
  }
#once you upload the file i need to run some command
#remote exec will run the 
  provisioner "remote-exec" {
    inline = [ 
        "sudo chmod 400 /tmp/terrafrom-azure.pem"
     ]
  }
}