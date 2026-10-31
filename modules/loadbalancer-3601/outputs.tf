output "load_balancer_name" {
  description = "Name of the public Load Balancer"
  value       = azurerm_lb.lb.name
}
