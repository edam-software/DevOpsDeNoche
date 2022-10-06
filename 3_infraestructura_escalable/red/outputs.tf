output "subnets_cidr" {
  value = [for subnet in google_compute_subnetwork.kubernetes-subnets: subnet.ip_cidr_range]
}

output "subnets_pod" {
  value = [for subnet in google_compute_subnetwork.kubernetes-subnets: subnet.secondary_ip_range[0]]
}

output "subnets_servicios" {
  value = [for subnet in google_compute_subnetwork.kubernetes-subnets: subnet.secondary_ip_range[1]]
}
