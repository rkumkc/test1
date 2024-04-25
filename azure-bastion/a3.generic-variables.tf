##this are input varabiels
variable "business_division" {
  description = "business devision"
  type = string #list #map
  default = "sap"
}

#environment-variable 
variable "environment" {
  description = "environemtn varables used as prefix"
  type = string
  default = "dev"
}

variable "resource_group_name" {
  description = "resource group name"
  type = string 
  default = "rg-default"
}

variable "resource_group_location" {
  type = string
  default = "eastus"
}

#rg-default-dev-sap