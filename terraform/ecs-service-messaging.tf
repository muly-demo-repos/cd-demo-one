module "ecs_service_messaging" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "5.2.2"

  name        = "messaging"
  cluster_arn = module.ecs_cluster_messaging.arn

  cpu    = 1024
  memory = 4096

  container_definitions = {
    ("messaging") = {
      essential = true
      cpu       = 512
      memory    = 1024
      image     = module.ecr_messaging.repository_url

      port_mappings = [
        {
          name          = "messaging"
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
          awslogs-group         = "/ecs/messaging"
          awslogs-region        = local.region
          awslogs-stream-prefix = "ecs"
        }
      }

      memory_reservation = 100
    }
  }

  load_balancer = {
    service = {
      target_group_arn = element(module.ecs_alb_messaging.target_group_arns, 0)
      container_name   = "messaging"
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
      source_security_group_id = module.ecs_alb_sg_messaging.security_group_id
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

resource "aws_service_discovery_http_namespace" "messaging" {
  name = "messaging"
}

output "service_id_messaging" {
  description = "ARN that identifies the service"
  value       = module.ecs_service_messaging.id
}

output "service_name_messaging" {
  description = "Name of the service"
  value       = module.ecs_service_messaging.name
}

output "service_iam_role_name_messaging" {
  description = "Service IAM role name"
  value       = module.ecs_service_messaging.iam_role_name
}

output "service_iam_role_arn_messaging" {
  description = "Service IAM role ARN"
  value       = module.ecs_service_messaging.iam_role_arn
}

output "service_iam_role_unique_id_messaging" {
  description = "Stable and unique string identifying the service IAM role"
  value       = module.ecs_service_messaging.iam_role_unique_id
}

output "service_container_definitions_messaging" {
  description = "Container definitions"
  value       = module.ecs_service_messaging.container_definitions
}

output "service_task_definition_arn_messaging" {
  description = "Full ARN of the Task Definition (including both `family` and `revision`)"
  value       = module.ecs_service_messaging.task_definition_arn
}
