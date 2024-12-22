variable "account_id" {
  type = string
}

variable "name" {
  type = string
}

variable "sync_regions" {
  description = "List of regions to replicate the ECR to"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
