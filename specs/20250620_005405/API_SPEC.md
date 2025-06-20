# API Specification: BIG Live Portal

## Overview

The BIG Live Portal API provides a comprehensive REST interface for managing performing artists, contracts, expenses, and schedules in arts organizations. Designed with a mobile-first approach, the API enables secure, efficient interactions between artists accessing the platform on personal devices and administrators managing operations. The API emphasizes simplicity, performance, and reliability while integrating seamlessly with existing enterprise systems like SharePoint and Xero.

### Base URL
```
https://api.bigliveportal.com/v1
```

### Authentication
The API uses JWT (JSON Web Token) authentication with optional Azure AD SSO integration. All requests to protected endpoints must include a valid bearer token.
```
Authorization: Bearer <your-api-token>
```

### Rate Limiting
- **Global limit**: 1000 requests per hour per IP address
- **Authenticated limit**: 100 requests per minute per user
- **Upload endpoints**: 10 requests per minute per user
- Rate limit headers included in all responses:
  - `X-RateLimit-Limit`: Maximum requests allowed in the current window
  - `X-RateLimit-Remaining`: Number of requests remaining
  - `X-RateLimit-Reset`: Unix timestamp when the rate limit resets

### Response Format
All responses return JSON with consistent structure:

#### Success Response
```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "timestamp": "2024-01-20T10:30:00Z",
    "version": "1.0"
  }
}
```

#### Error Response
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The provided data failed validation",
    "details": {
      "field": "email",
      "reason": "Invalid email format"
    }
  },
  "meta": {
    "timestamp": "2024-01-20T10:30:00Z",
    "request_id": "req_1234567890"
  }
}
```

## Authentication Endpoints

### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "sarah.chen@email.com",
  "password": "securePassword123"
}

Response: 200 OK
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expires_in": 86400,
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "sarah.chen@email.com",
      "role": "artist",
      "first_name": "Sarah",
      "last_name": "Chen",
      "company_id": "660e8400-e29b-41d4-a716-446655440001"
    }
  }
}
```

### Refresh Token
```http
POST /auth/refresh
Content-Type: application/json

{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}

Response: 200 OK
{
  "success": true,
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
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

### Azure AD SSO
```http
GET /auth/sso/azure
Query Parameters:
  - redirect_uri: URL to redirect after authentication

Response: 302 Redirect
Location: https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize?...
```

### Password Reset Request
```http
POST /auth/reset-password
Content-Type: application/json

{
  "email": "sarah.chen@email.com"
}

