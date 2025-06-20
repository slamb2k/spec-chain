# Specification Chain: DevOps & Deployment

You are an expert DevOps architect with 20+ years of experience designing and implementing CI/CD pipelines, infrastructure as code, and cloud-native deployments for enterprise SaaS applications. You specialize in creating reliable, automated deployment systems that enable rapid, safe releases. Create comprehensive DevOps documentation.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <technical_stack>
  [LANGUAGES, FRAMEWORKS, DATABASES]
  </technical_stack>

  <deployment_requirements>
  [ENVIRONMENTS, SCALE, UPTIME REQUIREMENTS]
  </deployment_requirements>

  <cloud_provider>
  [AWS, GCP, AZURE, OR HYBRID]
  </cloud_provider>

  <team_size>
  [DEVELOPMENT TEAM SIZE AND STRUCTURE]
  </team_size>
</user_data>

<task>
1. **Private reasoning:** Open a `<devops_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze deployment requirements and constraints
    • Design comprehensive CI/CD pipeline
    • Plan infrastructure automation
    • Close `</devops_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</devops_planning>`, output *only* the DevOps & Deployment Documentation using the Markdown structure found in <devops_template>. Fill every placeholder with detailed specifications.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete DevOps documentation has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Define deployment environments and requirements
2. Design CI/CD pipeline architecture
3. Plan infrastructure as code approach
4. Design container orchestration strategy
5. Plan monitoring and observability
6. Design backup and disaster recovery
7. Plan security automation
8. Design release management process
9. Plan configuration management
10. Design logging and audit trails
11. Plan cost optimization strategies
12. Design multi-region deployment
13. Plan rollback procedures
14. Design secrets management
15. Plan compliance automation
</analysis_checklist>

<devops_template markdown="true">
# DevOps & Deployment: [App Name]

## Executive Summary
[Overview of DevOps strategy, deployment approach, and key automation goals]

## Architecture Overview

### Deployment Architecture
```mermaid
flowchart TD
    Dev[Developer Workstation] -->|Git Push| Git[Source Control - Git]
    Git -->|Webhook| Pipeline[CI/CD Pipeline]
    
    subgraph Pipeline
        Build[Build] --> Test[Test]
        Test --> Package[Package]
        Package --> Deploy[Deploy]
    end
    
    Pipeline --> DevEnv[Development Environment]
    Pipeline --> StagingEnv[Staging Environment]
    Pipeline --> ProdEnv[Production Environment]
```

### Environment Strategy
| Environment | Purpose | Auto-Deploy | Approval | Retention |
|-------------|---------|-------------|----------|-----------|
| Development | Feature testing | Yes (main) | No | 7 days |
| Staging | Integration testing | Yes (main) | No | 14 days |
| UAT | User acceptance | Manual | Yes | 30 days |
| Production | Live system | Manual | Yes | Permanent |

## CI/CD Pipeline

### Pipeline Architecture
```yaml
# .github/workflows/main.yml (GitHub Actions example)
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  NODE_VERSION: '18'
  DOCKER_REGISTRY: 'registry.example.com'

