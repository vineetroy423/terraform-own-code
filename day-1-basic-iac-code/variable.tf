variable "ami" {
  description = "inserting value in to main.tf"
  type        = string
  default     = "ami-0a4408457f9a03be3"
}
variable "instance_type" {
  description = "inserting value in to main.tf"
  type        = string
  default     = "t2.micro"

}
variable "key" {
  description = "inserting value in to main.tf"
  type        = string
  default     = "my-pub-server-key"

}