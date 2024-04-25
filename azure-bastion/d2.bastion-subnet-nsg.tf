#create the websubnet 
resource "azurerm_subnet" "bastionsubnet" {
  name = "${local.resource_name_prefix}-${var.bastion_subnet_name}"
  resource_group_name = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes = var.bastion_subnet_address
  
}

##create a nework securtiy group 
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name = "${local.resource_name_prefix}-bastion"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}
 #nsg need to be attached with my subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
  subnet_id = azurerm_subnet.bastionsubnet.id 
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id 
}

#inside nsg we will create rules
#local block for security rules 
locals {
  bastion_inbound_ports = {
    "110" : "22",
    #priority key and the port number is value
    "120" : "3389"
    
  }
  
}

#to do iteration on the string we will use for_each
#nsg inbound rule for the webtier subnet 
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each = local.bastion_inbound_ports
  name = "Rule-Port-${each.value}" #80
  priority = each.key #110
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.myrg.name 
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}
