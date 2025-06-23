# Specification Chain: Testing Strategy

You are an expert QA architect with 20+ years of experience designing comprehensive testing strategies for enterprise SaaS applications. You specialize in creating test plans that ensure quality, reliability, and maintainability while enabling rapid development. Create thorough testing documentation.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <technical_stack>
  [FRONTEND AND BACKEND TECHNOLOGIES]
  </technical_stack>

  <features>
  [KEY FEATURES REQUIRING TESTING]
  </features>

  <quality_requirements>
  [PERFORMANCE, SECURITY, ACCESSIBILITY STANDARDS]
  </quality_requirements>

  <team_structure>
  [DEVELOPMENT TEAM SIZE AND ROLES]
  </team_structure>
</user_data>

<task>
1. **Private reasoning:** Open a `<testing_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze testing requirements across all levels
    • Design comprehensive test strategies
    • Plan automation and CI/CD integration
    • Close `</testing_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</testing_planning>`, output *only* the Testing Strategy Documentation using the Markdown structure found in <testing_template>. Fill every placeholder with detailed specifications.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete testing documentation has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Define testing objectives and success criteria
2. Plan unit testing approach
3. Design integration testing strategy
4. Plan end-to-end testing scenarios
5. Design performance testing approach
6. Plan security testing requirements
7. Design accessibility testing
8. Plan mobile/cross-browser testing
9. Design API testing strategy
10. Plan test data management
11. Design test automation framework
12. Plan CI/CD integration
13. Design test reporting and metrics
14. Plan regression testing approach
15. Design user acceptance testing
</analysis_checklist>

<testing_template markdown="true">
# Testing Strategy: [App Name]

## Executive Summary
[Overview of testing approach, quality goals, and key strategies for ensuring application reliability]

## Testing Objectives

### Primary Goals
1. **Quality Assurance**: Ensure all features work as specified
2. **Reliability**: Verify system stability under various conditions
3. **Performance**: Validate response times and throughput
4. **Security**: Confirm protection against vulnerabilities
5. **Usability**: Ensure excellent user experience

### Success Criteria
- Code coverage: > 80%
- Automated test execution: > 90%
- Defect escape rate: < 5%
- Test execution time: < 30 minutes
- Critical bug count: 0 in production

## Testing Pyramid

```
        ┌─────────────┐
        │   Manual    │ 5%
        │   Testing   │
        ├─────────────┤
        │     E2E     │ 10%
        │    Tests    │
        ├─────────────┤
        │ Integration │ 25%
        │    Tests    │
        ├─────────────┤
        │    Unit     │ 60%
        │   Tests     │
        └─────────────┘
```

## Unit Testing

### Frontend Unit Tests

#### Testing Framework
```javascript
// Jest configuration
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts'],
  collectCoverageFrom: [
    'src/**/*.{ts,tsx}',
    '!src/**/*.d.ts',
    '!src/index.tsx',
    '!src/serviceWorker.ts'
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  }
};
```

#### Component Testing Example
```typescript
// Button.test.tsx
import { render, fireEvent, screen } from '@testing-library/react';
import { Button } from './Button';