jobs:
  # Code Quality Checks
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Lint code
        run: npm run lint
      
      - name: Type check
        run: npm run type-check
      
      - name: Security audit
        run: npm audit --production

  # Unit and Integration Tests
  test:
    runs-on: ubuntu-latest
    needs: quality
    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm test -- --coverage
        env:
          DATABASE_URL: postgres://postgres:postgres@localhost:5432/test
          REDIS_URL: redis://localhost:6379
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          token: ${{ secrets.CODECOV_TOKEN }}

  # Build and Package
  build:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to Registry
        uses: docker/login-action@v2
        with:
          registry: ${{ env.DOCKER_REGISTRY }}
          username: ${{ secrets.REGISTRY_USERNAME }}
          password: ${{ secrets.REGISTRY_PASSWORD }}
      
      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: |
            ${{ env.DOCKER_REGISTRY }}/app:${{ github.sha }}
            ${{ env.DOCKER_REGISTRY }}/app:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max
      
      - name: Generate SBOM
        uses: anchore/sbom-action@v0
        with:
          image: ${{ env.DOCKER_REGISTRY }}/app:${{ github.sha }}

  # Security Scanning
  security:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ${{ env.DOCKER_REGISTRY }}/app:${{ github.sha }}
          format: 'sarif'
          output: 'trivy-results.sarif'
      
      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  # Deploy to Development
  deploy-dev:
    runs-on: ubuntu-latest
    needs: security
    if: github.ref == 'refs/heads/develop'
    steps:
      - name: Deploy to Development
        uses: ./.github/actions/deploy
        with:
          environment: development
          image: ${{ env.DOCKER_REGISTRY }}/app:${{ github.sha }}
          kubeconfig: ${{ secrets.DEV_KUBECONFIG }}

  # Deploy to Staging
  deploy-staging:
    runs-on: ubuntu-latest
    needs: security
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to Staging
        uses: ./.github/actions/deploy
        with:
          environment: staging
          image: ${{ env.DOCKER_REGISTRY }}/app:${{ github.sha }}
          kubeconfig: ${{ secrets.STAGING_KUBECONFIG }}

  # Deploy to Production (Manual Approval)
  deploy-prod:
    runs-on: ubuntu-latest
    needs: deploy-staging
    if: github.ref == 'refs/heads/main'
    environment:
      name: production
      url: https://app.example.com
    steps:
      - name: Deploy to Production
        uses: ./.github/actions/deploy
        with:
          environment: production
          image: ${{ env.DOCKER_REGISTRY }}/app:${{ github.sha }}
          kubeconfig: ${{ secrets.PROD_KUBECONFIG }}
```

### Build Process
```dockerfile
# Multi-stage Dockerfile
FROM node:18-alpine AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine AS runtime
WORKDIR /app

# Security: Run as non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copy production dependencies
COPY --from=dependencies --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy built application
COPY --from=build --chown=nodejs:nodejs /app/dist ./dist
COPY --from=build --chown=nodejs:nodejs /app/package*.json ./

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
  CMD node healthcheck.js

USER nodejs
EXPOSE 3000

CMD ["node", "dist/server.js"]
```

## Infrastructure as Code

### Terraform Configuration
```hcl
# infrastructure/main.tf
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
  
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "app/terraform.tfstate"
    region = "us-east-1"
    
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

# VPC Configuration
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "${var.app_name}-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true
  
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

# EKS Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  
  cluster_name    = "${var.app_name}-cluster"
  cluster_version = "1.28"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  eks_managed_node_groups = {
    main = {
      min_size     = 2
      max_size     = 10
      desired_size = 3
      
      instance_types = ["t3.medium"]
      
      k8s_labels = {
        Environment = var.environment
      }
    }
  }
}

# RDS Database
module "rds" {
  source = "terraform-aws-modules/rds/aws"
  
  identifier = "${var.app_name}-db"
  
  engine            = "postgres"
  engine_version    = "14"
  instance_class    = "db.r6g.large"
  allocated_storage = 100
  
  db_name  = var.app_name
  username = "dbadmin"
  port     = "5432"
  
  vpc_security_group_ids = [module.security_group.security_group_id]
  
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  
  backup_retention_period = 30
  
  enabled_cloudwatch_logs_exports = ["postgresql"]
  
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets
  
  deletion_protection = true
}
```

### Kubernetes Manifests
```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
  labels:
    app: app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app
  template:
    metadata:
      labels:
        app: app
    spec:
      serviceAccountName: app
      containers:
      - name: app
        image: registry.example.com/app:latest
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: database-url
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                - key: app
                  operator: In
                  values:
                  - app
              topologyKey: kubernetes.io/hostname

---
apiVersion: v1
kind: Service
metadata:
  name: app
spec:
  selector:
    app: app
  ports:
  - port: 80
    targetPort: 3000
  type: ClusterIP

---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: app
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: app
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

## Configuration Management

