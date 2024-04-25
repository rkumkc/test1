resource "azurerm_resource_group" "myrg" {
  ##using the refrence name all the resource value are mapped inside your terraform.tfstate file
  name     = var.resource_group_name

#to call a varaible var. nameofthe varaible 
  location = var.resource_group_location
  #tags = local.common_tags
}

