# Specification Chain: API Specification

You are an expert API architect with 15+ years of experience designing RESTful APIs for enterprise SaaS platforms. You specialize in creating developer-friendly, secure, and scalable API specifications. Deliver comprehensive, production-ready API documentation.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <prd>
  [PRODUCT REQUIREMENTS DOCUMENT OR SUMMARY]
  </prd>

  <technical_spec>
  [TECHNICAL SPECIFICATION OR KEY TECHNICAL DETAILS]
  </technical_spec>

  <api_requirements>
  [ANY SPECIFIC API REQUIREMENTS OR CONSTRAINTS]
  </api_requirements>
</user_data>

<task>
1. **Private reasoning:** Open an `<api_planning>` tag. Inside it follow the <analysis_checklist>.
    • Use full chain-of-thought, example payloads, endpoint design patterns.
    • Close `</api_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</api_planning>`, output *only* the API Specification using the Markdown structure found in <api_spec_template>. Fill every placeholder with concrete, detailed content.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once a complete API specification has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Map functional requirements to API endpoints
2. Design resource hierarchy and URL structure
3. Define authentication and authorization scheme
4. Plan rate limiting and throttling strategy
5. Design consistent response formats
6. Create comprehensive error handling
7. Define all request/response payloads
8. Plan pagination, filtering, and sorting
9. Design batch operations if needed
10. Consider versioning strategy
11. Plan webhook events and payloads
12. Define security headers and CORS policy
13. Create API testing examples
14. Consider SDK/client library needs
15. Plan monitoring and analytics endpoints
</analysis_checklist>

<api_spec_template markdown="true">
# API Specification: [App Name]

## Overview

[Description of the API, its purpose, and target developers]

### Base URL
```
https://api.[domain].com/v1
```

### Authentication
[Authentication method description]
```
Authorization: Bearer <your-api-token>
```

### Rate Limiting
- [Rate limit rules]
- Rate limit headers included in all responses:
  - `X-RateLimit-Limit`: [Description]
  - `X-RateLimit-Remaining`: [Description]
  - `X-RateLimit-Reset`: [Description]

### Response Format
All responses return JSON with consistent structure:

#### Success Response
```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "timestamp": "2024-01-20T10:30:00Z"
  }
}
```

#### Error Response
```json
{
  "success": false,
  "error": {
    "code": "[ERROR_CODE]",
    "message": "[Human readable message]",
    "details": { ... }
  },
  "meta": {
    "timestamp": "2024-01-20T10:30:00Z"
  }
}
```

## Authentication Endpoints

### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}

Response: 200 OK
{
  "success": true,
  "data": {
    "access_token": "eyJhbGc...",
    "refresh_token": "eyJhbGc...",
    "expires_in": 86400,
    "user": {
      "id": "[uuid]",
      "email": "user@example.com",
      "role": "[role]",
      [additional user fields]
    }
  }
}
```

### Refresh Token
```http
POST /auth/refresh
Content-Type: application/json

{
  "refresh_token": "eyJhbGc..."
}

Response: 200 OK
{
  "success": true,
  "data": {
    "access_token": "eyJhbGc...",
    "refresh_token": "eyJhbGc...",
    "expires_in": 86400
  }
}
```

### Logout
```http
POST /auth/logout
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "message": "Successfully logged out"
  }
}
```

## [Resource] Endpoints

### List [Resources]
```http
GET /[resources]?page=1&limit=20&[filter]=[value]
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "[resources]": [
      {
        "id": "[uuid]",
        [resource fields],
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-15T10:30:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 45,
      "pages": 3
    }
  }
}
```

### Create [Resource]
```http
POST /[resources]
Authorization: Bearer <token>
Content-Type: application/json

{
  [required fields],
  [optional fields]
}

Response: 201 Created
{
  "success": true,
  "data": {
    "[resource]": {
      "id": "[uuid]",
      [all resource fields]
    }
  }
}
```

### Get [Resource]
```http
GET /[resources]/:id
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "[resource]": {
      "id": "[uuid]",
      [all resource fields]
    }
  }
}
```

### Update [Resource]
```http
PUT /[resources]/:id
Authorization: Bearer <token>
Content-Type: application/json

{
  [updatable fields]
}

Response: 200 OK
{
  "success": true,
  "data": {
    "[resource]": {
      [updated resource]
    }
  }
}
```

### Delete [Resource]
```http
DELETE /[resources]/:id
Authorization: Bearer <token>

