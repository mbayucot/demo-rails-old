resource "aws_ecs_cluster" "this" {
  name               = var.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
    base              = 1
  }
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Terraform = "true"
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = var.name
  network_mode             = "awsvpc"
  execution_role_arn       = var.iam_arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1500
  memory                   = 3300m

container_definitions = <<EOF
[
  {
    "name": "${var.name}_web",
    "image": "${var.image_url}:latest",
    "essential": true,
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "environment": ${data.template_file.environment_variables_rails.rendered},
    "secrets": ${data.template_file.enviorment_secrets.rendered},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "ap-northeast-1",
        "awslogs-group": "${var.cloudwatch_log_group_name}",
        "awslogs-stream-prefix": "${var.name}"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "web" {
name                               = "${var.name}_web"
task_definition                    = aws_ecs_task_definition.web.arn
cluster                            = aws_ecs_cluster.this.id
desired_count                      = 1
health_check_grace_period_seconds  = 20
enable_ecs_managed_tags            = true
deployment_minimum_healthy_percent = 100
deployment_maximum_percent         = 200
scheduling_strategy                = "REPLICA"

network_configuration {
subnets          = var.subnets
security_groups  = var.security_groups
assign_public_ip = true
}

capacity_provider_strategy {
  capacity_provider = "FARGATE"
  weight            = 1
  base              = 1
}

capacity_provider_strategy {
capacity_provider = "FARGATE_SPOT"
weight            = 1
base              = 0
}

load_balancer {
  target_group_arn = var.lb_blue_arn
  container_name   = var.web_container_name
  container_port   = 80
}

lifecycle {
  ignore_changes = [
      desired_count,
      task_definition,
      load_balancer
    ]
  }
}
