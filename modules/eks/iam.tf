resource "aws_iam_role" "workers" {
  name               = "${var.cluster_name}-nodes-group"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
}

resource "aws_iam_role_policy_attachment" "workers" {
  for_each   = toset(local.workers_policies)
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
  role       = aws_iam_role.workers.name
}

resource "aws_iam_instance_profile" "workers" {
  name = "${aws_iam_role.workers.name}-profile"
  role = aws_iam_role.workers.name
}
