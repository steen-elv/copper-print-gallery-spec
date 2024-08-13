# ADR: Hybrid Deployment Strategy with Unified API Gateway for Copper Print Gallery

## Date
2024-07-31 (Updated: 2024-08-02)

## Status
Proposed

## Context
The Copper Print Gallery system needs a deployment environment that is cost-effective, scalable, and manageable. Our initial decision to use Heroku for all services proved to be more expensive than anticipated. We decided on a hybrid approach using Heroku for public-facing services and AWS Lambda for backend services. Now, we need to determine the best way to manage API routing across this hybrid architecture.

## Decision
We have decided to:
1. Use Heroku for public-facing services (Web Application, Artist Web Application)
2. Use AWS Lambda for backend services (Content Management Service, Search Service, Image Processing Service)
3. Use Amazon API Gateway as the primary API Gateway for all services, including both AWS Lambda and Heroku-based services

## Rationale
1. Cost-Effectiveness: This hybrid approach leverages the cost benefits of serverless architecture for backend services while maintaining Heroku's simplicity for public-facing components.
2. Scalability: AWS Lambda and Amazon API Gateway can automatically scale to handle varying loads.
3. Unified API Management: Using Amazon API Gateway for all services provides a single point of control for API routing, security, and monitoring.
4. Consistency: A single API Gateway simplifies client-side integration and provides a uniform way to handle authentication, rate limiting, and other cross-cutting concerns.
5. Advanced Features: Amazon API Gateway offers features like request throttling, API keys, and detailed monitoring out of the box.

## Implementation Strategy
1. Deploy Web Application and Artist Web Application on Heroku.
2. Implement Content Management Service, Search Service, and Image Processing Service as AWS Lambda functions.
3. Set up Amazon API Gateway as the primary entry point for all API requests:
    - Configure routes for Lambda-based services directly to the respective Lambda functions.
    - Set up routes for Heroku-based services to proxy requests to the Heroku applications.
4. Use AWS S3 for file storage (as previously decided).
5. Implement VPC peering or AWS PrivateLink to securely connect Heroku and AWS environments.
6. Update CI/CD pipelines to handle deployments to Heroku, AWS Lambda, and API Gateway configuration updates.
7. Implement comprehensive logging and monitoring across both environments, centralizing logs where possible.

## Consequences

### Positive
- Unified API management across the hybrid architecture.
- Improved scalability and performance for API routing.
- Enhanced security features through Amazon API Gateway.
- Flexibility to easily add or modify API routes as the system evolves.

### Negative
- Increased complexity in the overall system architecture.
- Potential latency increase for Heroku-based services due to additional routing hop.
- Learning curve for team members not familiar with Amazon API Gateway.

### Risks
- Potential single point of failure if API Gateway issues occur.
- Complexity in debugging issues that span across AWS and Heroku environments.
- Possible increased costs if API Gateway usage grows significantly.

## Mitigation Strategies
- Implement thorough monitoring and alerting for the API Gateway.
- Conduct performance testing to ensure acceptable latency for all service routes.
- Provide team training on Amazon API Gateway configuration and best practices.
- Regularly review and optimize API Gateway usage to manage costs.

## Specific Service Considerations
1. Content Management Service and Search Service:
    - These services can be implemented as Lambda functions without significant changes to their API designs.
    - Elasticsearch integration for the Search Service can be achieved using Amazon Elasticsearch Service, which integrates well with Lambda.

2. Image Processing Service:
    - The existing asynchronous design of the process endpoint aligns well with Lambda's execution model.
    - Ensure Lambda functions have sufficient execution time for processing tasks.
    - Use services like DynamoDB for job status tracking if needed.

## Alternatives Considered
1. Using separate API Gateways for AWS and Heroku services: Rejected to maintain a unified API management approach.
2. Full migration to AWS (including frontend services): Rejected to minimize disruption and leverage existing Heroku knowledge for frontend services.

## Related Decisions
- Configuration Management Strategy
- Logging and Monitoring Strategy
- Use of Amazon S3 for file storage

## References
- Amazon API Gateway: [https://aws.amazon.com/api-gateway/](https://aws.amazon.com/api-gateway/)
- AWS Lambda: [https://aws.amazon.com/lambda/](https://aws.amazon.com/lambda/)
- Heroku: [https://www.heroku.com/](https://www.heroku.com/)
- Integrating Amazon API Gateway with Heroku: [https://aws.amazon.com/blogs/compute/using-amazon-api-gateway-as-a-proxy-for-your-heroku-web-app/](https://aws.amazon.com/blogs/compute/using-amazon-api-gateway-as-a-proxy-for-your-heroku-web-app/)