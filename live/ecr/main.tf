module "ecr" {
  source = "../../modules/ecr"

  account_id = data.aws_caller_identity.current.account_id

  name         = "my-test"
  sync_regions = ["us-east-2"]
}
