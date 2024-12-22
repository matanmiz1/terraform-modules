data "aws_ecr_lifecycle_policy_document" "this" {
  rule {
    priority    = 1
    description = "Expire untagged images older than 14 days"

    selection {
      tag_status   = "untagged"
      count_type   = "sinceImagePushed"
      count_unit   = "days"
      count_number = 14
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority    = 2
    description = "Keep last 50 images tagged with 'myprefix'"

    selection {
      tag_status      = "tagged"
      tag_prefix_list = ["myprefix"]
      count_type      = "imageCountMoreThan"
      count_number    = 50
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority    = 3
    description = "Expire all images older than 90 days"

    selection {
      tag_status   = "any"
      count_type   = "sinceImagePushed"
      count_unit   = "days"
      count_number = 90
    }
    action {
      type = "expire"
    }
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = data.aws_ecr_lifecycle_policy_document.this.json
}
