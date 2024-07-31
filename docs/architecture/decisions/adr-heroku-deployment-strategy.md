# ADR: Heroku Deployment Strategy for Copper Print Gallery

## Date
2024-07-31

## Status
Proposed

## Context
The Copper Print Gallery system needs a deployment environment that is easy to manage, cost-effective, and suitable for a small-scale application (less than 100 daily users, one artist). We are starting from scratch with no existing infrastructure, and scaling is not a priority in the foreseeable future.

## Decision
We have decided to use Heroku as the deployment platform for the Copper Print Gallery system.

## Rationale
1. Simplicity: Heroku offers a straightforward deployment process with minimal DevOps knowledge required.
2. Managed Services: Heroku provides managed PostgreSQL, which aligns with our database needs.
3. Cost-Effectiveness: At our current scale, we can likely utilize Heroku's lower-tier plans, which are reasonably priced.
4. Easy Deployment: Heroku integrates well with Git, allowing for simple deployments directly from our repository.
5. Add-ons Ecosystem: Heroku's wide range of add-ons for services like logging and monitoring can be easily integrated as needed.
6. Scalability: While not an immediate concern, Heroku allows for easy vertical and horizontal scaling if needed in the future.

## Consequences

### Positive
- Reduced operational overhead due to platform management by Heroku.
- Quick and easy deployment process.
- Built-in support for many of our required services (PostgreSQL).
- Basic monitoring and logging through Heroku's dashboard.
- Improved consistency and reproducibility of our infrastructure setup across different environments.
- Easier management of infrastructure changes over time.

### Negative
- Potential for higher costs if the application scales significantly.
- Less fine-grained control over the infrastructure compared to IaaS solutions.
- Some level of vendor lock-in to Heroku's ecosystem.

### Risks
- Dependency on Heroku's uptime and reliability.
- Potential challenges if we need to migrate away from Heroku in the future.
- Basic logging and monitoring tools may need to be supplemented for more advanced needs.

## Implementation Strategy
1. Set up a Heroku account for the Copper Print Gallery project.
2. Use Terraform to define and manage our Heroku infrastructure:
    - Define Heroku apps for each service (or a single app with multiple processes, depending on our final architecture decision).
    - Set up Heroku PostgreSQL add-on for the database.
    - Configure environment variables for service-specific configurations.
    - Define and manage Heroku buildpacks, including the Python buildpack for the Image Processing Service.
3. Use Terraform to set up and manage the Amazon S3 bucket for file storage.
4. Store sensitive credentials (like S3 access keys) in Heroku Config Vars, managed through Terraform.
5. Implement a CI/CD pipeline that uses Terraform for infrastructure changes and Heroku's Git integration for application deployments.
6. Utilize Heroku's basic logging and monitoring tools, with the understanding that we may need to supplement these with more advanced solutions in the future.

## Alternatives Considered
1. Traditional VPS: Offers more control but requires more hands-on management.
2. Kubernetes (e.g., k3s on a single node): Provides container orchestration benefits but might be overly complex for our current needs.
3. Managed Container Service (e.g., AWS ECS with Fargate): Offers good scalability but might be more complex and potentially more expensive for our current scale.
4. Heroku CLI and Heroku.yml: While simpler, using Terraform provides more powerful infrastructure-as-code capabilities and aligns with our team's expertise.

## Related Decisions
- Use Auth0 for Artist Authentication in Copper Print Gallery
- Use PostgreSQL as Database for Copper Print Gallery
- Use Amazon S3 for File Storage in Copper Print Gallery
- System requirements specification
- Use Terraform for Infrastructure Management in Copper Print Gallery

## References
- Heroku Documentation: [https://devcenter.heroku.com/](https://devcenter.heroku.com/)
- Heroku Postgres: [https://www.heroku.com/postgres](https://www.heroku.com/postgres)
- Deploying Node.js Apps on Heroku: [https://devcenter.heroku.com/articles/deploying-nodejs](https://devcenter.heroku.com/articles/deploying-nodejs)
- Heroku Python Support: [https://devcenter.heroku.com/articles/python-support](https://devcenter.heroku.com/articles/python-support)
- Terraform Heroku Provider: [https://registry.terraform.io/providers/heroku/heroku/latest/docs](https://registry.terraform.io/providers/heroku/heroku/latest/docs)
- Terraform Documentation: [https://www.terraform.io/docs](https://www.terraform.io/docs)
