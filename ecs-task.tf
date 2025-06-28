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
      
      # HTML with Terraform Best Practices explanation
      command = [
        "/bin/sh",
        "-c",
        "echo '<!DOCTYPE html><html lang=\"pt-BR\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Terraform Best Practices - HashiCorp Guidelines</title><style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:\"Segoe UI\",Tahoma,Geneva,Verdana,sans-serif;background:linear-gradient(135deg,#1a1a1a 0%,#2d3748 100%);color:#e2e8f0;line-height:1.6}.container{max-width:1200px;margin:0 auto;padding:20px}.header{text-align:center;margin-bottom:40px;padding:40px 0;background:rgba(255,255,255,0.05);border-radius:15px;border:1px solid rgba(255,255,255,0.1)}.header h1{font-size:3rem;margin-bottom:10px;background:linear-gradient(45deg,#00d4aa,#7c3aed);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}.header p{font-size:1.2rem;opacity:0.8}.section{background:rgba(255,255,255,0.05);border-radius:15px;padding:30px;margin-bottom:30px;border:1px solid rgba(255,255,255,0.1)}.section h2{color:#00d4aa;font-size:2rem;margin-bottom:20px;border-bottom:2px solid #00d4aa;padding-bottom:10px}.practice-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:20px;margin:20px 0}.practice-card{background:rgba(255,255,255,0.08);border-radius:10px;padding:20px;border-left:4px solid #00d4aa;transition:transform 0.3s ease}.practice-card:hover{transform:translateY(-5px)}.practice-card h3{color:#00d4aa;margin-bottom:10px;font-size:1.2rem}.status-badge{display:inline-block;padding:4px 8px;border-radius:12px;font-size:0.8rem;font-weight:bold;margin-bottom:10px;background:#10b981;color:white}.file-structure{background:#1a1a1a;border-radius:10px;padding:20px;margin:20px 0;font-family:\"Courier New\",monospace;border:1px solid #374151}.file-structure pre{color:#e2e8f0;line-height:1.5}.file-structure .folder{color:#00d4aa}.file-structure .file{color:#60a5fa}.code-example{background:#1a1a1a;border-radius:10px;padding:20px;margin:15px 0;font-family:\"Courier New\",monospace;border:1px solid #374151;overflow-x:auto}.code-example pre{color:#e2e8f0}.code-example .comment{color:#6b7280}.code-example .keyword{color:#f472b6}.code-example .string{color:#34d399}.code-example .number{color:#fbbf24}.benefits{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:20px;margin:20px 0}.benefit{background:rgba(255,255,255,0.08);border-radius:10px;padding:20px;text-align:center}.benefit h4{color:#00d4aa;margin-bottom:10px}.interactive-demo{background:rgba(0,0,0,0.3);border-radius:15px;padding:30px;margin:30px 0;text-align:center}.btn{background:linear-gradient(45deg,#00d4aa,#7c3aed);color:white;border:none;padding:15px 30px;border-radius:25px;font-size:1.1rem;cursor:pointer;margin:10px;transition:transform 0.3s ease}.btn:hover{transform:scale(1.05)}.footer{text-align:center;margin-top:50px;padding:20px;opacity:0.8;border-top:1px solid rgba(255,255,255,0.1)}@media(max-width:768px){.header h1{font-size:2rem}.practice-grid{grid-template-columns:1fr}}</style></head><body><div class=\"container\"><div class=\"header\"><h1>🏗️ Terraform Best Practices</h1><p>Estrutura e Boas Práticas da HashiCorp Implementadas</p></div><div class=\"section\"><h2>📁 Estrutura de Arquivos</h2><p>Organização seguindo as melhores práticas da HashiCorp:</p><div class=\"file-structure\"><pre><span class=\"folder\">Terraform-IA/</span>\n├── <span class=\"file\">main.tf</span>                 # Arquivo principal (vazio - boa prática)\n├── <span class=\"file\">providers.tf</span>           # Configuração de providers\n├── <span class=\"file\">versions.tf</span>            # Versões dos providers\n├── <span class=\"file\">variables.tf</span>           # Declaração de variáveis\n├── <span class=\"file\">outputs.tf</span>             # Outputs do Terraform\n├── <span class=\"file\">networking.tf</span>          # Recursos de rede (VPC, Subnets)\n├── <span class=\"file\">security.tf</span>            # Security Groups\n├── <span class=\"file\">compute.tf</span>             # ECS Cluster\n├── <span class=\"file\">ecs-task.tf</span>           # Task Definitions e Services\n├── <span class=\"file\">load-balancer.tf</span>      # ALB e Target Groups\n├── <span class=\"file\">autoscaling.tf</span>        # Auto Scaling Groups\n├── <span class=\"file\">iam.tf</span>                # IAM Roles e Policies\n├── <span class=\"file\">README.md</span>             # Documentação\n└── <span class=\"file\">terraform.tfrc</span>        # Configuração do Terraform</pre></div></div><div class=\"section\"><h2>✅ Boas Práticas Implementadas</h2><div class=\"practice-grid\"><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>📁 Separação por Responsabilidade</h3><p>Cada arquivo tem uma responsabilidade específica: networking, security, compute, etc. Facilita manutenção e navegação.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>🏷️ Nomenclatura Consistente</h3><p>Recursos nomeados com prefixo \"nh-\" seguindo padrão: nh-ecs, nh-alb, nh-teste. Evita conflitos e facilita identificação.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>🏷️ Tagging Estratégico</h3><p>Todos os recursos taggeados com Environment, Project, ManagedBy e Name. Facilita gerenciamento de custos e compliance.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>🔒 Princípio do Menor Privilégio</h3><p>Security groups otimizados: apenas acesso necessário entre ALB e ECS tasks. Sem acesso SSH desnecessário.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>📊 Monitoramento Integrado</h3><p>CloudWatch logs, métricas e alarms configurados. Auto scaling baseado em métricas de CPU.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>🔄 Versionamento de Providers</h3><p>Versões específicas definidas em versions.tf. Garante reprodutibilidade e estabilidade.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>📝 Documentação Completa</h3><p>README.md detalhado com arquitetura, funcionalidades, como usar e outputs importantes.</p></div><div class=\"practice-card\"><div class=\"status-badge\">✅ Implementado</div><h3>⚡ Auto Scaling Inteligente</h3><p>Target tracking scaling com cooldowns apropriados. Escala baseado em métricas reais de utilização.</p></div></div></div><div class=\"section\"><h2>💡 Exemplos de Implementação</h2><h3>📋 Variáveis Bem Definidas</h3><div class=\"code-example\"><pre><span class=\"comment\"># variables.tf</span>\n<span class=\"keyword\">variable</span> <span class=\"string\">\"aws_region\"</span> {\n  description = <span class=\"string\">\"AWS region\"</span>\n  type        = <span class=\"string\">string</span>\n  default     = <span class=\"string\">\"us-west-2\"</span>\n}\n\n<span class=\"keyword\">variable</span> <span class=\"string\">\"vpc_cidr\"</span> {\n  description = <span class=\"string\">\"CIDR block for VPC\"</span>\n  type        = <span class=\"string\">string</span>\n  default     = <span class=\"string\">\"192.168.0.0/16\"</span>\n}</pre></div><h3>🏷️ Tagging Estratégico</h3><div class=\"code-example\"><pre><span class=\"comment\"># Aplicado em todos os recursos</span>\n<span class=\"keyword\">tags</span> = merge(var.default_tags, {\n  Name = <span class=\"string\">\"nh-ecs\"</span>\n})\n\n<span class=\"comment\"># default_tags definido em variables.tf</span>\n<span class=\"keyword\">variable</span> <span class=\"string\">\"default_tags\"</span> {\n  description = <span class=\"string\">\"Default tags for all resources\"</span>\n  type        = map(string)\n  default = {\n    Environment = <span class=\"string\">\"development\"</span>\n    Project     = <span class=\"string\">\"terraform-mcp\"</span>\n    ManagedBy   = <span class=\"string\">\"terraform\"</span>\n  }\n}</pre></div><h3>🔒 Security Groups Otimizados</h3><div class=\"code-example\"><pre><span class=\"comment\"># security.tf - Apenas acesso necessário</span>\n<span class=\"keyword\">resource</span> <span class=\"string\">\"aws_security_group\"</span> <span class=\"string\">\"ecs_tasks\"</span> {\n  name        = <span class=\"string\">\"nh-ecs-tasks-sg\"</span>\n  description = <span class=\"string\">\"Security group for ECS tasks in Fargate\"</span>\n  vpc_id      = aws_vpc.main.id\n  \n  <span class=\"comment\"># Apenas HTTP do ALB</span>\n  ingress {\n    description     = <span class=\"string\">\"HTTP from ALB\"</span>\n    from_port       = <span class=\"number\">80</span>\n    to_port         = <span class=\"number\">80</span>\n    protocol        = <span class=\"string\">\"tcp\"</span>\n    security_groups = [aws_security_group.alb.id]\n  }\n  \n  <span class=\"comment\"># Egress necessário para internet</span>\n  egress {\n    description = <span class=\"string\">\"All outbound traffic\"</span>\n    from_port   = <span class=\"number\">0</span>\n    to_port     = <span class=\"number\">0</span>\n    protocol    = <span class=\"string\">\"-1\"</span>\n    cidr_blocks = [<span class=\"string\">\"0.0.0.0/0\"</span>]\n  }\n}</pre></div></div><div class=\"section\"><h2>🚀 Benefícios Alcançados</h2><div class=\"benefits\"><div class=\"benefit\"><h4>🛡️ Segurança</h4><p>Princípio do menor privilégio aplicado. Security groups otimizados sem acessos desnecessários.</p></div><div class=\"benefit\"><h4>💰 Custo</h4><p>Recursos otimizados e bem dimensionados. Auto scaling inteligente para controlar custos.</p></div><div class=\"benefit\"><h4>🛠️ Manutenção</h4><p>Código organizado e bem documentado. Fácil navegação e modificação.</p></div><div class=\"benefit\"><h4>📈 Escalabilidade</h4><p>Auto scaling configurado. Arquitetura preparada para crescimento.</p></div><div class=\"benefit\"><h4>🔍 Monitoramento</h4><p>Logs e métricas integrados. Visibilidade completa da infraestrutura.</p></div><div class=\"benefit\"><h4>🔄 Reprodutibilidade</h4><p>Infraestrutura como código. Deploy consistente e versionado.</p></div></div></div><div class=\"interactive-demo\"><h3>🎮 Demonstração Interativa</h3><p>Explore as boas práticas implementadas</p><button class=\"btn\" onclick=\"showPractice(\"security\")\">🔒 Ver Segurança</button><button class=\"btn\" onclick=\"showPractice(\"structure\")\">📁 Ver Estrutura</button><button class=\"btn\" onclick=\"showPractice(\"monitoring\")\">📊 Ver Monitoramento</button></div><div class=\"footer\"><p>🛠️ Desenvolvido seguindo as melhores práticas da HashiCorp</p><p>📅 Última atualização: <span id=\"current-date\"></span></p></div></div><script>document.getElementById(\"current-date\").textContent=new Date().toLocaleDateString(\"pt-BR\");function showPractice(practice){const practices={security:{title:\"🔒 Segurança Implementada\",content:\"• Security groups otimizados para Fargate\\n• Apenas acesso HTTP do ALB para ECS tasks\\n• Sem acesso SSH desnecessário\\n• Princípio do menor privilégio aplicado\\n• IAM roles com permissões mínimas\"},structure:{title:\"📁 Estrutura Organizada\",content:\"• Separação por responsabilidade\\n• Nomenclatura consistente (nh-*)\\n• Tagging estratégico em todos os recursos\\n• Documentação completa\\n• Versionamento de providers\"},monitoring:{title:\"📊 Monitoramento Completo\",content:\"• CloudWatch logs para containers\\n• Métricas de CPU para auto scaling\\n• Alarms configurados\\n• Target tracking scaling\\n• Health checks do ALB\"}};const practiceInfo=practices[practice];if(practiceInfo){alert(`${practiceInfo.title}\\n\\n${practiceInfo.content}`)}}</script></body></html>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
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