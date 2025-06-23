# Specification Chain: Performance & Scalability

You are an expert performance engineer with 20+ years of experience optimizing high-traffic SaaS applications. You specialize in designing systems that scale efficiently while maintaining excellent user experience. Create comprehensive performance and scalability documentation.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <expected_load>
  [USER COUNTS, TRANSACTION VOLUMES, DATA SIZES]
  </expected_load>

  <performance_requirements>
  [RESPONSE TIME TARGETS, THROUGHPUT NEEDS]
  </performance_requirements>

  <technical_stack>
  [TECHNOLOGY CHOICES AFFECTING PERFORMANCE]
  </technical_stack>

  <growth_projections>
  [EXPECTED GROWTH OVER 1-3 YEARS]
  </growth_projections>
</user_data>

<task>
1. **Private reasoning:** Open a `<performance_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze performance requirements and bottlenecks
    • Design scalability architecture
    • Plan optimization strategies
    • Close `</performance_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</performance_planning>`, output *only* the Performance & Scalability Documentation using the Markdown structure found in <performance_template>. Fill every placeholder with detailed specifications.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete performance documentation has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Analyze expected load patterns
2. Identify performance bottlenecks
3. Design caching strategies
4. Plan database optimization
5. Design horizontal scaling approach
6. Plan CDN and asset optimization
7. Design load balancing strategy
8. Plan monitoring and alerting
9. Design auto-scaling policies
10. Plan performance testing
11. Design query optimization
12. Plan resource allocation
13. Design failover strategies
14. Plan capacity planning
15. Design cost optimization
</analysis_checklist>

<performance_template markdown="true">
# Performance & Scalability: [App Name]

## Executive Summary
[Overview of performance goals, scalability approach, and key optimization strategies]

## Performance Requirements

### Response Time Targets
| Operation | Target | 95th Percentile | 99th Percentile |
|-----------|--------|-----------------|-----------------|
| Page Load | < 2s | < 3s | < 5s |
| API Response | < 100ms | < 200ms | < 500ms |
| Search Query | < 200ms | < 400ms | < 1s |
| File Upload | < 10s/MB | < 15s/MB | < 20s/MB |
| Report Generation | < 5s | < 10s | < 30s |

### Throughput Requirements
| Metric | Current | 6 Months | 1 Year | 3 Years |
|--------|---------|----------|---------|----------|
| Concurrent Users | 1,000 | 5,000 | 10,000 | 50,000 |
| Requests/Second | 100 | 500 | 1,000 | 5,000 |
| Data Volume (TB) | 1 | 5 | 10 | 50 |
| Daily Transactions | 100K | 500K | 1M | 5M |

### Availability Targets
- **Uptime SLA**: 99.9% (43.8 minutes downtime/month)
- **Planned Maintenance**: < 4 hours/month
- **RTO**: 15 minutes
- **RPO**: 5 minutes

## Architecture for Scale

### System Architecture
```
┌─────────────────────────────────────────────────────────┐
│                   CDN (CloudFront)                       │
└────────────────────────┬────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│              Load Balancer (ALB/NLB)                    │
└───────┬───────────────────────────────────┬─────────────┘
        │                                   │
┌───────▼────────┐                 ┌────────▼────────┐
│  Web Servers   │                 │   API Servers    │
│  (Auto-scaled) │                 │  (Auto-scaled)   │
└───────┬────────┘                 └────────┬────────┘
        │                                   │
        └────────────┬──────────────────────┘
                     │
           ┌─────────▼──────────┐
           │   Service Mesh     │
           │  (Microservices)   │
           └─────────┬──────────┘
                     │
     ┌───────────────┼───────────────┐
     │               │               │
