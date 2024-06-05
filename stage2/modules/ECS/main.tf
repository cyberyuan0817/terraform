# Query the current ECR repo
data "aws_ecr_repository" "ECR_repo" {
  name = var.ecr_repo_name
}

# Build the ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
    name = var.ecs_cluster_name
}



# Create the ECS task definition
resource "aws_ecs_task_definition" "ecs_task" {
  family                    = "${var.env_prefix}-task"
  task_role_arn = var.task_role_arn
  execution_role_arn       = var.task_role_arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = 1024
  memory = 3072

  container_definitions = <<DEFINITION
[
  {
    "name": "${var.ecr_repo_name}",
    "image": "${var.ecr_image_link_prefix}/${var.ecr_repo_name}",
    "cpu": 0,
    "portMappings": [
      {
        "name": "${var.ecr_repo_name}-3000-tcp",
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp",
        "appProtocol": "http"
      }
    ],
    "secrets": [
      {
        "name": "MONGO_URI",
        "valueFrom":"arn:aws:ssm:${var.aws_region}:${var.aws_iam_user_id}:parameter/MONGO_URI"
      },
      {
        "name": "JWT_SECRET",
        "valueFrom":"arn:aws:ssm:${var.aws_region}:${var.aws_iam_user_id}:parameter/JWT_SECRET"
      },
      {
        "name": "JWT_EXPIRE",
        "valueFrom":"arn:aws:ssm:${var.aws_region}:${var.aws_iam_user_id}:parameter/JWT_EXPIRE"
      },
      {
        "name": "NEXT_PUBLIC_SHOW_LOGGER",
        "valueFrom":"arn:aws:ssm:${var.aws_region}:${var.aws_iam_user_id}:parameter/NEXT_PUBLIC_SHOW_LOGGER"
      },
      {
        "name": "NEXT_PUBLIC_MAPS_API_KEY",
        "valueFrom":"arn:aws:ssm:${var.aws_region}:${var.aws_iam_user_id}:parameter/NEXT_PUBLIC_MAPS_API_KEY"
      },
      {
        "name": "NEXT_PUBLIC_BACKEND_URL",
        "valueFrom":"arn:aws:ssm:${var.aws_region}:${var.aws_iam_user_id}:parameter/NEXT_PUBLIC_BACKEND_URL"
      }
      

    ],
    "essential": true,
    "environment": [],
    "environmentFiles": [],
    "mountPoints": [],
    "volumesFrom": [],
    "ulimits": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "/ecs/${var.env_prefix}-task",
        "awslogs-region": "${var.aws_region}",
        "awslogs-stream-prefix": "ecs"
      },
      "secretOptions": []
    },
    "systemControls": []
    
  }
]
DEFINITION


}




// Run the ECS service
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.env_prefix}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  
  launch_type = "FARGATE"
  network_configuration {
    security_groups = [var.ecs_security_group]
    subnets         = var.ecs_subnets
    assign_public_ip = var.assign_public_ip
    
  }
  

// Attach ECS tasks as targets to the ALB target group
  load_balancer {
    target_group_arn = var.lb_target_group.arn
    container_name   = "${var.ecr_repo_name}"
    container_port   = 3000
  }


  
}
