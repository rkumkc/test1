##terraform has 
#to create resource we use resource block
#to create varabiel varable block

output "web_lb_public_ip" {
  description = "Web LoadBalancer Public Ip"
  value = azurerm_public_ip.web_lb_publicip.ip_address
}

output "web_lb_id" {
  description = "web lb id"
  value = azurerm_lb.web_lb.id

}