describe('Button Component', () => {
  it('renders with correct text', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('handles click events', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    
    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('applies disabled state correctly', () => {
    render(<Button disabled>Click me</Button>);
    expect(screen.getByText('Click me')).toBeDisabled();
  });

  it('shows loading state', () => {
    render(<Button loading>Click me</Button>);
    expect(screen.getByTestId('spinner')).toBeInTheDocument();
  });
});
```

### Backend Unit Tests

#### Testing Framework
```javascript
// Jest configuration for Node.js
module.exports = {
  testEnvironment: 'node',
  coveragePathIgnorePatterns: ['/node_modules/'],
  testMatch: ['**/__tests__/**/*.js', '**/?(*.)+(spec|test).js'],
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/index.js',
    '!src/config/*.js'
  ]
};
```

#### Service Testing Example
```javascript
// userService.test.js
const UserService = require('./userService');
const UserRepository = require('./userRepository');

jest.mock('./userRepository');

describe('UserService', () => {
  let userService;
  let mockRepository;

  beforeEach(() => {
    mockRepository = new UserRepository();
    userService = new UserService(mockRepository);
  });

  describe('createUser', () => {
    it('creates user with hashed password', async () => {
      const userData = {
        email: 'test@example.com',
        password: 'password123'
      };

      mockRepository.create.mockResolvedValue({
        id: '123',
        ...userData,
        password: 'hashed_password'
      });

      const result = await userService.createUser(userData);

      expect(mockRepository.create).toHaveBeenCalledWith({
        email: userData.email,
        password: expect.not.stringMatching(userData.password)
      });
      expect(result).not.toHaveProperty('password');
    });

    it('throws error for duplicate email', async () => {
      mockRepository.create.mockRejectedValue(
        new Error('Duplicate key')
      );

      await expect(
        userService.createUser({ email: 'test@example.com' })
      ).rejects.toThrow('Email already exists');
    });
  });
});
```

### Test Coverage Requirements
| Component Type | Minimum Coverage | Target Coverage |
|----------------|------------------|-----------------|
| Business Logic | 90% | 95% |
| API Controllers | 85% | 90% |
| Data Models | 80% | 85% |
| Utilities | 95% | 100% |
| UI Components | 80% | 85% |

## Integration Testing

### API Integration Tests

#### Test Setup
```javascript
// test/setup.js
const request = require('supertest');
const app = require('../src/app');
const db = require('../src/db');

beforeAll(async () => {
  await db.migrate.latest();
});

beforeEach(async () => {
  await db.seed.run();
});

afterEach(async () => {
  await db.raw('TRUNCATE TABLE users, projects, tasks CASCADE');
});

afterAll(async () => {
  await db.destroy();
});

global.request = request(app);
```

#### API Test Example
```javascript
// api/projects.test.js
describe('Projects API', () => {
  let authToken;
  let userId;

  beforeEach(async () => {
    const response = await request
      .post('/api/auth/login')
      .send({
        email: 'test@example.com',
        password: 'password123'
      });
    
    authToken = response.body.token;
    userId = response.body.user.id;
  });

  describe('POST /api/projects', () => {
    it('creates new project', async () => {
      const projectData = {
        name: 'Test Project',
        description: 'Test Description',
        clientId: 'client_123'
      };

      const response = await request
        .post('/api/projects')
        .set('Authorization', `Bearer ${authToken}`)
        .send(projectData)
        .expect(201);

      expect(response.body).toMatchObject({
        id: expect.any(String),
        ...projectData,
        createdBy: userId
      });
    });

    it('validates required fields', async () => {
      const response = await request
        .post('/api/projects')
        .set('Authorization', `Bearer ${authToken}`)
        .send({})
        .expect(400);

      expect(response.body.errors).toContainEqual(
        expect.objectContaining({
          field: 'name',
          message: 'Name is required'
        })
      );
    });
  });

  describe('GET /api/projects/:id', () => {
    it('returns project details', async () => {
      const project = await createTestProject();
      
      const response = await request
        .get(`/api/projects/${project.id}`)
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      expect(response.body).toMatchObject({
        id: project.id,
        name: project.name
      });
    });

    it('returns 404 for non-existent project', async () => {
      await request
        .get('/api/projects/non_existent')
        .set('Authorization', `Bearer ${authToken}`)
        .expect(404);
    });
  });
});
```

### Database Integration Tests
```javascript
// repositories/userRepository.test.js
describe('UserRepository', () => {
  it('creates user with associations', async () => {
    const user = await UserRepository.create({
      email: 'test@example.com',
      profile: {
        firstName: 'John',
        lastName: 'Doe'
      }
    });

    const found = await UserRepository.findById(user.id, {
      include: ['profile']
    });

    expect(found.profile).toMatchObject({
      firstName: 'John',
      lastName: 'Doe'
    });
  });

  it('handles concurrent updates correctly', async () => {
    const user = await UserRepository.create({
      email: 'test@example.com',
      credits: 100
    });

    // Simulate concurrent credit updates
    await Promise.all([
      UserRepository.addCredits(user.id, 50),
      UserRepository.addCredits(user.id, 30)
    ]);

    const updated = await UserRepository.findById(user.id);
    expect(updated.credits).toBe(180);
  });
});
```

## End-to-End Testing

### E2E Framework Setup
```javascript
// cypress.config.js
module.exports = {
  e2e: {
    baseUrl: 'http://localhost:3000',
    viewportWidth: 1280,
    viewportHeight: 720,
    video: true,
    screenshotOnRunFailure: true,
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000
  }
};
```

### E2E Test Scenarios

#### User Journey Test
```javascript
// cypress/e2e/user-journey.cy.js
describe('Complete User Journey', () => {
  beforeEach(() => {
    cy.task('db:seed');
    cy.visit('/');
  });

  it('completes project creation workflow', () => {
    // Login
    cy.get('[data-cy=email]').type('user@example.com');
    cy.get('[data-cy=password]').type('password123');
    cy.get('[data-cy=login-button]').click();
    
    // Navigate to projects
    cy.get('[data-cy=nav-projects]').click();
    cy.url().should('include', '/projects');
    
    // Create new project
    cy.get('[data-cy=new-project-button]').click();
    cy.get('[data-cy=project-name]').type('Test Project');
    cy.get('[data-cy=project-client]').select('Acme Corp');
    cy.get('[data-cy=project-budget]').type('50000');
    cy.get('[data-cy=save-button]').click();
    
    // Verify creation
    cy.url().should('match', /\/projects\/[\w-]+$/);
    cy.contains('Test Project').should('be.visible');
    cy.contains('$50,000').should('be.visible');
    
    // Add task
    cy.get('[data-cy=add-task-button]').click();
    cy.get('[data-cy=task-name]').type('Initial Planning');
    cy.get('[data-cy=task-assignee]').select('John Doe');
    cy.get('[data-cy=task-due-date]').type('2024-12-31');
    cy.get('[data-cy=save-task-button]').click();
    
    // Verify task appears
    cy.get('[data-cy=task-list]')
      .should('contain', 'Initial Planning')
      .and('contain', 'John Doe');
  });
});
```

#### Critical Path Testing
```javascript
// cypress/e2e/critical-paths.cy.js
describe('Critical Business Paths', () => {
  it('handles payment processing', () => {
    cy.login('admin@example.com', 'password');
    cy.visit('/billing');
    
    // Enter payment details
    cy.get('[data-cy=card-number]').type('4242424242424242');
    cy.get('[data-cy=card-expiry]').type('12/25');
    cy.get('[data-cy=card-cvc]').type('123');
    
    // Process payment
    cy.intercept('POST', '/api/payments', {
      statusCode: 200,
      body: { success: true, id: 'pay_123' }
    }).as('payment');
    
    cy.get('[data-cy=pay-button]').click();
    cy.wait('@payment');
    
    // Verify success
    cy.get('[data-cy=payment-success]').should('be.visible');
    cy.url().should('include', '/billing/success');
  });
});
```

### Visual Regression Testing
```javascript
// cypress/e2e/visual-regression.cy.js
describe('Visual Regression Tests', () => {
  it('captures dashboard appearance', () => {
    cy.login();
    cy.visit('/dashboard');
    cy.wait(1000); // Wait for animations
    
    // Full page screenshot
    cy.screenshot('dashboard-full', {
      capture: 'fullPage'
    });
    
    // Component screenshots
    cy.get('[data-cy=stats-widget]').screenshot('stats-widget');
    cy.get('[data-cy=activity-feed]').screenshot('activity-feed');
    
    // Compare with baseline
    cy.task('compareSnapshots', {
      name: 'dashboard-full',
      threshold: 0.1 // 10% difference allowed
    });
  });
});
```

## Performance Testing

### Load Testing

#### K6 Test Script
```javascript
// tests/load/api-load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate } from 'k6/metrics';

const errorRate = new Rate('errors');

export const options = {
  stages: [
    { duration: '2m', target: 50 },   // Ramp up
    { duration: '5m', target: 100 },  // Stay at 100 users
    { duration: '2m', target: 200 },  // Spike to 200
    { duration: '5m', target: 200 },  // Stay at 200
    { duration: '2m', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% of requests under 500ms
    errors: ['rate<0.05'],            // Error rate under 5%
  },
};

const BASE_URL = 'https://api.example.com';

export function setup() {
  // Login and get token
  const loginRes = http.post(`${BASE_URL}/auth/login`, {
    email: 'test@example.com',
    password: 'password123'
  });
  
  return { token: loginRes.json('token') };
}

export default function(data) {
  const headers = {
    'Authorization': `Bearer ${data.token}`,
    'Content-Type': 'application/json',
  };

  // Scenario 1: List projects
  const projectsRes = http.get(`${BASE_URL}/projects`, { headers });
  check(projectsRes, {
    'projects status 200': (r) => r.status === 200,
    'projects response time OK': (r) => r.timings.duration < 300,
  });
  errorRate.add(projectsRes.status !== 200);

  sleep(1);

  // Scenario 2: Create task
  const taskRes = http.post(
    `${BASE_URL}/tasks`,
    JSON.stringify({
      name: 'Load test task',
      projectId: 'proj_123',
      assignee: 'user_456'
    }),
    { headers }
  );
  
  check(taskRes, {
    'task created': (r) => r.status === 201,
    'task has id': (r) => r.json('id') !== undefined,
  });
  errorRate.add(taskRes.status !== 201);

  sleep(2);
}
```

### Frontend Performance Testing
```javascript
// tests/performance/lighthouse.js
const lighthouse = require('lighthouse');
const chromeLauncher = require('chrome-launcher');

async function runLighthouse(url) {
  const chrome = await chromeLauncher.launch({ chromeFlags: ['--headless'] });
  const options = {
    logLevel: 'info',
    output: 'json',
    onlyCategories: ['performance', 'accessibility', 'best-practices', 'seo'],
    port: chrome.port
  };

  const runnerResult = await lighthouse(url, options);
  await chrome.kill();

  return runnerResult.lhr;
}

// Performance assertions
async function testPerformance() {
  const results = await runLighthouse('https://example.com');
  
  const scores = {
    performance: results.categories.performance.score * 100,
    accessibility: results.categories.accessibility.score * 100,
    bestPractices: results.categories['best-practices'].score * 100,
    seo: results.categories.seo.score * 100
  };

  // Assert minimum scores
  expect(scores.performance).toBeGreaterThan(90);
  expect(scores.accessibility).toBeGreaterThan(95);
  expect(scores.bestPractices).toBeGreaterThan(90);
  expect(scores.seo).toBeGreaterThan(90);

  // Check specific metrics
  const metrics = results.audits.metrics.details.items[0];
  expect(metrics.firstContentfulPaint).toBeLessThan(1500);
  expect(metrics.largestContentfulPaint).toBeLessThan(2500);
  expect(metrics.totalBlockingTime).toBeLessThan(300);
  expect(metrics.cumulativeLayoutShift).toBeLessThan(0.1);
}
```

## Security Testing

### Security Test Suite
```javascript
// tests/security/security.test.js
describe('Security Tests', () => {
  describe('Authentication', () => {
    it('prevents brute force attacks', async () => {
      const attempts = Array(6).fill(null).map(() => 
        request.post('/api/auth/login').send({
          email: 'test@example.com',
          password: 'wrong_password'
        })
      );

      const responses = await Promise.all(attempts);
      const lastResponse = responses[5];
      
      expect(lastResponse.status).toBe(429); // Too many requests
      expect(lastResponse.body).toMatchObject({
        error: 'Too many login attempts'
      });
    });

    it('validates JWT signatures', async () => {
      const tamperedToken = validToken.replace(/.$/, 'X');
      
      const response = await request
        .get('/api/user/profile')
        .set('Authorization', `Bearer ${tamperedToken}`)
        .expect(401);

      expect(response.body.error).toBe('Invalid token');
    });
  });

  describe('SQL Injection Prevention', () => {
    it('handles malicious input safely', async () => {
      const maliciousInput = "'; DROP TABLE users; --";
      
      const response = await request
        .get(`/api/search?q=${encodeURIComponent(maliciousInput)}`)
        .set('Authorization', `Bearer ${authToken}`)
        .expect(200);

      // Verify database is intact
      const users = await db('users').count();
      expect(users[0].count).toBeGreaterThan(0);
    });
  });

  describe('XSS Prevention', () => {
    it('sanitizes user input', async () => {
      const xssPayload = '<script>alert("XSS")</script>';
      
      const response = await request
        .post('/api/comments')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ content: xssPayload })
        .expect(201);

      expect(response.body.content).not.toContain('<script>');
      expect(response.body.content).toBe('&lt;script&gt;alert("XSS")&lt;/script&gt;');
    });
  });
});
```

### Penetration Testing Checklist
- [ ] OWASP Top 10 vulnerabilities
- [ ] Authentication bypass attempts
- [ ] Session management flaws
- [ ] Input validation testing
- [ ] Access control verification
- [ ] Cryptography implementation
- [ ] Error handling information leakage
- [ ] API rate limiting
- [ ] File upload vulnerabilities
- [ ] CORS configuration

## Accessibility Testing

### Automated Accessibility Tests
```javascript
// tests/accessibility/a11y.test.js
const { axe, toHaveNoViolations } = require('jest-axe');
expect.extend(toHaveNoViolations);

