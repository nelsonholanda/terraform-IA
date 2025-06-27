# Terraform ECS Infrastructure with Load Balancer

Este projeto Terraform cria uma infraestrutura simplificada na AWS com ECS Fargate, Application Load Balancer e um serviço nginx com HTML customizado.

## Arquitetura

A infraestrutura inclui:

- **VPC** com subnets públicas em múltiplas zonas de disponibilidade
- **ECS Cluster** usando Fargate
- **Application Load Balancer (ALB)** para distribuir tráfego
- **Um serviço ECS**:
  - `NH-TESTE`: Serviço nginx com página HTML contendo "NH-TESTE"
- **Auto Scaling Group** com regras baseadas em CPU:
  - **Scale Up**: Adiciona instância quando CPU > 10%
  - **Scale Down**: Remove instância quando CPU < 5%
  - **Capacidade**: Mínimo 1, Máximo 5 instâncias
- **Security Groups** configurados adequadamente
- **CloudWatch Log Group** para logs do container
- **CloudWatch Alarms** para monitoramento de CPU

## Funcionalidade

O serviço ECS roda um container nginx que exibe uma página HTML simples com:
- Título: "NH-TESTE"
- Conteúdo: "Bem-vindo ao teste!"

## Recursos Criados

### Networking
- VPC com CIDR `192.168.0.0/16`
- 4 subnets públicas em diferentes AZs
- Internet Gateway
- Route Tables

### Compute
- ECS Cluster `nh-ecs`
- 1 Task Definition (NH-TESTE)
- 1 ECS Service com Auto Scaling (1-5 instâncias)

### Auto Scaling
- Auto Scaling Target para o serviço ECS
- 1 política de Target Tracking Scaling (gerencia scale up e scale down)
- CloudWatch Alarms para monitoramento de CPU (apenas alertas)
- Cooldown de 30s para scale out, 2min para scale in

### Load Balancer
- Application Load Balancer público
- 1 Target Group para o serviço
- Listener HTTP na porta 80

### Security
- Security Group para ALB (portas 80 e 443)
- Security Group para ECS Tasks (apenas porta 80 do ALB, sem acesso SSH ou ECS Agent)

### IAM
- Task Execution Role
- Task Role

### Monitoring
- CloudWatch Log Group para o serviço
- CloudWatch Alarms para CPU (alta e baixa utilização)

## Como Usar

### Pré-requisitos
- Terraform >= 1.0
- AWS CLI configurado
- Permissões adequadas na AWS

### Deploy
```bash
# Inicializar Terraform
terraform init

# Planejar deploy
terraform plan

# Aplicar infraestrutura
terraform apply
```

### Acessar a Aplicação

Após o deploy, você pode acessar:

- **Aplicação**: `http://<alb-dns-name>/`

O URL completo será exibido nos outputs do Terraform.

### Outputs Importantes

```bash
# Ver todos os outputs
terraform output

# Ver URL da aplicação
terraform output application_url

# Ver DNS do load balancer
terraform output alb_dns_name
```

## Configurações

### Variáveis Disponíveis

- `aws_region`: Região AWS (padrão: us-west-2)
- `vpc_cidr`: CIDR da VPC (padrão: 192.168.0.0/16)
- `public_subnet_cidrs`: Lista de CIDRs das subnets públicas
- `availability_zones`: Lista de zonas de disponibilidade

### Tags

Todos os recursos são taggeados com:
- `Environment`: development
- `Project`: terraform-mcp
- `ManagedBy`: terraform

## Monitoramento

- **Logs**: CloudWatch Log Group para o serviço
- **Métricas**: Container Insights habilitado no cluster ECS
- **Health Checks**: ALB verifica saúde da instância a cada 30s

## Auto Scaling

O serviço ECS está configurado com Auto Scaling baseado na utilização de CPU:

### Vinculação com ECS
- **Auto Scaling Target**: Vinculado diretamente ao serviço ECS `NH-TESTE-service`
- **Métrica**: Utilização média de CPU do serviço ECS
- **Dimensão**: `ecs:service:DesiredCount` (controla o número de tasks)
- **Capacity Providers**: FARGATE configurado para suportar auto scaling

### Regras de Scaling
- **Target Tracking**: Mantém CPU em torno de 7.5%
- **Scale Up**: Automaticamente quando CPU aumenta
- **Scale Down**: Automaticamente quando CPU diminui
- **Cooldown**: 30 segundos para scale out, 2 minutos para scale in
- **Capacidade**: Mínimo 1, Máximo 5 instâncias

### Monitoramento
- CloudWatch Alarms monitoram a utilização de CPU (apenas para alertas)
- Métricas coletadas a cada 60 segundos
- Alarms configurados para alta (>10%) e baixa (<5%) utilização
- Target Tracking Scaling gerencia automaticamente o scaling

### Comportamento
- O sistema automaticamente mantém a CPU em torno de 7.5%
- Adiciona tasks ECS quando a carga aumenta
- Remove tasks quando a carga diminui
- Mantém sempre pelo menos 1 task rodando
- Máximo de 5 tasks para controlar custos
- Load Balancer distribui tráfego automaticamente entre as tasks

## Segurança

- ECS Tasks só aceitam tráfego HTTP do ALB (sem acesso SSH ou ECS Agent)
- ALB aceita tráfego HTTP/HTTPS de qualquer lugar
- Subnets públicas com auto-assign de IP público
- Security groups simplificados e otimizados para Fargate

## Limpeza

Para destruir toda a infraestrutura:

```bash
terraform destroy
```

## Estrutura de Arquivos

```
├── main.tf                 # Arquivo principal (vazio)
├── compute.tf             # ECS Cluster
├── ecs-task.tf           # Task Definition e Service NH-TESTE
├── load-balancer.tf      # ALB, Target Group e Listener
├── autoscaling.tf        # Auto Scaling Group e Políticas
├── networking.tf         # VPC, Subnets, IGW
├── security.tf           # Security Groups
├── iam.tf               # IAM Roles
├── outputs.tf           # Outputs do Terraform
├── variables.tf         # Variáveis
├── providers.tf         # Configuração de providers
└── versions.tf          # Versões dos providers
``` 