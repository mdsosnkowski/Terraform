variable "user" {
  description = "Login information"
  type        = map
  default     = {
    username = "admin"
    password = "******"
    url      = "https://sandboxapicdc.cisco.com"
  }
}
