###create the vnet need to be attached with your rg
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = ["10.0.0.0/16"]
  #class B network
  #65564

  tags = {
    environment = "Production"
  }
}
###inside the vnet we want to create a subnet
##two mapping need to be done one is with resource group the other one is with vnet

resource "azurerm_subnet" "mysubnet" {

  name = "my-subnet"
  #we are creating a subnet this subnet need to be part of rg
  resource_group_name = azurerm_resource_group.myrg.name
  #the subnet also is part of vnet
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
  #it will give me a pool of 255 ip address


}
##the public ip
resource "azurerm_public_ip" "mypublicip" {
  ##this resource block will create only single public ip
 # count = 2
  for_each = toset(["vm1","vm2"])
  #for each accept argument in string format but you need to define multiple string using toset
  ## numeric interpolation
  #count always required a whole number
  name                = "mypublicip-${each.key}" #mypublicip-0
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static" #or dynamic
  domain_name_label   = "app1-vm-${each.key}-${random_string.random.id}"
}

#the network interface
resource "azurerm_network_interface" "myvmnic" {
  for_each = toset(["vm1","vm2"])
  name                = "vmnic-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip[each.key].id
  }
}