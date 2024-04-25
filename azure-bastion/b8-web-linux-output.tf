#display all the private ip address of my instance 
output "web_linuxvm_instance_ip_address_list" {
  description = "web linux vm virtual machine ip address"
  value = [for vm in azurerm_linux_virtual_machine.example: vm.private_ip_address]
}
output "virtual_network_name" {
  description = "vnet name"
  value = azurerm_virtual_network.vnet.name
}