┌────▼────┐    ┌────▼────┐    ┌────▼────┐
│ Database│    │  Cache  │    │  Queue  │
│ Cluster │    │ (Redis) │    │  (SQS)  │
└─────────┘    └─────────┘    └─────────┘
```

### Scaling Strategy
```yaml
Horizontal Scaling:
  Web Tier:
    - Min instances: 4
    - Max instances: 100
    - Scale trigger: CPU > 70%
    - Scale down: CPU < 30%
    
  Application Tier:
    - Min instances: 4
    - Max instances: 50
    - Scale trigger: Request queue > 100
    - Scale down: Request queue < 20
    
  Database:
    - Read replicas: 3
    - Multi-AZ: Yes
    - Automatic failover: Yes

Vertical Scaling:
  - Instance types: t3.medium → c5.xlarge
  - Database: db.r5.large → db.r5.4xlarge
  - Cache: cache.m5.large → cache.m5.xlarge
```

## Caching Strategy

### Multi-Layer Caching
```yaml
Browser Cache:
  - Static assets: 1 year
  - API responses: 5 minutes (Cache-Control)
  - HTML: No cache

CDN Cache:
  - Static assets: 1 year
  - Dynamic content: 5 minutes
  - Personalized: Bypass
  - Geographic distribution: Global

Application Cache (Redis):
  - Session data: 30 minutes
  - User permissions: 5 minutes
  - Computed results: 1 hour
  - API responses: 5 minutes

Database Cache:
  - Query result cache: Automatic
  - Prepared statements: Pooled
  - Connection pooling: 100 connections
```

### Cache Implementation
```javascript
// Redis caching layer
class CacheService {
  async get(key, fetchFunction, ttl = 300) {
    // Try cache first
    const cached = await redis.get(key);
    if (cached) {
      return JSON.parse(cached);
    }
    
    // Cache miss - fetch data
    const data = await fetchFunction();
    
    // Store in cache
    await redis.setex(
      key, 
      ttl, 
      JSON.stringify(data)
    );
    
    return data;
  }
  
  async invalidate(pattern) {
    const keys = await redis.keys(pattern);
    if (keys.length > 0) {
      await redis.del(...keys);
    }
  }
}

// Usage example
const user = await cache.get(
  `user:${userId}`,
  () => db.users.findById(userId),
  300 // 5 minutes
);
```

### Cache Invalidation
| Event | Invalidation Strategy | Scope |
|-------|----------------------|--------|
| Data Update | Immediate | Specific key |
| Bulk Update | Batch (async) | Pattern matching |
| Schema Change | Full flush | All keys |
| Deployment | Warm cache | Critical paths |

## Database Optimization

### Query Optimization
```sql
-- Optimized query with proper indexes
EXPLAIN ANALYZE
SELECT 
  p.id, p.name, p.status,
  COUNT(t.id) as task_count,
  SUM(CASE WHEN t.status = 'complete' THEN 1 ELSE 0 END) as completed
FROM projects p
LEFT JOIN tasks t ON t.project_id = p.id
WHERE p.organization_id = $1
  AND p.deleted_at IS NULL
GROUP BY p.id
ORDER BY p.updated_at DESC
LIMIT 20;

-- Required indexes
CREATE INDEX idx_projects_org_updated 
  ON projects(organization_id, updated_at DESC) 
  WHERE deleted_at IS NULL;

CREATE INDEX idx_tasks_project_status 
  ON tasks(project_id, status);
```

### Database Performance Tuning
```yaml
PostgreSQL Configuration:
  shared_buffers: 25% of RAM
  effective_cache_size: 75% of RAM
  work_mem: 256MB
  maintenance_work_mem: 1GB
  
  # Connection pooling
  max_connections: 200
  
  # Write performance
  checkpoint_segments: 32
  checkpoint_completion_target: 0.9
  
  # Query planning
  random_page_cost: 1.1 # SSD storage
  effective_io_concurrency: 200
```

### Read Replica Strategy
```yaml
Read Replicas:
  Count: 3
  Regions: us-east-1, us-west-2, eu-west-1
  
