#create the websubnet 
resource "azurerm_subnet" "websubnet" {
  name = "${local.resource_name_prefix}-${var.web_subnet_name}"
  resource_group_name = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name 
  address_prefixes = var.web_subnet_address
  
}

##create a nework securtiy group 
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name = "${local.resource_name_prefix}-nsg"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}
 #nsg need to be attached with my subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
  subnet_id = azurerm_subnet.websubnet.id 
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id 
}

#inside nsg we will create rules
#local block for security rules 
locals {
  web_inbound_ports = {
    "110" : "80",
    #priority key and the port number is value
    "120" : "443",
    "130" : "22"
  }
}

#to do iteration on the string we will use for_each
#nsg inbound rule for the webtier subnet 
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = local.web_inbound_ports
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
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}
