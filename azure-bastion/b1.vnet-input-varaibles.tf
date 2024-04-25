#virtual network name 
variable "vnet_name" {
  description = "virtual network name"
  type = string 
  default = "vnet-default"
}

variable "vnet_address_space" {
  description = "virtual network address space"
  type = list(string)
  default = ["10.0.0.0/16"]
}
#web subnet name
variable "web_subnet_name" {
  description = "vnet websubnet name"
  type = string
  default = "websubnet"
}
#web subnet address
variable "web_subnet_address" {
  description = "v net web subnet address"
  type = list(string)
  default = [ "10.0.1.0/24" ]
}
#bastion subnet name
variable "bastion_subnet_name" {
  description = "vnet bastionsubnet name"
  type = string
  default = "bastionsubnet"
}

variable "bastion_subnet_address" {
  description = "v net bastion subnet address"
  type = list(string)
  default = [ "10.0.100.0/24" ]
}