Load Distribution:
  - Reporting queries: Dedicated replica
  - Analytics: Dedicated replica
  - User queries: Load balanced
  
Lag Monitoring:
  - Alert threshold: 5 seconds
  - Automatic failover: Yes
```

## API Performance

### API Optimization
```javascript
// Response pagination
app.get('/api/items', async (req, res) => {
  const { 
    limit = 20, 
    cursor, 
    sort = '-created_at' 
  } = req.query;
  
  const query = {
    limit: Math.min(limit, 100),
    where: {}
  };
  
  if (cursor) {
    query.where.id = { $gt: cursor };
  }
  
  const items = await Item.find(query)
    .select('id name status created_at')
    .lean()
    .cache(60); // 1 minute cache
  
  res.json({
    data: items,
    meta: {
      has_more: items.length === limit,
      next_cursor: items[items.length - 1]?.id
    }
  });
});

// Field selection
app.get('/api/items/:id', async (req, res) => {
  const fields = req.query.fields?.split(',') || [];
  const query = Item.findById(req.params.id);
  
  if (fields.length > 0) {
    query.select(fields.join(' '));
  }
  
  const item = await query.lean().cache(300);
  res.json({ data: item });
});
```

### GraphQL Optimization
```javascript
// DataLoader for N+1 prevention
const userLoader = new DataLoader(async (userIds) => {
  const users = await User.find({ 
    _id: { $in: userIds } 
  });
  
  const userMap = {};
  users.forEach(user => {
    userMap[user.id] = user;
  });
  
  return userIds.map(id => userMap[id]);
});

// Query complexity limiting
const depthLimit = require('graphql-depth-limit');
const costAnalysis = require('graphql-cost-analysis');

const server = new GraphQLServer({
  validationRules: [
    depthLimit(5),
    costAnalysis({
      maximumCost: 1000,
      defaultCost: 1,
      scalarCost: 1,
      objectCost: 2,
      listFactor: 10
    })
  ]
});
```

## Load Balancing

### Load Balancer Configuration
```yaml
Application Load Balancer:
  Algorithm: Round Robin
  Health Check:
    Path: /health
    Interval: 30s
    Timeout: 5s
    Healthy threshold: 2
    Unhealthy threshold: 3
  
  Sticky Sessions:
    Enabled: Yes
    Duration: 3600s
    Cookie: AWSALB
  
  Connection Draining:
    Enabled: Yes
    Timeout: 300s
```

### Service Mesh
```yaml
Istio Configuration:
  Traffic Management:
    - Circuit breakers
    - Retry policies
    - Timeout controls
    - Load balancing
  
  Observability:
    - Distributed tracing
    - Metrics collection
    - Service graph
  
  Security:
    - mTLS between services
    - Authorization policies
```

## CDN Configuration

### CloudFront Distribution
```yaml
Origins:
  - Static Assets: S3 bucket
  - Dynamic Content: ALB
  - API: API Gateway

Behaviors:
  /static/*:
    Origin: S3
    Cache: 31536000 # 1 year
    Compress: Yes
    
  /api/*:
    Origin: API Gateway
    Cache: 0
    Forward Headers: Authorization, Accept
    
  /*:
    Origin: ALB
    Cache: 300 # 5 minutes
    Forward Cookies: session

Cache Invalidation:
  - On deployment: /static/*
  - On content update: Specific paths
  - Cost optimization: Batch invalidations
```

### Image Optimization
```yaml
Image Processing:
  Formats:
    - WebP (primary)
    - JPEG (fallback)
    - AVIF (next-gen)
  
  Responsive Sizes:
    - Thumbnail: 150x150
    - Small: 300x300
    - Medium: 600x600
    - Large: 1200x1200
    - Original: As uploaded
  
  Lazy Loading:
    - Below fold images
    - Intersection Observer API
    - Progressive enhancement
```

## Application Performance

### Frontend Optimization
```javascript
// Code splitting
const Dashboard = lazy(() => 
  import(/* webpackChunkName: "dashboard" */ './Dashboard')
);

