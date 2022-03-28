variable "access_key" {
  type      = string
  default   = ""
  sensitive = true
}
variable "secret_key" {
  type      = string
  default   = ""
  sensitive = true
}
variable "region" {
  type    = string
  default = "us-east-1"
}
variable "private_ip_address" {
  type    = string
  default = "10.20.20.120"

}
variable "ServerName1" {
  type = string
  default = "test-win-machine"
} 
variable "ServerName2" {
  type = string
  default = "test-win-machine"
}