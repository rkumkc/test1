#web linux instance count 
variable "web_linuxvm_instance_count" {
  description = "web linux vm instance count"
  type = map(string)
  #type = list(string)
  #default = "vm1","vm2"
  default = {
    #map contains the value in key value format
    "vm1" = "1022"
    "vm2" = "2022"
    #"vm3" = "3022"
  }
}