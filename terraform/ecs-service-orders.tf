module "ecs_service_orders" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "5.2.2"

  name        = "orders"
  cluster_arn = module.ecs_cluster_orders.arn

  cpu    = 1024
  memory = 4096

  container_definitions = {
    ("orders") = {
      essential = true
      cpu       = 512
      memory    = 1024
      image     = module.ecr_orders.repository_url

      port_mappings = [
        {
          name          = "orders"
          containerPort = 5202
          hostPort      = 5202
          protocol      = "tcp"
        }
      ]

      readonly_root_filesystem  = false
      enable_cloudwatch_logging = false

      log_configuration = {
        logDriver = "awslogs"
        options = {
          awslogs-create-group  = "true"
          awslogs-group         = "/ecs/orders"
          awslogs-region        = local.region
          awslogs-stream-prefix = "ecs"
        }
      }

      memory_reservation = 100
    }
  }

  load_balancer = {
    service = {
      target_group_arn = element(module.ecs_alb_orders.target_group_arns, 0)
      container_name   = "orders"
      container_port   = 5202
    }
  }

  subnet_ids = module.vpc.private_subnets

  security_group_rules = {
    alb_ingress = {
      type                     = "ingress"
      from_port                = 5202
      to_port                  = 5202
      protocol                 = "tcp"
      source_security_group_id = module.ecs_alb_sg_orders.security_group_id
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_service_discovery_http_namespace" "orders" {
  name = "orders"
}

output "service_id_orders" {
  description = "ARN that identifies the service"
  value       = module.ecs_service_orders.id
}

output "service_name_orders" {
  description = "Name of the service"
  value       = module.ecs_service_orders.name
}

output "service_iam_role_name_orders" {
  description = "Service IAM role name"
  value       = module.ecs_service_orders.iam_role_name
}

output "service_iam_role_arn_orders" {
  description = "Service IAM role ARN"
  value       = module.ecs_service_orders.iam_role_arn
}

output "service_iam_role_unique_id_orders" {
  description = "Stable and unique string identifying the service IAM role"
  value       = module.ecs_service_orders.iam_role_unique_id
}

output "service_container_definitions_orders" {
  description = "Container definitions"
  value       = module.ecs_service_orders.container_definitions
}

output "service_task_definition_arn_orders" {
  description = "Full ARN of the Task Definition (including both `family` and `revision`)"
  value       = module.ecs_service_orders.task_definition_arn
}
