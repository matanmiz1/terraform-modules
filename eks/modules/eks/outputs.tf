output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}
