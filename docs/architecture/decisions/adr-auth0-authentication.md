# ADR: Use Auth0 for Artist Authentication in Copper Print Gallery

## Date
2024-07-31

## Status
Proposed

## Context
The Copper Print Gallery system requires a secure authentication solution for the artist to manage content. Public users will browse the gallery anonymously and do not require authentication. Given our choice of Heroku as the deployment platform and the small scale of our system (less than 100 daily anonymous users, one authenticated artist), we need to evaluate the best authentication solution for our needs.

## Decision
We have decided to use Auth0 for handling artist authentication in the Copper Print Gallery system.

## Rationale
1. Ease of Integration: Auth0 offers straightforward integration with Heroku, our chosen deployment platform.
2. Managed Service: Auth0 provides a fully managed authentication service, reducing operational overhead.
3. Scale Appropriateness: Auth0's free or lower-tier plans are sufficient for our current small scale (single artist authentication).
4. Feature Set: Auth0 offers a rich set of out-of-the-box features (MFA, password policies) that can enhance security for artist access.
5. Developer Experience: Auth0 is known for its developer-friendly approach and extensive documentation.
6. Simplicity: Aligns with our goal of keeping the system simple and easy to maintain.

## Consequences

### Positive
- Simplified deployment and configuration process with Heroku.
- Reduced operational overhead due to managed service.
- Strong security features available for protecting artist access.
- Extensive documentation and support available.
- Easy scalability if we need to add more authenticated users in the future.

### Negative
- Potential increase in costs if we need to add many authenticated users in the future.
- Some level of vendor lock-in to Auth0.

### Risks
- Migration complexity if we decide to move away from Auth0 in the future.
- Potential for over-reliance on Auth0-specific features.

## Implementation Notes
1. Sign up for an Auth0 account and create a new application for Copper Print Gallery artist access.
2. Design the authentication flow for the artist using Auth0.
3. Plan for secure storage of Auth0 credentials using Heroku Config Vars.
4. Consider Auth0's role and permission structure for potential future expansion of authenticated users.

## Alternatives Considered
1. Keycloak: Open-source solution offering more control but requiring more management.
2. Okta: Similar to Auth0, but Auth0 was preferred due to better documentation and developer experience.

## Related Decisions
- Choice of Heroku as deployment platform
- System requirements specification

## References
- Auth0 Documentation: [https://auth0.com/docs/](https://auth0.com/docs/)
- Heroku and Auth0 Integration Guide: [https://devcenter.heroku.com/articles/auth0](https://devcenter.heroku.com/articles/auth0)