# ADR: Configuration Management through Environment Variables and Terraform

## Date
2024-07-31

## Status
Proposed

## Context
The Copper Print Gallery system requires a method to manage configuration across its services. Initially, we considered implementing a separate Configuration Service. However, given our relatively small number of services, our choice of Heroku as a deployment platform, and our use of Terraform for infrastructure management, we need to reassess this approach.

## Decision
We have decided to manage configuration through Heroku environment variables and Terraform, rather than implementing a separate Configuration Service.

## Rationale
1. Simplicity: With a small number of services, duplicating configuration is simpler than maintaining a separate service.
2. Alignment with Deployment Environment: Heroku's environment variables provide a straightforward way to manage configuration for each service.
3. Infrastructure as Code: Terraform allows us to version control our configuration alongside our infrastructure definition.
4. Reduced Dependencies: Eliminating the Configuration Service reduces inter-service dependencies, potentially improving system resilience.
5. Performance: Direct access to configuration within each service eliminates network calls, potentially improving performance.
6. Scalability: This approach is manageable for the current scale of the Copper Print Gallery system.

## Implementation Approach
1. Define common configuration (e.g., image version definitions) in a shared Terraform module.
2. Use this module in the Terraform configurations for each service that needs the common config.
3. Apply service-specific configurations directly in each service's Terraform configuration.
4. Use Heroku environment variables to inject these configurations into each service at runtime.
5. Implement a simple configuration loading mechanism in each service to read from environment variables.

## Consequences

### Positive
- Simplified system architecture by removing a separate Configuration Service.
- Direct alignment with our Heroku deployment strategy and Terraform usage.
- Improved performance due to local configuration access.
- Easier deployment and testing of configuration changes.

### Negative
- Potential for configuration drift if not managed carefully.
- Duplication of configuration across services.
- May require more effort to update configuration across all services.

### Risks
- As the system grows, this approach may become more difficult to manage.
- Inconsistencies could arise if configuration updates are not applied uniformly across all services.

## Mitigation Strategies
- Implement strict processes for updating configuration to ensure consistency.
- Regularly audit configurations across services to detect and correct any inconsistencies.
- Consider implementing a simple shared library for configuration loading to ensure consistent handling across services.

## Alternatives Considered
1. Separate Configuration Service: Rejected due to added complexity and unnecessary network calls for our current scale.
2. Distributed Configuration Store (e.g., etcd): Considered overly complex for our current needs.

## Related Decisions
- Heroku Deployment Strategy for Copper Print Gallery
- Use Terraform for Infrastructure Management in Copper Print Gallery
- Overall system architecture and service decomposition (C4 container and component diagrams)

## References
- Heroku Config Vars: [https://devcenter.heroku.com/articles/config-vars](https://devcenter.heroku.com/articles/config-vars)
- Terraform Heroku Provider: [https://registry.terraform.io/providers/heroku/heroku/latest/docs](https://registry.terraform.io/providers/heroku/heroku/latest/docs)
