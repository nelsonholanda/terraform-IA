# NH-TESTE ECS Task Definition (Fargate)
resource "aws_ecs_task_definition" "nh_teste" {
  family                   = "NH-TESTE"
  network_mode             = "awsvpc"  # Required for Fargate
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  
  container_definitions = jsonencode([
    {
      name  = "nh-teste-container"
      image = "nginx:latest"
      
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      
      # Interactive HTML with Terraform explanation
      command = [
        "/bin/sh",
        "-c",
        "echo '<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Terraform IA</title><style>body{font-family:Arial,sans-serif;background:linear-gradient(45deg,#667eea,#764ba2);color:white;margin:0;padding:20px}.container{max-width:1000px;margin:0 auto}.header{text-align:center;margin-bottom:40px}.header h1{font-size:3rem;margin-bottom:10px}.architecture{background:rgba(255,255,255,0.1);border-radius:15px;padding:30px;margin-bottom:30px}.architecture h2{text-align:center;font-size:2rem;margin-bottom:30px}.components{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:20px;margin-bottom:30px}.component{background:rgba(255,255,255,0.2);padding:20px;border-radius:10px;text-align:center;cursor:pointer;transition:all 0.3s ease}.component:hover{background:rgba(255,255,255,0.3)}.component h3{font-size:1.3rem;margin-bottom:10px}.flow{background:rgba(255,255,255,0.1);border-radius:10px;padding:30px;margin:30px 0;text-align:center}.flow-steps{display:flex;justify-content:space-between;align-items:center;margin:30px 0}.step{background:#667eea;padding:15px;border-radius:50%;width:60px;height:60px;display:flex;align-items:center;justify-content:center;font-weight:bold}.features{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:20px;margin:30px 0}.feature{background:rgba(255,255,255,0.1);padding:20px;border-radius:10px;border-left:4px solid #667eea}.feature h4{color:#667eea;margin-bottom:10px}.demo{background:rgba(0,0,0,0.3);padding:30px;border-radius:15px;margin:30px 0;text-align:center}.btn{background:linear-gradient(45deg,#667eea,#764ba2);color:white;border:none;padding:15px 30px;border-radius:25px;font-size:1.1rem;cursor:pointer;margin:10px}.status{display:inline-block;width:20px;height:20px;border-radius:50%;margin-right:10px;background:#27ae60}.footer{text-align:center;margin-top:50px;padding:20px;opacity:0.8}@media(max-width:768px){.header h1{font-size:2rem}.flow-steps{flex-direction:column}}</style></head><body><div class=\"container\"><div class=\"header\"><h1>🚀 Terraform IA</h1><p>Infraestrutura como Código na AWS com ECS Fargate</p></div><div class=\"architecture\"><h2>🏗️ Arquitetura da Infraestrutura</h2><div class=\"components\"><div class=\"component\" onclick=\"showInfo(\"vpc\")\"><h3>🌐 VPC & Networking</h3><p>VPC com 4 subnets públicas em múltiplas AZs</p></div><div class=\"component\" onclick=\"showInfo(\"ecs\")\"><h3>🐳 ECS Fargate</h3><p>Cluster ECS com tasks escaláveis</p></div><div class=\"component\" onclick=\"showInfo(\"alb\")\"><h3>⚖️ Load Balancer</h3><p>ALB para distribuição de tráfego</p></div><div class=\"component\" onclick=\"showInfo(\"security\")\"><h3>🔒 Security Groups</h3><p>Segurança otimizada para Fargate</p></div><div class=\"component\" onclick=\"showInfo(\"autoscaling\")\"><h3>📈 Auto Scaling</h3><p>Escalabilidade automática baseada em CPU</p></div><div class=\"component\" onclick=\"showInfo(\"monitoring\")\"><h3>📊 Monitoramento</h3><p>CloudWatch logs e métricas</p></div></div><div class=\"flow\"><h3>🔄 Fluxo de Tráfego</h3><div class=\"flow-steps\"><div class=\"step\">1</div><div class=\"step\">2</div><div class=\"step\">3</div><div class=\"step\">4</div></div><p>Internet → ALB → ECS Tasks → Aplicação</p></div></div><div class=\"features\"><div class=\"feature\"><h4>🚀 Fargate Serverless</h4><p>Sem gerenciamento de servidores, apenas containers</p></div><div class=\"feature\"><h4>⚡ Auto Scaling Inteligente</h4><p>Escala automaticamente baseado na utilização de CPU</p></div><div class=\"feature\"><h4>🔒 Segurança Otimizada</h4><p>Security groups simplificados sem acesso SSH</p></div><div class=\"feature\"><h4>📊 Monitoramento Completo</h4><p>Logs e métricas integrados com CloudWatch</p></div></div><div class=\"demo\"><h3>🎮 Demonstração Interativa</h3><p>Clique nos botões para simular o funcionamento da infraestrutura</p><button class=\"btn\" onclick=\"simulateDeploy()\">🚀 Deploy da Infraestrutura</button><button class=\"btn\" onclick=\"simulateScaling()\">📈 Simular Auto Scaling</button><div id=\"status\" style=\"margin-top:20px\"><p><span class=\"status\"></span>Sistema Operacional</p></div></div><div class=\"footer\"><p>🛠️ Desenvolvido com Terraform e AWS ECS Fargate</p><p>📅 Última atualização: <span id=\"date\"></span></p></div></div><script>document.getElementById(\"date\").textContent=new Date().toLocaleDateString(\"pt-BR\");function showInfo(component){const info={vpc:\"VPC com CIDR 192.168.0.0/16, 4 subnets públicas em diferentes AZs, Internet Gateway e Route Tables configurados.\",ecs:\"ECS Cluster usando Fargate, sem gerenciamento de servidores. Tasks escaláveis de 1-5 instâncias.\",alb:\"Application Load Balancer público distribuindo tráfego entre as tasks ECS na porta 80.\",security:\"Security groups otimizados: ALB (portas 80/443), ECS Tasks (apenas porta 80 do ALB).\",autoscaling:\"Auto Scaling baseado em CPU: escala quando > 10%, reduz quando < 5%.\",monitoring:\"CloudWatch Logs para containers, métricas de CPU e alarms configurados.\"};alert(info[component])}function simulateDeploy(){const status=document.getElementById(\"status\");status.innerHTML=\"<p><span class=\\\"status\\\"></span>Deploy em andamento...</p>\";setTimeout(()=>{status.innerHTML=\"<p><span class=\\\"status\\\"></span>Infraestrutura Deployada com Sucesso!</p>\"},2000)}function simulateScaling(){const status=document.getElementById(\"status\");status.innerHTML=\"<p><span class=\\\"status\\\"></span>Detectando alta carga de CPU...</p>\";setTimeout(()=>{status.innerHTML=\"<p><span class=\\\"status\\\"></span>Auto Scaling ativado: 3 tasks em execução</p>\"},1500)}</script></body></html>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/NH-TESTE"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      
      essential = true
    }
  ])
  
  tags = merge(var.default_tags, {
    Name = "NH-TESTE-task-definition"
  })
}

# NH-TESTE ECS Service
resource "aws_ecs_service" "nh_teste" {
  name            = "NH-TESTE-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nh_teste.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  # Enable service discovery and auto scaling
  enable_execute_command = true
  
  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nh_teste.arn
    container_name   = "nh-teste-container"
    container_port   = 80
  }

  # Health check grace period for auto scaling
  health_check_grace_period_seconds = 60

  depends_on = [aws_lb_listener.http]
  
  tags = merge(var.default_tags, {
    Name = "NH-TESTE-service"
  })
}

# CloudWatch Log Group for NH-TESTE
resource "aws_cloudwatch_log_group" "nh_teste" {
  name              = "/ecs/NH-TESTE"
  retention_in_days = 7
  
  tags = merge(var.default_tags, {
    Name = "NH-TESTE-log-group"
  })
} 