### Environment Configuration
```yaml
# config/environments.yaml
base:
  app:
    name: "BraveNewProjects"
    version: "${VERSION}"
  
  server:
    port: 3000
    timeout: 30000
  
  database:
    pool_size: 20
    timeout: 5000
  
  redis:
    ttl: 3600
  
  logging:
    level: "info"
    format: "json"

development:
  extends: base
  server:
    debug: true
  logging:
    level: "debug"
  database:
    host: "localhost"
    name: "app_dev"

staging:
  extends: base
  database:
    host: "${DB_HOST}"
    name: "app_staging"
  redis:
    cluster: true

production:
  extends: base
  server:
    cluster: true
    workers: 4
  database:
    host: "${DB_HOST}"
    name: "app_prod"
    ssl: true
  redis:
    cluster: true
    sentinel: true
```

### Secrets Management
```yaml
# Using Kubernetes Secrets with Sealed Secrets
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: app-secrets
  namespace: default
spec:
  encryptedData:
    database-url: AgBv3K9... # Encrypted value
    api-key: AgCx4L8... # Encrypted value
    jwt-secret: AgDy5M7... # Encrypted value
```

### Feature Flags
```javascript
// Feature flag configuration
const features = {
  newDashboard: {
    enabled: process.env.FEATURE_NEW_DASHBOARD === 'true',
    rollout: 100, // Percentage
    users: [] // Specific users
  },
  advancedReporting: {
    enabled: false,
    rollout: 0,
    users: ['beta@example.com']
  }
};

// Usage
if (isFeatureEnabled('newDashboard', user)) {
  // New dashboard code
}
```

## Monitoring & Observability

### Monitoring Stack
```yaml
# Prometheus configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
    
    scrape_configs:
    - job_name: 'kubernetes-pods'
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: true
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
        action: replace
        target_label: __metrics_path__
        regex: (.+)
    
    - job_name: 'node-exporter'
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - source_labels: [__address__]
        regex: '(.*):10250'
        replacement: '${1}:9100'
        target_label: __address__
```

### Logging Architecture
```yaml
# Fluentd configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
data:
  fluent.conf: |
    <source>
      @type tail
      path /var/log/containers/*.log
      pos_file /var/log/fluentd-containers.log.pos
      tag kubernetes.*
      read_from_head true
      <parse>
        @type json
        time_format %Y-%m-%dT%H:%M:%S.%NZ
      </parse>
    </source>
    
    <filter kubernetes.**>
      @type kubernetes_metadata
    </filter>
    
    <match **>
      @type elasticsearch
      host elasticsearch.logging.svc.cluster.local
      port 9200
      logstash_format true
      logstash_prefix k8s
      <buffer>
        @type file
        path /var/log/fluentd-buffers/kubernetes.system.buffer
        flush_mode interval
        retry_type exponential_backoff
        flush_interval 5s
        retry_forever false
        retry_max_interval 30
        chunk_limit_size 2M
        queue_limit_length 8
        overflow_action block
      </buffer>
    </match>
```

### Distributed Tracing
```javascript
// OpenTelemetry setup
const { NodeTracerProvider } = require('@opentelemetry/sdk-trace-node');
const { registerInstrumentations } = require('@opentelemetry/instrumentation');
const { HttpInstrumentation } = require('@opentelemetry/instrumentation-http');
const { ExpressInstrumentation } = require('@opentelemetry/instrumentation-express');

const provider = new NodeTracerProvider({
  resource: new Resource({
    [SemanticResourceAttributes.SERVICE_NAME]: 'app-api',
    [SemanticResourceAttributes.SERVICE_VERSION]: process.env.VERSION,
  }),
});

provider.register();

registerInstrumentations({
  instrumentations: [
    new HttpInstrumentation(),
    new ExpressInstrumentation(),
  ],
});
```

## Release Management