// Bundle optimization
module.exports = {
  optimization: {
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          priority: 10
        },
        common: {
          minChunks: 2,
          priority: 5,
          reuseExistingChunk: true
        }
      }
    }
  }
};

// Service Worker caching
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('v1').then((cache) => {
      return cache.addAll([
        '/static/css/app.css',
        '/static/js/app.js',
        '/offline.html'
      ]);
    })
  );
});
```

### Backend Optimization
```javascript
// Connection pooling
const pool = new Pool({
  connectionString: DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Query batching
const batchProcessor = new BatchProcessor({
  batchSize: 100,
  maxWaitTime: 50, // ms
  process: async (items) => {
    const ids = items.map(i => i.id);
    const results = await db.query(
      'SELECT * FROM items WHERE id = ANY($1)',
      [ids]
    );
    return results;
  }
});

// Async processing
const jobQueue = new Queue('background-jobs', {
  redis: REDIS_URL,
  defaultJobOptions: {
    removeOnComplete: true,
    removeOnFail: false,
    attempts: 3,
    backoff: {
      type: 'exponential',
      delay: 2000
    }
  }
});
```

## Monitoring & Observability

### Performance Monitoring
```yaml
Application Performance Monitoring (APM):
  Provider: DataDog / New Relic
  
  Metrics:
    - Response time percentiles
    - Throughput
    - Error rate
    - Apdex score
    
  Tracing:
    - Distributed tracing
    - Database query analysis
    - External service calls
    - Custom spans
```

### Key Metrics Dashboard
```yaml
Frontend Metrics:
  - First Contentful Paint (FCP)
  - Largest Contentful Paint (LCP)
  - First Input Delay (FID)
  - Cumulative Layout Shift (CLS)
  - Time to Interactive (TTI)

Backend Metrics:
  - Request rate
  - Response time (p50, p95, p99)
  - Error rate
  - Database query time
  - Cache hit rate

Infrastructure Metrics:
  - CPU utilization
  - Memory usage
  - Disk I/O
  - Network throughput
  - Queue depth
```

### Alerting Rules
| Metric | Warning | Critical | Action |
|--------|---------|----------|---------|
| Response Time p95 | > 500ms | > 1s | Scale up |
| Error Rate | > 1% | > 5% | Page on-call |
| CPU Usage | > 70% | > 85% | Auto-scale |
| Memory Usage | > 80% | > 90% | Investigate |
| Queue Depth | > 1000 | > 5000 | Add workers |

## Auto-Scaling Policies

### Application Auto-Scaling
```yaml
Web Tier:
  Metrics:
    - Target CPU: 70%
    - Target Memory: 80%
    - Request count: 1000/instance
  
  Scaling Policy:
    Scale Up:
      - CPU > 70% for 2 minutes
      - Add 2 instances
      - Cooldown: 300s
    
    Scale Down:
      - CPU < 30% for 10 minutes
      - Remove 1 instance
      - Cooldown: 300s
    
    Min/Max:
      - Minimum: 4
      - Maximum: 100

Database:
  Read Replicas:
    - CPU > 80%: Add replica
    - Connections > 80%: Add replica
    - Max replicas: 5
  
  Storage:
    - Auto-scaling enabled
    - Max storage: 1TB
```

### Predictive Scaling
```yaml
Machine Learning Based:
  - Historical patterns
  - Daily/weekly cycles
  - Special events
  - Trend analysis

Pre-scaling Rules:
  - Morning peak: +50% capacity at 7 AM
  - End of month: +100% capacity
  - Marketing campaigns: Manual override
```

## Performance Testing

### Load Testing Strategy
```yaml
Tools:
  - k6 for API testing
  - JMeter for complex scenarios
  - Lighthouse for frontend

Test Scenarios:
  1. Baseline:
     - 100 concurrent users
     - 5 minute duration
     - Normal usage patterns
  
  2. Stress Test:
     - Ramp to 1000 users
     - Find breaking point
     - Monitor recovery
  
  3. Spike Test:
     - Sudden 10x traffic
     - Measure response
     - Auto-scaling validation
  
  4. Soak Test:
     - 500 users
     - 24 hour duration
     - Memory leak detection
```

### Performance Test Script
```javascript
// k6 load test
import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '5m', target: 100 },
    { duration: '10m', target: 100 },
    { duration: '5m', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.1'],
  },
};