Response: 204 No Content
```

[Continue with all resources...]

## Batch Operations

### Batch Create
```http
POST /[resources]/batch
Authorization: Bearer <token>
Content-Type: application/json

{
  "[resources]": [
    { [resource 1] },
    { [resource 2] }
  ]
}

Response: 200 OK
{
  "success": true,
  "data": {
    "created": 2,
    "failed": 0,
    "[resources]": [ ... ]
  }
}
```

## Search and Filtering

### Search Syntax
```http
GET /[resources]?search=[query]&filter[field]=[value]&sort=[field:direction]
```

### Supported Operators
- `eq`: Equals
- `ne`: Not equals
- `gt`: Greater than
- `gte`: Greater than or equal
- `lt`: Less than
- `lte`: Less than or equal
- `in`: In array
- `like`: Pattern matching

## Reports Endpoints

### [Report Name]
```http
GET /reports/[report-type]?[parameters]
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "report": {
      "period": {
        "start": "2024-01-01",
        "end": "2024-01-31"
      },
      "summary": {
        [summary metrics]
      },
      "details": [
        [detailed data]
      ]
    }
  }
}
```

## Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| UNAUTHORIZED | 401 | Invalid or missing authentication token |
| FORBIDDEN | 403 | User lacks permission for this action |
| NOT_FOUND | 404 | Requested resource not found |
| VALIDATION_ERROR | 400 | Invalid input data |
| RATE_LIMIT_EXCEEDED | 429 | Too many requests |
| INTERNAL_ERROR | 500 | Server error occurred |
| [Additional codes] | [Status] | [Description] |

## Webhooks

Webhooks are supported for the following events:
- `[resource].[event]` - [Description]
- `[resource].[event]` - [Description]

### Webhook Registration
```http
POST /webhooks
Authorization: Bearer <token>
Content-Type: application/json

{
  "url": "https://your-domain.com/webhook",
  "events": ["task.created", "task.completed"],
  "secret": "your-webhook-secret"
}
```

### Webhook Payload Format
```json
{
  "event": "[resource].[action]",
  "timestamp": "2024-01-20T10:30:00Z",
  "data": {
    "[resource]": { ... },
    [additional context]
  }
}
```

### Webhook Security
- Signature header: `X-Webhook-Signature`
- Signature format: `sha256=hash_of_payload_with_secret`

## SDK Examples

### JavaScript/TypeScript
```javascript
const client = new [AppName]Client({
  apiKey: 'your-api-key',
  baseUrl: 'https://api.[domain].com/v1'
});

// List resources
const resources = await client.[resources].list({
  page: 1,
  limit: 20
});

// Create resource
const newResource = await client.[resources].create({
  [fields]
});
```

### Python
```python
from [app_name] import Client

client = Client(
    api_key='your-api-key',
    base_url='https://api.[domain].com/v1'
)

# List resources
resources = client.[resources].list(page=1, limit=20)

# Create resource
new_resource = client.[resources].create(
    [fields]
)
```

## API Testing

### cURL Examples
```bash
# Authentication
curl -X POST https://api.[domain].com/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'

# List resources
curl -X GET https://api.[domain].com/v1/[resources] \
  -H "Authorization: Bearer YOUR_TOKEN"

# Create resource
curl -X POST https://api.[domain].com/v1/[resources] \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ [resource data] }'
```

### Postman Collection
[Link to downloadable Postman collection]

## Changelog

### Version 1.0 (Current)
- Initial API release
- [List key features]

### Planned Features
- [Feature 1]
- [Feature 2]

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</api_spec_template>

## Guidance Notes

When generating the API specification, ensure:

1. **Overview** clearly explains the API's purpose and capabilities
2. **Authentication** includes complete flow with token management
3. **Endpoints** follow RESTful conventions consistently
4. **Request/Response** examples include all fields with realistic data
5. **Error Codes** cover all possible error scenarios
6. **Rate Limiting** has clear rules and header documentation
7. **Pagination** is consistent across all list endpoints
8. **Filtering/Search** syntax is well-documented with examples
9. **Webhooks** include security considerations and retry logic
10. **SDK Examples** cover common use cases in multiple languages

Focus on creating documentation that:
- Developers can use to integrate quickly
- Includes complete examples for every endpoint
- Has consistent naming and structure
- Covers edge cases and error scenarios
- Provides testing tools and examples