describe('Accessibility Tests', () => {
  it('has no accessibility violations on homepage', async () => {
    const { container } = render(<HomePage />);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });

  it('supports keyboard navigation', () => {
    render(<Navigation />);
    
    const firstLink = screen.getByText('Dashboard');
    const secondLink = screen.getByText('Projects');
    
    firstLink.focus();
    expect(document.activeElement).toBe(firstLink);
    
    fireEvent.keyDown(firstLink, { key: 'Tab' });
    expect(document.activeElement).toBe(secondLink);
  });

  it('has proper ARIA labels', () => {
    render(<Form />);
    
    expect(screen.getByLabelText('Email Address')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Submit Form' })).toBeInTheDocument();
    expect(screen.getByRole('alert')).toHaveAttribute('aria-live', 'polite');
  });
});
```

### Manual Accessibility Testing
| Test | Tool | Criteria |
|------|------|----------|
| Screen Reader | NVDA/JAWS | All content readable |
| Keyboard Navigation | Manual | All interactive elements accessible |
| Color Contrast | WAVE | WCAG AA compliance |
| Focus Indicators | Manual | Visible on all elements |
| Form Labels | axe DevTools | All inputs labeled |

## Mobile Testing

### Device Testing Matrix
| Platform | Versions | Devices | Browsers |
|----------|----------|---------|----------|
| iOS | 15, 16, 17 | iPhone 12-15, iPad | Safari, Chrome |
| Android | 11, 12, 13 | Pixel, Samsung | Chrome, Firefox |
| Desktop | - | - | Chrome, Firefox, Safari, Edge |

### Mobile-Specific Tests
```javascript
// tests/mobile/responsive.test.js
describe('Mobile Responsive Tests', () => {
  const viewports = [
    { name: 'iPhone 12', width: 390, height: 844 },
    { name: 'iPad', width: 768, height: 1024 },
    { name: 'Desktop', width: 1920, height: 1080 }
  ];

  viewports.forEach(viewport => {
    it(`renders correctly on ${viewport.name}`, () => {
      cy.viewport(viewport.width, viewport.height);
      cy.visit('/');
      
      if (viewport.width < 768) {
        // Mobile assertions
        cy.get('[data-cy=mobile-menu]').should('be.visible');
        cy.get('[data-cy=desktop-nav]').should('not.be.visible');
      } else {
        // Desktop assertions
        cy.get('[data-cy=desktop-nav]').should('be.visible');
        cy.get('[data-cy=mobile-menu]').should('not.exist');
      }
      
      cy.screenshot(`homepage-${viewport.name}`);
    });
  });
});
```

## Test Data Management

### Test Data Strategy
```yaml
Approaches:
  - Fixtures: Static test data files
  - Factories: Dynamic data generation
  - Seeders: Database population
  - Mocks: External service stubs

Data Privacy:
  - No production data in tests
  - Anonymized data sets
  - Synthetic data generation
  - Secure test data storage
```

### Test Data Factories
```javascript
// tests/factories/userFactory.js
const { Factory } = require('rosie');
const faker = require('faker');

export const UserFactory = Factory.define('user')
  .sequence('id')
  .attr('email', () => faker.internet.email())
  .attr('firstName', () => faker.name.firstName())
  .attr('lastName', () => faker.name.lastName())
  .attr('role', ['admin', 'manager', 'user'], (roles) => 
    faker.random.arrayElement(roles)
  )
  .attr('createdAt', () => faker.date.past());

// Usage
const testUser = UserFactory.build();
const adminUser = UserFactory.build({ role: 'admin' });
const users = UserFactory.buildList(10);
```

## Test Automation Framework

### Framework Architecture
```
tests/
├── unit/
│   ├── frontend/
│   └── backend/
├── integration/
│   ├── api/
│   └── database/
├── e2e/
│   ├── scenarios/
│   └── pages/
├── performance/
├── security/
├── utils/
│   ├── helpers.js
│   ├── fixtures/
│   └── factories/
└── config/
    ├── jest.config.js
    └── cypress.config.js
```

### CI/CD Integration
```yaml
# .github/workflows/test.yml
name: Test Suite

on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm ci
      - run: npm run test:unit
      - uses: codecov/codecov-action@v3

  integration-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm run db:migrate
      - run: npm run test:integration

  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm ci
      - run: npm run build
      - run: npm start & npx wait-on http://localhost:3000
      - run: npm run test:e2e
      - uses: actions/upload-artifact@v3
        if: failure()
        with:
          name: cypress-screenshots
          path: cypress/screenshots
```

## Test Reporting

### Test Metrics Dashboard
```yaml
Key Metrics:
  - Test execution time
  - Pass/fail rate
  - Code coverage
  - Flaky test detection
  - Defect density
  - Test maintenance cost

Reports:
  - Daily test summary
  - Coverage trends
  - Performance benchmarks
  - Security scan results
  - Accessibility scores
```

### Test Report Example
```json
{
  "summary": {
    "total": 1234,
    "passed": 1220,
    "failed": 14,
    "skipped": 0,
    "duration": "12m 34s"
  },
  "coverage": {
    "lines": 85.6,
    "branches": 78.2,
    "functions": 88.1,
    "statements": 84.9
  },
  "failures": [
    {
      "test": "should handle concurrent updates",
      "file": "tests/integration/api/users.test.js",
      "error": "Expected 200 but received 500",
      "stack": "..."
    }
  ]
}
```

## Test Environment Management

### Environment Configuration
| Environment | Purpose | Data | Reset |
|-------------|---------|------|-------|
| Local | Development | Seeded | On demand |
| CI | Automated tests | Fresh | Each run |
| Staging | Manual testing | Anonymized | Weekly |
| Performance | Load testing | Generated | Before test |

### Environment Setup Script
```bash
#!/bin/bash
# setup-test-env.sh

echo "Setting up test environment..."

# Start services
docker-compose -f docker-compose.test.yml up -d

# Wait for services
wait-for-it postgres:5432 -t 30
wait-for-it redis:6379 -t 30

# Run migrations
npm run db:migrate:test

# Seed test data
npm run db:seed:test

echo "Test environment ready!"
```

## Regression Testing

### Regression Test Selection
```yaml
Strategies:
  - Impact analysis based
  - Risk-based selection
  - History-based (frequently failing)
  - Code coverage based

Automation:
  - Nightly full regression
  - PR-triggered subset
  - Release candidate full suite
  - Hotfix minimal set
```

## User Acceptance Testing

### UAT Process
```yaml
Planning:
  - Identify test scenarios
  - Select test users
  - Prepare test data
  - Define success criteria

Execution:
  - User training session
  - Guided test execution
  - Issue recording
  - Feedback collection

Sign-off:
  - Issue resolution
  - Retesting
  - Formal approval
  - Documentation
```

### UAT Test Script Template
```markdown
## Test Case: [Feature Name]

**Preconditions:**
- User logged in as [role]
- [Other conditions]

**Steps:**
1. Navigate to [location]
2. Click on [element]
3. Enter [data]
4. Verify [expected result]

**Expected Results:**
- [Specific outcomes]
- [Visual confirmations]
- [Data validations]

**Actual Results:**
- [ ] Pass
- [ ] Fail (describe issue)

**Notes:**
[Any observations or suggestions]
```

## Test Maintenance

### Test Maintenance Guidelines
1. **Regular Review**: Monthly test suite review
2. **Flaky Test Management**: Quarantine and fix
3. **Obsolete Test Removal**: Remove redundant tests
4. **Test Refactoring**: Improve readability and efficiency
5. **Documentation Updates**: Keep test docs current

### Test Quality Metrics
| Metric | Target | Action if Below |
|--------|--------|-----------------|
| Test Stability | > 95% | Fix flaky tests |
| Execution Time | < 30 min | Optimize or parallelize |
| Maintenance Cost | < 20% effort | Refactor test code |
| False Positives | < 2% | Improve assertions |

## Testing Tools Summary

### Tool Stack
| Category | Tool | Purpose |
|----------|------|---------|
| Unit Testing | Jest | JavaScript testing |
| E2E Testing | Cypress | Browser automation |
| API Testing | Supertest | HTTP assertions |
| Load Testing | k6 | Performance testing |
| Security | OWASP ZAP | Vulnerability scanning |
| Accessibility | axe-core | A11y validation |
| Visual Testing | Percy | Visual regression |
| Mocking | MSW | API mocking |
| Coverage | Istanbul | Code coverage |
| Reporting | Allure | Test reporting |

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</testing_template>

## Guidance Notes

When generating testing documentation, ensure:

1. **Comprehensive Coverage** across all testing levels
2. **Automation First** approach with manual testing where needed
3. **Clear Examples** with working code samples
4. **Measurable Goals** for quality metrics
5. **CI/CD Integration** for continuous testing
6. **Performance Focus** on test execution speed
7. **Maintainability** of test suites
8. **Documentation** for test strategies and tools
9. **Risk-Based** prioritization of testing efforts
10. **Continuous Improvement** through metrics and feedback

Focus on creating testing strategies that:
- Catch bugs before production
- Enable confident deployments
- Support rapid development
- Maintain high quality standards
- Provide clear feedback to developers