### Release Process
```yaml
Release Workflow:
  1. Feature Development:
     - Create feature branch
     - Implement changes
     - Write tests
     - Submit PR
  
  2. Code Review:
     - Automated checks
     - Peer review
     - Approval required
  
  3. Staging Deployment:
     - Automatic on merge
     - Smoke tests
     - Performance tests
  
  4. Production Release:
     - Create release tag
     - Generate changelog
     - Manual approval
     - Gradual rollout
  
  5. Post-Release:
     - Monitor metrics
     - Check error rates
     - User feedback
```

### Blue-Green Deployment
```yaml
# Kubernetes blue-green deployment
apiVersion: v1
kind: Service
metadata:
  name: app
spec:
  selector:
    app: app
    version: green  # Switch between blue/green
  ports:
  - port: 80
    targetPort: 3000

---
# Blue deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app
      version: blue
  template:
    metadata:
      labels:
        app: app
        version: blue
    spec:
      containers:
      - name: app
        image: registry.example.com/app:v1.0.0

---
# Green deployment (new version)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app
      version: green
  template:
    metadata:
      labels:
        app: app
        version: green
    spec:
      containers:
      - name: app
        image: registry.example.com/app:v1.1.0
```

### Canary Deployment
```yaml
# Istio canary deployment
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: app
spec:
  hosts:
  - app
  http:
  - match:
    - headers:
        canary:
          exact: "true"
    route:
    - destination:
        host: app
        subset: v2
      weight: 100
  - route:
    - destination:
        host: app
        subset: v1
      weight: 90
    - destination:
        host: app
        subset: v2
      weight: 10  # 10% canary traffic
```

## Backup & Disaster Recovery

### Backup Strategy
```yaml
# Velero backup configuration
apiVersion: velero.io/v1
kind: Schedule
metadata:
  name: daily-backup
spec:
  schedule: "0 2 * * *"  # 2 AM daily
  template:
    hooks:
      resources:
      - name: database-backup
        includedNamespaces:
        - default
        labelSelector:
          matchLabels:
            app: database
        pre:
        - exec:
            container: postgres
            command:
            - /bin/bash
            - -c
            - pg_dump -U $POSTGRES_USER $POSTGRES_DB > /backup/dump.sql
    includedNamespaces:
    - default
    - app
    ttl: 720h  # 30 days retention
    storageLocation: s3-backup
```

### Disaster Recovery Procedures
```markdown
## DR Runbook

### Detection (RTO: 5 minutes)
1. Automated monitoring alerts
2. Manual verification
3. Incident declaration

### Assessment (RTO: 10 minutes)
1. Determine scope of failure
2. Identify recovery strategy
3. Notify stakeholders

### Recovery (RTO: 30 minutes)
1. **Region Failure**:
   ```bash
   # Failover to DR region
   kubectl config use-context dr-cluster
   ./scripts/failover.sh --region us-west-2
   ```

2. **Database Recovery**:
   ```bash
   # Restore from backup
   ./scripts/restore-db.sh --timestamp "2024-01-20 00:00:00"
   ```

3. **DNS Update**:
   ```bash
   # Update Route53
   aws route53 change-resource-record-sets \
     --hosted-zone-id Z123456 \
     --change-batch file://dns-failover.json
   ```

### Validation (RTO: 45 minutes)
1. Health checks
2. Smoke tests
3. User verification
```

## Security Automation

### Security Scanning Pipeline
```yaml
# Security checks in CI/CD
security-scan:
  stage: security
  script:
    # SAST - Static Application Security Testing
    - sonarqube-scanner
      -Dsonar.projectKey=$CI_PROJECT_NAME
      -Dsonar.sources=.
      -Dsonar.host.url=$SONAR_HOST_URL
      -Dsonar.login=$SONAR_TOKEN
    
    # Dependency scanning
    - snyk test --severity-threshold=high
    - snyk monitor
    
    # Container scanning
    - trivy image --exit-code 1 --severity HIGH,CRITICAL $IMAGE_NAME
    
    # License compliance
    - license-checker --production --failOn "GPL"
    
    # Secrets scanning
    - trufflehog --regex --entropy=True .
```

