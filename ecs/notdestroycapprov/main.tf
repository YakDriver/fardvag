provider "aws" {}

locals {
  // cluster_name is a local to avoid the cyclical dependency:
  // cluster -> capacity provider -> asg -> launch template -> user data -> cluster.
  cluster_name = random_pet.name.id
}

data "aws_availability_zones" "current" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "random_pet" "name" {}

data "aws_ami" "test" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.*-x86_64-ebs"]
  }
}

resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = random_pet.name.id
  }
}

resource "aws_subnet" "test" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = random_pet.name.id
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.test.id
}

resource "aws_route_table_association" "main" {
  route_table_id = aws_route_table.main.id
  subnet_id      = aws_subnet.test.id
}

resource "aws_security_group" "test" {
  vpc_id = aws_vpc.test.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = random_pet.name.id
  }
}

resource "aws_ecs_cluster" "test" {
  name = local.cluster_name

  capacity_providers = [aws_ecs_capacity_provider.test.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.test.name
  }
}

resource "aws_ecs_capacity_provider" "test" {
  name = random_pet.name.id

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.test.arn
  }
}

resource "aws_iam_role" "test" {
  name = random_pet.name.id

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = {
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }
  })
}

resource "aws_iam_role_policy_attachment" "test" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = aws_iam_role.test.id
}

resource "aws_iam_instance_profile" "test" {
  depends_on = [aws_iam_role_policy_attachment.test]
  role       = aws_iam_role.test.name
}

resource "aws_launch_template" "test" {
  image_id                             = data.aws_ami.test.id
  instance_type                        = "t3.micro"
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = [aws_security_group.test.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.test.name
  }

  user_data = base64encode(<<EOL
#!/bin/bash
echo "ECS_CLUSTER=${local.cluster_name}" >> /etc/ecs/ecs.config
EOL
  )
}

resource "aws_autoscaling_group" "test" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  name                = random_pet.name.id
  vpc_zone_identifier = [aws_subnet.test.id]

  instance_refresh {
    strategy = "Rolling"
  }

  launch_template {
    id      = aws_launch_template.test.id
    version = aws_launch_template.test.latest_version
  }

  tags = [{
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }]
}