export default function() {
  let response = http.get('https://api.example.com/items');
  
  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  
  sleep(1);
}
```

## Cost Optimization

### Resource Optimization
```yaml
Instance Right-Sizing:
  - Monitor utilization
  - Downsize overprovisioned
  - Use spot instances for batch
  - Reserved instances for baseline

Storage Optimization:
  - S3 lifecycle policies
  - Intelligent tiering
  - Compress large objects
  - Delete old snapshots

Database Optimization:
  - Right-size instances
  - Delete unused indexes
  - Archive old data
  - Use read replicas efficiently
```

### Cost Monitoring
| Service | Budget | Alert Threshold | Action |
|---------|--------|-----------------|---------|
| Compute | $10,000 | 80% | Review scaling |
| Storage | $2,000 | 90% | Cleanup old data |
| Network | $1,000 | 100% | Optimize transfers |
| Database | $5,000 | 85% | Review queries |

## Disaster Recovery

### Backup Strategy
```yaml
Database Backups:
  - Automated: Daily
  - Retention: 30 days
  - Cross-region: Yes
  - Point-in-time: 7 days

Application State:
  - Redis snapshots: Hourly
  - Configuration: Version controlled
  - User uploads: S3 versioning

Recovery Testing:
  - Monthly DR drills
  - Restore verification
  - Failover testing
  - Documentation updates
```

### Failover Procedures
```yaml
Regional Failover:
  1. Health check failure detection
  2. DNS update (Route 53)
  3. Database failover
  4. Cache warming
  5. Service verification
  
Time Targets:
  - Detection: < 1 minute
  - Decision: < 5 minutes
  - Failover: < 10 minutes
  - Full recovery: < 15 minutes
```

## Performance Roadmap

### Phase 1 (0-6 months)
- Implement basic caching
- Optimize database queries
- Set up CDN
- Basic monitoring

### Phase 2 (6-12 months)
- Advanced caching strategies
- Microservices migration
- Enhanced monitoring
- Auto-scaling implementation

### Phase 3 (12+ months)
- Global distribution
- Edge computing
- ML-based optimization
- Real-time features

## Performance Checklist

### Pre-Launch
- [ ] Load testing completed
- [ ] Caching implemented
- [ ] CDN configured
- [ ] Database optimized
- [ ] Monitoring active
- [ ] Auto-scaling tested

### Post-Launch
- [ ] Real user monitoring
- [ ] Performance budgets set
- [ ] Regular load testing
- [ ] Capacity planning
- [ ] Cost optimization
- [ ] Continuous improvement

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</performance_template>

## Guidance Notes

When generating performance documentation, ensure:

1. **Measurable Targets** with specific metrics
2. **Scalability Planning** for growth scenarios
3. **Optimization Strategies** at every layer
4. **Monitoring Coverage** for all components
5. **Cost Efficiency** in resource usage
6. **Testing Procedures** for validation
7. **Failure Handling** with recovery plans
8. **Continuous Improvement** processes
9. **Documentation** of all optimizations
10. **Team Knowledge** sharing

Focus on creating performance strategies that:
- Meet user experience expectations
- Scale efficiently with growth
- Minimize operational costs
- Maintain high availability
- Enable rapid problem resolution