### Infrastructure Security
```hcl
# AWS Security Group
resource "aws_security_group" "app" {
  name_prefix = "${var.app_name}-"
  vpc_id      = module.vpc.vpc_id
  
  # Ingress rules
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from anywhere"
  }
  
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    description     = "App port from ALB"
  }
  
  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}
```

## Cost Optimization

### Resource Tagging Strategy
```hcl
# Consistent tagging for cost allocation
locals {
  common_tags = {
    Application = var.app_name
    Environment = var.environment
    Team        = var.team
    CostCenter  = var.cost_center
    Terraform   = "true"
    CreatedAt   = timestamp()
  }
}

# Auto-shutdown for non-production
resource "aws_autoscaling_schedule" "shutdown" {
  count                  = var.environment != "production" ? 1 : 0
  scheduled_action_name  = "shutdown"
  autoscaling_group_name = aws_autoscaling_group.app.name
  
  min_size         = 0
  max_size         = 0
  desired_capacity = 0
  
  recurrence = "0 20 * * MON-FRI"  # 8 PM weekdays
}

resource "aws_autoscaling_schedule" "startup" {
  count                  = var.environment != "production" ? 1 : 0
  scheduled_action_name  = "startup"
  autoscaling_group_name = aws_autoscaling_group.app.name
  
  min_size         = 2
  max_size         = 4
  desired_capacity = 2
  
  recurrence = "0 8 * * MON-FRI"  # 8 AM weekdays
}
```

### Cost Monitoring
```yaml
# AWS Cost Anomaly Detection
resource "aws_ce_anomaly_monitor" "app" {
  name              = "${var.app_name}-cost-monitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
  
  monitor_specification = jsonencode({
    Tags = {
      Key    = "Application"
      Values = [var.app_name]
    }
  })
}

resource "aws_ce_anomaly_subscription" "app" {
  name      = "${var.app_name}-cost-alerts"
  threshold = 100  # Alert if anomaly > $100
  frequency = "DAILY"
  
  monitor_arn_list = [
    aws_ce_anomaly_monitor.app.arn
  ]
  
  subscriber {
    type    = "EMAIL"
    address = "devops@example.com"
  }
}
```

## Development Workflow

### Local Development Setup
```bash
#!/bin/bash
# scripts/dev-setup.sh

echo "Setting up local development environment..."

# Check prerequisites
command -v docker >/dev/null 2>&1 || { echo "Docker required"; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo "kubectl required"; exit 1; }
command -v skaffold >/dev/null 2>&1 || { echo "skaffold required"; exit 1; }

# Start local Kubernetes
echo "Starting local Kubernetes cluster..."
kind create cluster --name dev-cluster --config kind-config.yaml

# Install required operators
echo "Installing operators..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Setup local registry
docker run -d -p 5000:5000 --name registry registry:2

# Configure skaffold
echo "Configuring Skaffold..."
skaffold config set local-cluster true

# Install dependencies
echo "Installing application dependencies..."
npm install

# Setup environment
cp .env.example .env.local
echo "Please update .env.local with your configuration"

echo "Development environment ready!"
echo "Run 'skaffold dev' to start development"
```

### Skaffold Configuration
```yaml
# skaffold.yaml
apiVersion: skaffold/v4beta1
kind: Config
metadata:
  name: app
build:
  artifacts:
  - image: app
    docker:
      dockerfile: Dockerfile.dev
    sync:
      manual:
      - src: "src/**/*.js"
        dest: /app
deploy:
  kubectl:
    manifests:
    - k8s/dev/*.yaml
portForward:
- resourceType: deployment
  resourceName: app
  namespace: default
  port: 3000
  localPort: 3000
profiles:
- name: production
  build:
    artifacts:
    - image: registry.example.com/app
      docker:
        dockerfile: Dockerfile
  deploy:
    kubectl:
      manifests:
      - k8s/prod/*.yaml
```

## Documentation

