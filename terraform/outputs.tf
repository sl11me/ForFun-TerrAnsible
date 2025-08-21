output "public_ip" {
  description = "Public IP of the web instance"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i ~/.ssh/forfun ubuntu@${aws_instance.web.public_ip}"
}
