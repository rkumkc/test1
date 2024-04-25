##if you want to define a public ip you can define in this block 
/*resource "azurerm_public_ip" "web_linuxvm_public_ip" {
  ##this resource block will create only single public ip
 # count = 2
  #for_each = toset(["vm1","vm2"])
  #for each accept argument in string format but you need to define multiple string using toset
  ## numeric interpolation
  #count always required a whole number
  name                = "${local.resource_name_prefix}-public-ip"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  allocation_method   = "Static" #or dynamic
 # domain_name_label   = "app1-vm-${each.key}-${random_string.random.id}"
}*/