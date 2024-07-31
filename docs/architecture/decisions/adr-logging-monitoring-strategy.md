# ADR: Use Heroku's Built-in Logging and Monitoring Tools for Copper Print Gallery

## Date
2024-07-31

## Status
Proposed

## Context
The Copper Print Gallery system requires logging and monitoring capabilities to ensure system health and facilitate troubleshooting. The system is small-scale (less than 100 daily users, one artist) and has a single artist with direct access to system management. The system requirements specify that we should design and implement based on current known requirements, without specific provisions for future expansion.

## Decision
We have decided to use Heroku's built-in logging and monitoring tools without any additional add-ons for the initial deployment of the Copper Print Gallery system.

## Rationale
1. Scale Appropriateness: Heroku's basic tools are sufficient for our current small-scale system.
2. Simplicity: Built-in tools require minimal setup and maintenance.
3. Cost-Effectiveness: Avoiding additional add-ons keeps costs down for the initial deployment.
4. Fast Feedback: With only one artist managing the system, we can expect quick feedback on any issues.
5. Alignment with Requirements: This approach adheres to the specification of implementing based on current known requirements.
6. Flexibility: We can easily extend or replace this solution if it proves inadequate in production.

## Consequences

### Positive
- Simplified system management with integrated logging and monitoring.
- Reduced initial complexity and cost.
- Easier debugging and troubleshooting through Heroku's dashboard and CLI.
- Sufficient for identifying common issues like application crashes or performance problems.

### Negative
- Limited log retention (typically 1500 most recent lines).
- Basic alerting capabilities may not cover all potential scenarios.
- Potential lack of detailed insights into custom metrics or specific component behavior.

### Risks
- Possibility of missing critical issues due to limited monitoring capabilities.
- May need to implement a more robust solution sooner than anticipated if problems arise.

## Implementation Notes
1. Ensure all services in the Copper Print Gallery system log important events and errors to stdout/stderr for Heroku to capture.
2. Implement meaningful log messages, especially for critical operations like image processing.
3. Use Heroku's dashboard and CLI tools to regularly check logs and system metrics.
4. Set up basic alerts through Heroku for critical issues like application crashes.
5. Document the logging approach for all team members, including how to access and interpret logs.
6. Establish a process for the artist to report any issues or unexpected behavior promptly.

## Monitoring Plan
1. Daily: Quick check of Heroku dashboard for any obvious issues.
2. Weekly: More detailed review of logs and performance metrics.
3. Monthly: Comprehensive system health check and discussion with the artist about any concerns.

## Future Considerations
- If logging proves inadequate in production, consider implementing a log drain to an external service for longer retention and more advanced analysis.
- Regularly reassess the need for more advanced monitoring tools based on system performance and the artist's feedback.
- Be prepared to quickly implement additional monitoring solutions if critical issues arise that are not easily diagnosed with the current tools.

## Alternatives Considered
1. Implementing a full ELK (Elasticsearch, Logstash, Kibana) stack: Deemed overly complex for current needs.
2. Using third-party monitoring add-ons (e.g., New Relic, Datadog): Considered unnecessary given the current system scale and requirements.

## Related Decisions
- Heroku Deployment Strategy for Copper Print Gallery
- System requirements specification
- Overall system architecture (C4 container and component diagrams)

## References
- Heroku Logging: [https://devcenter.heroku.com/articles/logging](https://devcenter.heroku.com/articles/logging)
- Heroku Metrics: [https://devcenter.heroku.com/articles/metrics](https://devcenter.heroku.com/articles/metrics)
