resource "azurerm_public_ip" "bastion_host_public_ip" {
  
  name                ="${local.resource_name_prefix}-bastion-public-ip"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static" #or dynamic
  sku = "Standard"
}

#the network interface
resource "azurerm_network_interface" "bastion_host_linuxvm_nic" {
  name                = "${local.resource_name_prefix}-bastion-nic"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.bastionsubnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_public_ip.id
  }
}

##we will create the bastion host 

resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name                = "${local.resource_name_prefix}-bastion-linuxvm"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.bastion_host_linuxvm_nic.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/ssh-keys/terrafrom-azure.pub")
  }

  os_disk {
    
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  ##to execute the shell script terraform has an meta argument called as custom_data
  #$custom_data = filebase64("${path.module}/app-scripts/app.sh")
}