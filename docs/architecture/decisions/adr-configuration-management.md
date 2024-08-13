# ADR: Configuration Management for Hybrid Deployment

## Date
2024-07-31 (Updated: 2024-08-01)

## Context
The Copper Print Gallery system requires a method to manage configuration across its services. With our decision to adopt a hybrid deployment strategy using both Heroku and AWS Lambda, we need to reassess our configuration management approach.

## Decision
We have decided to use a combination of Heroku Config Vars and AWS Systems Manager Parameter Store for configuration management:

1. For Heroku-deployed services: Continue using Heroku Config Vars.
2. For AWS Lambda functions: Use AWS Systems Manager Parameter Store.
3. Implement a unified configuration loading mechanism in our application code to abstract the source of configuration.

## Rationale
1. Consistency with Platforms: This approach aligns with the best practices for each platform.
2. Security: Both Heroku Config Vars and AWS Systems Manager Parameter Store provide secure ways to store sensitive configuration data.
3. Scalability: AWS Systems Manager Parameter Store can handle configuration for multiple Lambda functions efficiently.
4. Ease of Management: Both systems provide easy-to-use interfaces for managing configuration.

## Implementation Approach
1. For Heroku services:
    - Continue using Heroku Config Vars for configuration.
    - Use Terraform to manage Heroku Config Vars.

2. For AWS Lambda functions:
    - Store configuration in AWS Systems Manager Parameter Store.
    - Use Terraform to manage Parameter Store entries.

3. Application code:
    - Implement a unified configuration loading mechanism that can fetch from either Heroku Config Vars or AWS Systems Manager Parameter Store based on the deployment environment.
    - Use environment variables to indicate the deployment environment (Heroku or AWS).

4. Shared Configuration:
    - For configuration that needs to be shared across both environments, store in both Heroku Config Vars and AWS Systems Manager Parameter Store.
    - Implement a synchronization mechanism to ensure consistency.

5. Local Development:
    - Use dotenv files to mimic both Heroku Config Vars and AWS Systems Manager Parameter Store locally.

## Consequences

### Positive
- Aligned with best practices for each platform.
- Secure storage of configuration data.
- Flexibility to manage configuration for different environments.

### Negative
- Increased complexity in managing configuration across two systems.
- Need for a custom configuration loading mechanism in application code.

### Risks
- Potential for configuration inconsistencies between environments.
- Increased overhead in maintaining synchronization for shared configuration.

## Mitigation Strategies
- Implement automated tests to verify configuration consistency across environments.
- Use Terraform to manage configuration for both platforms, ensuring version control and consistency.
- Regularly audit configurations to detect and correct any inconsistencies.

## Alternatives Considered
1. Using only AWS Systems Manager Parameter Store for all services: Rejected to maintain alignment with Heroku best practices for Heroku-deployed services.
2. Implementing a custom Configuration Service: Considered overly complex for our current needs.

## Related Decisions
- Hybrid Deployment Strategy
- Use of Terraform for Infrastructure Management

## References
- Heroku Config Vars: [https://devcenter.heroku.com/articles/config-vars](https://devcenter.heroku.com/articles/config-vars)
- AWS Systems Manager Parameter Store: [https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
- Terraform AWS Provider: [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)