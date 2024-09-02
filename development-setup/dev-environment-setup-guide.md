# Development Environment Setup Guide for Copper Print Gallery

## Prerequisites

- Git
- Docker and Docker Compose
- Node.js (Latest LTS version)
- Python 3.8+
- AWS CLI
- Heroku CLI
- Terraform

## Setup Steps

1. Clone the repositories:
   ```bash
   git clone https://github.com/your-org/copper-print-gallery-public-web.git
   git clone https://github.com/your-org/copper-print-gallery-artist-web.git
   git clone https://github.com/your-org/copper-print-gallery-content-service.git
   git clone https://github.com/your-org/copper-print-gallery-search-service.git
   git clone https://github.com/your-org/copper-print-gallery-image-service.git
   git clone https://github.com/your-org/copper-print-gallery-infrastructure.git
   git clone https://github.com/your-org/copper-print-gallery-api-gateway.git
   ```

2. Set up local environment variables:
   - Copy the `.env.example` file in each repository to `.env`
   - Fill in the necessary values (consult with your team lead for any sensitive information)

3. Start the local development environment:
   ```bash
   docker-compose up -d
   ```

4. Initialize the local database:
   ```bash
   docker-compose exec db psql -U postgres -f /init-scripts/init.sql
   ```

5. Set up local AWS environment:
   - Configure AWS CLI with provided local credentials
   - Initialize LocalStack:
     ```bash
     aws --endpoint-url=http://localhost:4566 s3 mb s3://local-bucket
     ```

6. Set up local Auth0 tenant:
   - Follow the Auth0 setup guide in the documentation repository

7. Start the frontend applications:
   ```bash
   cd copper-print-gallery-public-web
   npm install
   npm start

   cd ../copper-print-gallery-artist-web
   npm install
   npm start
   ```

8. Access the local environments:
   - Public Web: http://localhost:3000
   - Artist Web: http://localhost:3001
   - API Gateway: http://localhost:4566
   - LocalStack Dashboard: http://localhost:8080

## Running Tests

- For frontend applications:
  ```bash
  npm test
  ```
- For backend services:
  ```bash
  docker-compose run --rm content-service npm test
  docker-compose run --rm search-service npm test
  docker-compose run --rm image-service python -m pytest
  ```

## Troubleshooting

- If you encounter any issues with Docker networking, try the following:
  ```bash
  docker-compose down -v
  docker-compose up -d
  ```
- For any other issues, consult the FAQ section in the documentation repository or reach out to the DevOps team.