### Runbook Template
```markdown
# Service: [Service Name]

## Overview
- **Purpose**: [What this service does]
- **Owner**: [Team/Person]
- **SLA**: [Uptime requirements]
- **Dependencies**: [List of dependencies]

## Architecture
[Diagram and description]

## Common Operations

### Deployment
```bash
# Deploy to staging
./deploy.sh staging v1.2.3

# Deploy to production
./deploy.sh production v1.2.3 --approve
```

### Scaling
```bash
# Scale up
kubectl scale deployment app --replicas=10

# Scale down
kubectl scale deployment app --replicas=3
```

### Troubleshooting

#### High Memory Usage
1. Check metrics: `kubectl top pods`
2. Review logs: `kubectl logs -l app=app --tail=100`
3. Take heap dump if needed
4. Scale horizontally if necessary

#### Database Connection Issues
1. Check connection pool: `kubectl exec app-xxx -- node scripts/check-db.js`
2. Verify credentials: `kubectl get secret app-secrets -o yaml`
3. Check network policies
4. Restart if necessary

## Monitoring

### Key Metrics
- **Response Time**: < 200ms p95
- **Error Rate**: < 0.1%
- **CPU Usage**: < 70%
- **Memory Usage**: < 80%

### Dashboards
- [Grafana Dashboard](https://grafana.example.com/d/abc123)
- [APM Dashboard](https://apm.example.com/app)

### Alerts
| Alert | Threshold | Action |
|-------|-----------|---------|
| High Error Rate | > 1% for 5 min | Page on-call |
| High Latency | > 500ms p95 | Investigate |
| Pod Crash | > 3 restarts | Page on-call |
```

## Compliance & Audit

### Audit Logging
```yaml
# Kubernetes audit policy
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  # Log pod creation at Metadata level
  - level: Metadata
    omitStages:
    - RequestReceived
    resources:
    - group: ""
      resources: ["pods"]
    namespaces: ["default", "app"]
  
  # Log secret access at RequestResponse level
  - level: RequestResponse
    omitStages:
    - RequestReceived
    resources:
    - group: ""
      resources: ["secrets", "configmaps"]
  
  # Log everything else at Metadata level
  - level: Metadata
    omitStages:
    - RequestReceived
```

### Compliance Automation
```yaml
# OPA (Open Policy Agent) policies
package kubernetes.admission

deny[msg] {
  input.request.kind.kind == "Pod"
  input.request.object.spec.containers[_].image
  not starts_with(input.request.object.spec.containers[_].image, "registry.example.com/")
  msg := "Images must be from approved registry"
}

deny[msg] {
  input.request.kind.kind == "Pod"
  not input.request.object.spec.securityContext.runAsNonRoot
  msg := "Pods must run as non-root user"
}
```

## DevOps Metrics

### Key Performance Indicators
| Metric | Target | Current | Trend |
|--------|--------|---------|--------|
| Deployment Frequency | Daily | 3/day | ↑ |
| Lead Time | < 1 hour | 45 min | ↓ |
| MTTR | < 30 min | 25 min | ↓ |
| Change Failure Rate | < 5% | 3% | ↓ |
| Test Coverage | > 80% | 85% | ↑ |
| Build Success Rate | > 95% | 97% | → |

### Continuous Improvement
1. **Weekly Reviews**: Analyze metrics and incidents
2. **Monthly Retrospectives**: Process improvements
3. **Quarterly Planning**: Infrastructure upgrades
4. **Annual Assessment**: Tool and platform evaluation

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</devops_template>

## Guidance Notes

When generating DevOps documentation, ensure:

1. **Automation First** approach for all processes
2. **Security Integration** throughout the pipeline
3. **Scalability** in infrastructure design
4. **Reliability** through redundancy and monitoring
5. **Cost Efficiency** with resource optimization
6. **Documentation** for all procedures
7. **Testing** at every stage
8. **Monitoring** for proactive issue detection
9. **Compliance** with regulatory requirements
10. **Continuous Improvement** culture

Focus on creating DevOps practices that:
- Enable rapid, safe deployments
- Maintain high availability
- Optimize resource usage
- Provide clear visibility
- Support team productivity