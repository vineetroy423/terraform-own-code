output "publicip" {
  value       = aws_instance.dev.public_ip
  description = "printing the public ip"
}
output "privateip" {
  value       = aws_instance.dev.private_ip
  description = "pmkrinting private ip"
  sensitive   = true

}