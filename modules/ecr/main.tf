resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  tags = var.tags
}

resource "aws_ecr_replication_configuration" "this" {
  count = length(var.sync_regions) > 0 ? 1 : 0

  replication_configuration {
    rule {
      dynamic "destination" {
        for_each = var.sync_regions
        content {
          region      = destination.value
          registry_id = var.account_id
        }
      }

      repository_filter {
        filter      = aws_ecr_repository.this.name
        filter_type = "PREFIX_MATCH"
      }
    }
  }
}