Response: 200 OK
{
  "success": true,
  "data": {
    "message": "Password reset instructions sent to email"
  }
}
```

## User Endpoints

### List Users
```http
GET /users?page=1&limit=20&role=artist&search=sarah
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "users": [
      {
        "id": "550e8400-e29b-41d4-a716-446655440000",
        "email": "sarah.chen@email.com",
        "first_name": "Sarah",
        "last_name": "Chen",
        "role": "artist",
        "phone": "+1-555-0123",
        "is_active": true,
        "last_login": "2024-01-20T09:15:00Z",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-20T10:30:00Z"
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

### Create User
```http
POST /users
Authorization: Bearer <token>
Content-Type: application/json

{
  "email": "john.doe@email.com",
  "first_name": "John",
  "last_name": "Doe",
  "role": "artist",
  "phone": "+1-555-0124",
  "send_invitation": true
}

Response: 201 Created
{
  "success": true,
  "data": {
    "user": {
      "id": "770e8400-e29b-41d4-a716-446655440002",
      "email": "john.doe@email.com",
      "first_name": "John",
      "last_name": "Doe",
      "role": "artist",
      "is_active": true,
      "invitation_sent": true,
      "created_at": "2024-01-20T10:30:00Z"
    }
  }
}
```

### Get Current User
```http
GET /users/me
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "sarah.chen@email.com",
      "first_name": "Sarah",
      "last_name": "Chen",
      "role": "artist",
      "phone": "+1-555-0123",
      "tax_id_encrypted": "***-**-1234",
      "emergency_contact": {
        "name": "Jane Chen",
        "phone": "+1-555-0125",
        "relationship": "Sister"
      },
      "is_active": true,
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-20T10:30:00Z"
    }
  }
}
```

### Update User
```http
PUT /users/550e8400-e29b-41d4-a716-446655440000
Authorization: Bearer <token>
Content-Type: application/json

{
  "phone": "+1-555-0126",
  "emergency_contact": {
    "name": "Jane Chen",
    "phone": "+1-555-0127",
    "relationship": "Sister"
  }
}

Response: 200 OK
{
  "success": true,
  "data": {
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "email": "sarah.chen@email.com",
      "first_name": "Sarah",
      "last_name": "Chen",
      "phone": "+1-555-0126",
      "emergency_contact": {
        "name": "Jane Chen",
        "phone": "+1-555-0127",
        "relationship": "Sister"
      },
      "updated_at": "2024-01-20T10:35:00Z"
    }
  }
}
```

### Bulk Import Users
```http
POST /users/bulk
Authorization: Bearer <token>
Content-Type: multipart/form-data

FormData:
  - file: users.csv
  - send_invitations: true

Response: 200 OK
{
  "success": true,
  "data": {
    "imported": 15,
    "failed": 2,
    "errors": [
      {
        "row": 5,
        "email": "invalid-email",
        "error": "Invalid email format"
      },
      {
        "row": 12,
        "email": "duplicate@email.com",
        "error": "Email already exists"
      }
    ]
  }
}
```

## Contract Endpoints

### List Contracts
```http
GET /contracts?status=pending_signature&production=880e8400-e29b-41d4-a716-446655440003
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "contracts": [
      {
        "id": "990e8400-e29b-41d4-a716-446655440004",
        "artist_id": "550e8400-e29b-41d4-a716-446655440000",
        "artist_name": "Sarah Chen",
        "production_id": "880e8400-e29b-41d4-a716-446655440003",
        "production_name": "The Nutcracker 2024",
        "document_url": "https://api.bigliveportal.com/v1/documents/990e8400",
        "status": "pending_signature",
        "amount": 5000.00,
        "currency": "USD",
        "start_date": "2024-11-01",
        "end_date": "2024-12-31",
        "version": 1,
        "created_at": "2024-01-15T10:00:00Z",
        "updated_at": "2024-01-15T10:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 1,
      "pages": 1
    }
  }
}
```

### Create Contract
```http
POST /contracts
Authorization: Bearer <token>
Content-Type: multipart/form-data

FormData:
  - artist_id: "550e8400-e29b-41d4-a716-446655440000"
  - production_id: "880e8400-e29b-41d4-a716-446655440003"
  - document: contract.pdf
  - amount: 5000.00
  - currency: "USD"
  - start_date: "2024-11-01"
  - end_date: "2024-12-31"

Response: 201 Created
{
  "success": true,
  "data": {
    "contract": {
      "id": "aa0e8400-e29b-41d4-a716-446655440005",
      "artist_id": "550e8400-e29b-41d4-a716-446655440000",
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "document_url": "https://api.bigliveportal.com/v1/documents/aa0e8400",
      "sharepoint_id": "SP-DOC-12345",
      "status": "pending_signature",
      "amount": 5000.00,
      "currency": "USD",
      "start_date": "2024-11-01",
      "end_date": "2024-12-31",
      "created_at": "2024-01-20T10:40:00Z"
    }
  }
}
```

### Get Contract
```http
GET /contracts/990e8400-e29b-41d4-a716-446655440004
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "contract": {
      "id": "990e8400-e29b-41d4-a716-446655440004",
      "artist_id": "550e8400-e29b-41d4-a716-446655440000",
      "artist_name": "Sarah Chen",
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "production_name": "The Nutcracker 2024",
      "document_url": "https://api.bigliveportal.com/v1/documents/990e8400",
      "sharepoint_id": "SP-DOC-12345",
      "status": "pending_signature",
      "amount": 5000.00,
      "currency": "USD",
      "start_date": "2024-11-01",
      "end_date": "2024-12-31",
      "version": 1,
      "metadata": {
        "role": "Principal Dancer",
        "performances": 12
      },
      "created_at": "2024-01-15T10:00:00Z",
      "updated_at": "2024-01-15T10:00:00Z"
    }
  }
}
```

### Sign Contract
```http
POST /contracts/990e8400-e29b-41d4-a716-446655440004/sign
Authorization: Bearer <token>
Content-Type: application/json

{
  "signature_type": "docusign",
  "signature_data": {
    "ip_address": "192.168.1.1",
    "user_agent": "Mozilla/5.0..."
  }
}

Response: 200 OK
{
  "success": true,
  "data": {
    "contract": {
      "id": "990e8400-e29b-41d4-a716-446655440004",
      "status": "active",
      "signed_at": "2024-01-20T10:45:00Z",
      "signature_id": "DS-SIG-67890"
    },
    "redirect_url": "https://docusign.com/signing/..."
  }
}
```

## Expense Endpoints

### List Expenses
```http
GET /expenses?status=submitted&production=880e8400-e29b-41d4-a716-446655440003
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "expenses": [
      {
        "id": "bb0e8400-e29b-41d4-a716-446655440006",
        "artist_id": "550e8400-e29b-41d4-a716-446655440000",
        "artist_name": "Sarah Chen",
        "production_id": "880e8400-e29b-41d4-a716-446655440003",
        "production_name": "The Nutcracker 2024",
        "amount": 125.50,
        "currency": "USD",
        "category": "Transportation",
        "description": "Taxi to rehearsal venue",
        "expense_date": "2024-01-18",
        "receipt_urls": [
          "https://api.bigliveportal.com/v1/documents/receipt-001"
        ],
        "status": "submitted",
        "submitted_at": "2024-01-19T14:30:00Z",
        "created_at": "2024-01-19T14:25:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 5,
      "pages": 1
    }
  }
}
```

### Create Expense
```http
POST /expenses
Authorization: Bearer <token>
Content-Type: multipart/form-data

FormData:
  - production_id: "880e8400-e29b-41d4-a716-446655440003"
  - amount: 125.50
  - currency: "USD"
  - category: "Transportation"
  - description: "Taxi to rehearsal venue"
  - expense_date: "2024-01-18"
  - receipts[]: receipt1.jpg
  - receipts[]: receipt2.jpg

Response: 201 Created
{
  "success": true,
  "data": {
    "expense": {
      "id": "cc0e8400-e29b-41d4-a716-446655440007",
      "artist_id": "550e8400-e29b-41d4-a716-446655440000",
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "amount": 125.50,
      "currency": "USD",
      "category": "Transportation",
      "description": "Taxi to rehearsal venue",
      "expense_date": "2024-01-18",
      "receipt_urls": [
        "https://api.bigliveportal.com/v1/documents/receipt-002",
        "https://api.bigliveportal.com/v1/documents/receipt-003"
      ],
      "status": "draft",
      "created_at": "2024-01-20T10:50:00Z"
    }
  }
}
```

### Submit Expense
```http
POST /expenses/cc0e8400-e29b-41d4-a716-446655440007/submit
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "expense": {
      "id": "cc0e8400-e29b-41d4-a716-446655440007",
      "status": "submitted",
      "submitted_at": "2024-01-20T10:52:00Z"
    },
    "message": "Expense submitted for approval"
  }
}
```

### Approve Expense
```http
POST /expenses/bb0e8400-e29b-41d4-a716-446655440006/approve
Authorization: Bearer <token>
Content-Type: application/json

{
  "notes": "Approved for payment"
}

Response: 200 OK
{
  "success": true,
  "data": {
    "expense": {
      "id": "bb0e8400-e29b-41d4-a716-446655440006",
      "status": "approved",
      "approved_by": "440e8400-e29b-41d4-a716-446655440008",
      "approved_at": "2024-01-20T11:00:00Z",
      "xero_id": "XERO-BILL-12345"
    },
    "message": "Expense approved and sent to Xero"
  }
}
```

### Reject Expense
```http
POST /expenses/bb0e8400-e29b-41d4-a716-446655440006/reject
Authorization: Bearer <token>
Content-Type: application/json

{
  "reason": "Receipt not legible, please resubmit"
}

Response: 200 OK
{
  "success": true,
  "data": {
    "expense": {
      "id": "bb0e8400-e29b-41d4-a716-446655440006",
      "status": "rejected",
      "rejection_reason": "Receipt not legible, please resubmit",
      "rejected_by": "440e8400-e29b-41d4-a716-446655440008",
      "rejected_at": "2024-01-20T11:00:00Z"
    }
  }
}
```

## Schedule Endpoints

### List Schedules
```http
GET /schedules?start=2024-01-20&end=2024-01-27&type=rehearsal
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "schedules": [
      {
        "id": "dd0e8400-e29b-41d4-a716-446655440009",
        "production_id": "880e8400-e29b-41d4-a716-446655440003",
        "production_name": "The Nutcracker 2024",
        "title": "Full Cast Rehearsal",
        "type": "rehearsal",
        "start_time": "2024-01-22T18:00:00Z",
        "end_time": "2024-01-22T21:00:00Z",
        "location": "Main Studio",
        "location_url": "https://maps.google.com/?q=Main+Studio",
        "notes": "Please bring pointe shoes",
        "created_by": "440e8400-e29b-41d4-a716-446655440008",
        "assigned_artists": [
          "550e8400-e29b-41d4-a716-446655440000"
        ],
        "created_at": "2024-01-15T10:00:00Z",
        "updated_at": "2024-01-20T09:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 3,
      "pages": 1
    }
  }
}
```

### Create Schedule
```http
POST /schedules
Authorization: Bearer <token>
Content-Type: application/json

{
  "production_id": "880e8400-e29b-41d4-a716-446655440003",
  "title": "Tech Rehearsal",
  "type": "rehearsal",
  "start_time": "2024-01-25T14:00:00Z",
  "end_time": "2024-01-25T18:00:00Z",
  "location": "Theater Stage",
  "location_url": "https://maps.google.com/?q=Theater+Stage",
  "notes": "Full costume required",
  "assigned_artists": [
    "550e8400-e29b-41d4-a716-446655440000",
    "770e8400-e29b-41d4-a716-446655440002"
  ]
}

Response: 201 Created
{
  "success": true,
  "data": {
    "schedule": {
      "id": "ee0e8400-e29b-41d4-a716-446655440010",
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "title": "Tech Rehearsal",
      "type": "rehearsal",
      "start_time": "2024-01-25T14:00:00Z",
      "end_time": "2024-01-25T18:00:00Z",
      "location": "Theater Stage",
      "location_url": "https://maps.google.com/?q=Theater+Stage",
      "notes": "Full costume required",
      "assigned_artists": [
        "550e8400-e29b-41d4-a716-446655440000",
        "770e8400-e29b-41d4-a716-446655440002"
      ],
      "created_by": "440e8400-e29b-41d4-a716-446655440008",
      "created_at": "2024-01-20T11:10:00Z"
    },
    "notifications_sent": 2
  }
}
```

### Update Schedule
```http
PUT /schedules/dd0e8400-e29b-41d4-a716-446655440009
Authorization: Bearer <token>
Content-Type: application/json

{
  "start_time": "2024-01-22T19:00:00Z",
  "notes": "Please bring pointe shoes. Start time changed to 7 PM."
}

Response: 200 OK
{
  "success": true,
  "data": {
    "schedule": {
      "id": "dd0e8400-e29b-41d4-a716-446655440009",
      "start_time": "2024-01-22T19:00:00Z",
      "notes": "Please bring pointe shoes. Start time changed to 7 PM.",
      "updated_at": "2024-01-20T11:15:00Z"
    },
    "notifications_sent": 1
  }
}
```

### Export Calendar
```http
GET /schedules/export?format=ical
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "ical_url": "https://api.bigliveportal.com/v1/calendar/550e8400-e29b-41d4-a716-446655440000.ics",
    "expires_at": "2025-01-20T11:20:00Z"
  }
}
```

## Production Endpoints

### List Productions
```http
GET /productions?is_active=true
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "productions": [
      {
        "id": "880e8400-e29b-41d4-a716-446655440003",
        "company_id": "660e8400-e29b-41d4-a716-446655440001",
        "name": "The Nutcracker 2024",
        "start_date": "2024-11-01",
        "end_date": "2024-12-31",
        "is_active": true,
        "artist_count": 45,
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 2,
      "pages": 1
    }
  }
}
```

## Document Endpoints

### Upload Document
```http
POST /documents/upload
Authorization: Bearer <token>
Content-Type: multipart/form-data

FormData:
  - file: document.pdf
  - type: "contract"
  - metadata: {"production_id": "880e8400-e29b-41d4-a716-446655440003"}

Response: 201 Created
{
  "success": true,
  "data": {
    "document": {
      "id": "ff0e8400-e29b-41d4-a716-446655440011",
      "filename": "document.pdf",
      "size": 1048576,
      "mime_type": "application/pdf",
      "sharepoint_id": "SP-DOC-67890",
      "url": "https://api.bigliveportal.com/v1/documents/ff0e8400",
      "created_at": "2024-01-20T11:25:00Z"
    }
  }
}
```

### Get Document
```http
GET /documents/ff0e8400-e29b-41d4-a716-446655440011
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "document": {
      "id": "ff0e8400-e29b-41d4-a716-446655440011",
      "filename": "document.pdf",
      "download_url": "https://sharepoint.com/sites/biglive/...",
      "expires_at": "2024-01-20T12:25:00Z"
    }
  }
}
```

## Batch Operations

### Batch Create Expenses
```http
POST /expenses/batch
Authorization: Bearer <token>
Content-Type: application/json

{
  "expenses": [
    {
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "amount": 50.00,
      "category": "Transportation",
      "description": "Parking fee",
      "expense_date": "2024-01-18"
    },
    {
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "amount": 75.00,
      "category": "Meals",
      "description": "Team dinner",
      "expense_date": "2024-01-19"
    }
  ]
}

Response: 200 OK
{
  "success": true,
  "data": {
    "created": 2,
    "failed": 0,
    "expenses": [
      {
        "id": "110e8400-e29b-41d4-a716-446655440012",
        "amount": 50.00,
        "status": "draft"
      },
      {
        "id": "220e8400-e29b-41d4-a716-446655440013",
        "amount": 75.00,
        "status": "draft"
      }
    ]
  }
}
```

### Batch Approve Expenses
```http
POST /expenses/batch/approve
Authorization: Bearer <token>
Content-Type: application/json

{
  "expense_ids": [
    "bb0e8400-e29b-41d4-a716-446655440006",
    "cc0e8400-e29b-41d4-a716-446655440007"
  ],
  "notes": "Batch approved"
}

Response: 200 OK
{
  "success": true,
  "data": {
    "approved": 2,
    "failed": 0,
    "results": [
      {
        "id": "bb0e8400-e29b-41d4-a716-446655440006",
        "status": "approved",
        "xero_id": "XERO-BILL-12346"
      },
      {
        "id": "cc0e8400-e29b-41d4-a716-446655440007",
        "status": "approved",
        "xero_id": "XERO-BILL-12347"
      }
    ]
  }
}
```

## Search and Filtering

### Search Syntax
```http
GET /contracts?search=nutcracker&filter[status]=active&filter[amount][gte]=1000&sort=created_at:desc
```

### Supported Operators
- `eq`: Equals (default if no operator specified)
- `ne`: Not equals
- `gt`: Greater than
- `gte`: Greater than or equal
- `lt`: Less than
- `lte`: Less than or equal
- `in`: In array (comma-separated values)
- `like`: Pattern matching (% for wildcards)

### Examples
```http
# Find active contracts over $5000
GET /contracts?filter[status]=active&filter[amount][gt]=5000

# Find expenses in multiple categories
GET /expenses?filter[category][in]=Transportation,Meals

# Search for users by name
GET /users?search=sarah&filter[role]=artist

# Complex filtering with sorting
GET /schedules?filter[start_time][gte]=2024-01-20&filter[type]=rehearsal&sort=start_time:asc
```

## Reports Endpoints

### Expense Summary Report
```http
GET /reports/expense-summary?start_date=2024-01-01&end_date=2024-01-31&production_id=880e8400
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
        "total_expenses": 2450.75,
        "approved_expenses": 1875.50,
        "pending_expenses": 575.25,
        "expense_count": 47,
        "artist_count": 12
      },
      "by_category": [
        {
          "category": "Transportation",
          "amount": 850.25,
          "count": 23
        },
        {
          "category": "Meals",
          "amount": 625.50,
          "count": 15
        }
      ],
      "by_artist": [
        {
          "artist_id": "550e8400-e29b-41d4-a716-446655440000",
          "artist_name": "Sarah Chen",
          "total": 425.75,
          "count": 8
        }
      ]
    }
  }
}
```

### Contract Status Report
```http
GET /reports/contract-status?production_id=880e8400
Authorization: Bearer <token>

Response: 200 OK
{
  "success": true,
  "data": {
    "report": {
      "production": {
        "id": "880e8400-e29b-41d4-a716-446655440003",
        "name": "The Nutcracker 2024"
      },
      "summary": {
        "total_contracts": 45,
        "signed_contracts": 42,
        "pending_signatures": 3,
        "total_value": 225000.00
      },
      "details": [
        {
          "status": "active",
          "count": 42,
          "value": 210000.00
        },
        {
          "status": "pending_signature",
          "count": 3,
          "value": 15000.00
        }
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
| SERVICE_UNAVAILABLE | 503 | External service temporarily unavailable |
| INVALID_FILE_TYPE | 400 | Uploaded file type not supported |
| FILE_TOO_LARGE | 413 | File exceeds maximum size limit |
| DUPLICATE_ENTRY | 409 | Resource already exists |
| INVALID_STATUS_TRANSITION | 409 | Invalid status change requested |
| SHAREPOINT_ERROR | 502 | SharePoint integration error |
| SIGNATURE_FAILED | 502 | E-signature service error |
| XERO_SYNC_ERROR | 502 | Xero synchronization failed |

## Webhooks

Webhooks are supported for real-time event notifications to external systems.

### Webhook Registration
```http
POST /webhooks
Authorization: Bearer <token>
Content-Type: application/json

{
  "url": "https://your-domain.com/webhook",
  "events": ["contract.signed", "expense.approved"],
  "secret": "your-webhook-secret",
  "description": "Production system integration"
}

Response: 201 Created
{
  "success": true,
  "data": {
    "webhook": {
      "id": "330e8400-e29b-41d4-a716-446655440014",
      "url": "https://your-domain.com/webhook",
      "events": ["contract.signed", "expense.approved"],
      "is_active": true,
      "created_at": "2024-01-20T11:30:00Z"
    }
  }
}
```

### Webhook Payload Format
```json
{
  "event": "contract.signed",
  "timestamp": "2024-01-20T10:45:00Z",
  "data": {
    "contract": {
      "id": "990e8400-e29b-41d4-a716-446655440004",
      "artist_id": "550e8400-e29b-41d4-a716-446655440000",
      "production_id": "880e8400-e29b-41d4-a716-446655440003",
      "status": "active",
      "signed_at": "2024-01-20T10:45:00Z"
    },
    "artist": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "name": "Sarah Chen",
      "email": "sarah.chen@email.com"
    }
  },
  "webhook_id": "330e8400-e29b-41d4-a716-446655440014"
}
```

### Webhook Security
- Signature header: `X-Webhook-Signature`
- Signature format: `sha256=hash_of_payload_with_secret`
- Verification example:
```javascript
const crypto = require('crypto');
const signature = crypto
  .createHmac('sha256', webhookSecret)
  .update(JSON.stringify(payload))
  .digest('hex');
const isValid = `sha256=${signature}` === request.headers['x-webhook-signature'];
```

### Supported Webhook Events
- `user.created` - New user account created
- `user.activated` - User account activated
- `user.deactivated` - User account deactivated
- `contract.created` - New contract created
- `contract.assigned` - Contract assigned to artist
- `contract.signed` - Contract signed by artist
- `contract.expired` - Contract reached end date
- `expense.submitted` - Expense submitted for approval
- `expense.approved` - Expense approved for payment
- `expense.rejected` - Expense rejected with reason
- `expense.paid` - Expense marked as paid
- `schedule.created` - New schedule event created
- `schedule.updated` - Schedule event modified
- `schedule.cancelled` - Schedule event cancelled

## SDK Examples

### JavaScript/TypeScript
```javascript
const BIGLiveClient = require('@biglive/api-client');

const client = new BIGLiveClient({
  apiKey: 'your-api-key',
  baseUrl: 'https://api.bigliveportal.com/v1'
});

// Authentication
const { user, accessToken } = await client.auth.login({
  email: 'sarah.chen@email.com',
  password: 'securePassword123'
});

// List contracts
const contracts = await client.contracts.list({
  status: 'pending_signature',
  page: 1,
  limit: 20
});

// Submit expense
const expense = await client.expenses.create({
  production_id: '880e8400-e29b-41d4-a716-446655440003',
  amount: 125.50,
  category: 'Transportation',
  description: 'Taxi to venue',
  expense_date: '2024-01-20',
  receipts: [file1, file2]
});

// Get schedule with real-time updates
client.schedules.subscribe('880e8400-e29b-41d4-a716-446655440003', (event) => {
  console.log('Schedule updated:', event);
});
```

### Python
```python
from biglive import Client

client = Client(
    api_key='your-api-key',
    base_url='https://api.bigliveportal.com/v1'
)

# Authentication
auth_response = client.auth.login(
    email='sarah.chen@email.com',
    password='securePassword123'
)

# List expenses
expenses = client.expenses.list(
    status='submitted',
    page=1,
    limit=20
)

# Approve expense
approved = client.expenses.approve(
    expense_id='bb0e8400-e29b-41d4-a716-446655440006',
    notes='Approved for payment'
)

# Export calendar
calendar_url = client.schedules.export_calendar(format='ical')
```

## API Testing

### cURL Examples
```bash
# Authentication
curl -X POST https://api.bigliveportal.com/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"sarah.chen@email.com","password":"securePassword123"}'

# List contracts
curl -X GET https://api.bigliveportal.com/v1/contracts?status=pending_signature \
  -H "Authorization: Bearer YOUR_TOKEN"

# Create expense with receipts
curl -X POST https://api.bigliveportal.com/v1/expenses \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -F "production_id=880e8400-e29b-41d4-a716-446655440003" \
  -F "amount=125.50" \
  -F "category=Transportation" \
  -F "description=Taxi to venue" \
  -F "expense_date=2024-01-20" \
  -F "receipts[]=@receipt1.jpg" \
  -F "receipts[]=@receipt2.jpg"

# Update schedule
curl -X PUT https://api.bigliveportal.com/v1/schedules/dd0e8400-e29b-41d4-a716-446655440009 \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"start_time":"2024-01-22T19:00:00Z","notes":"Start time changed to 7 PM"}'
```

### Postman Collection
Download the complete Postman collection with all endpoints, example requests, and test scripts:
[BIG Live Portal API v1.0 Postman Collection](https://api.bigliveportal.com/v1/docs/postman-collection.json)

## Changelog

### Version 1.0 (Current)
- Initial API release
- Core authentication with JWT and optional Azure AD SSO
- User management with bulk import
- Contract management with e-signature integration
- Expense submission and approval workflows
- Schedule management with real-time updates
- SharePoint document integration
- Xero accounting integration
- Email and SMS notifications
- Comprehensive webhook support
- Mobile-optimized responses

### Planned Features
- GraphQL endpoint for flexible querying
- WebSocket support for real-time updates
- Advanced reporting API with custom report builder
- Batch operations for all resources
- API versioning headers
- Rate limit bypass for premium organizations
- OAuth 2.0 support for third-party apps
- Audit log access API
- Multi-language response support

## Clarification Requests or Feedback

1. **SharePoint Integration Depth**: While the API includes SharePoint document storage, specific details about folder structures, permissions inheritance, and metadata requirements would help optimize the integration endpoints.

2. **E-signature Provider Selection**: The API supports both DocuSign and Adobe Sign, but understanding the preferred provider would allow for deeper integration features and better error handling specific to that platform.

3. **Xero Workflow Details**: The current implementation creates bills in Xero upon expense approval. Clarification on whether these should be draft bills, approved bills, or trigger actual payment runs would refine the integration.

4. **Real-time Update Frequency**: For schedule updates and notifications, understanding the expected latency requirements (immediate vs. within minutes) would help design the WebSocket vs. polling strategy.

5. **Bulk Operation Limits**: Setting specific limits for bulk operations (e.g., max 100 expenses per batch) would help prevent system overload and ensure consistent performance.

6. **File Storage Duration**: For uploaded receipts and temporary documents, understanding retention requirements would help design appropriate cleanup processes and storage strategies.

7. **API Rate Limiting Flexibility**: Some organizations may need higher rate limits during peak periods (e.g., contract season). Understanding if dynamic rate limiting is needed would inform the rate limiting architecture.

8. **Timezone Handling**: While the API uses UTC timestamps, clarification on how touring productions across timezones should be handled would improve the schedule management endpoints.

9. **Webhook Retry Logic**: Defining the retry strategy for failed webhook deliveries (number of retries, backoff algorithm) would ensure reliable event delivery.

10. **Archive vs. Delete**: Understanding whether deleted items should be soft-deleted (archived) or hard-deleted would impact the API design and compliance requirements.