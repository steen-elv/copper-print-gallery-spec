# ADR: Hybrid Deployment Strategy for Copper Print Gallery

## Date
2024-07-31 (Updated: 2024-08-01)

## Status
Proposed

## Context
The Copper Print Gallery system needs a deployment environment that is easy to manage, cost-effective, and suitable for a small-scale application (less than 100 daily users, one artist). Our initial decision to use Heroku for all services proved to be more expensive than anticipated, requiring an Enterprise license to comply with all our ADRs.

## Decision
We have decided to adopt a hybrid deployment strategy:
1. Use Heroku for public-facing services (Web Application, Artist Web Application, API Gateway)
2. Use AWS Lambda for backend services with no public API (Content Management Service, Search Service, Image Processing Service)

## Rationale
1. Cost-Effectiveness: This hybrid approach allows us to leverage the cost benefits of serverless architecture for less-frequently accessed backend services while maintaining Heroku's simplicity for public-facing components.
2. Scalability: AWS Lambda can automatically scale to handle varying loads, which aligns well with the system's current small scale but allows for future growth.
3. Flexibility: This approach gives us the flexibility to optimize each service based on its specific needs and usage patterns.
4. Minimal Disruption: Keeping public-facing services on Heroku minimizes changes to those components and maintains some consistency with our original plan.

## Consequences

### Positive
- Reduced overall costs compared to full Heroku deployment.
- Improved scalability for backend services.
- Maintains the simplicity of Heroku for public-facing components.

### Negative
- Increased complexity in deployment and management.
- Need for expertise in both Heroku and AWS Lambda.
- Potential latency issues between Heroku and Lambda services.

### Risks
- Increased complexity in the overall system architecture.
- Potential challenges in maintaining consistency across different environments.
- May require changes to some services to fit the Lambda execution model.

## Implementation Strategy
1. Keep Web Application, Artist Web Application, and API Gateway on Heroku.
2. Migrate Content Management Service, Search Service, and Image Processing Service to AWS Lambda.
3. Set up AWS API Gateway to manage requests to Lambda functions.
4. Use AWS S3 for file storage (as previously decided).
5. Implement VPC peering or AWS PrivateLink to securely connect Heroku and AWS environments.
6. Update CI/CD pipelines to handle deployments to both Heroku and AWS Lambda.
7. Implement comprehensive logging and monitoring across both environments.

## Alternatives Considered
1. Full Heroku Enterprise deployment: Rejected due to high costs.
2. Migration to a different single cloud provider: Rejected to minimize disruption and leverage existing Heroku knowledge.

## Related Decisions
- Configuration Management Strategy
- Logging and Monitoring Strategy
- Use of Amazon S3 for file storage

## References
- Heroku Documentation: [https://devcenter.heroku.com/](https://devcenter.heroku.com/)
- AWS Lambda Documentation: [https://docs.aws.amazon.com/lambda/](https://docs.aws.amazon.com/lambda/)
- Serverless Framework: [https://www.serverless.com/](https://www.serverless.com/)