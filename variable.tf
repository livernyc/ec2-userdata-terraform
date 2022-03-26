variable "access_key" {
  type      = string
  default   = "AKIAQWEMCYUOS2LU64YK"
  sensitive = true
}
variable "secret_key" {
  type      = string
  default   = "bX4A6P3+1XESDan56yc5TQQIFnjYrisr3FUzB07h"
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
variable "ServerName" {
  type = string
  default = "test-skundu-machine-1"
} 