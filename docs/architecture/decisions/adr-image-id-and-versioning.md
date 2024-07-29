# ADR: Image ID Assignment and Versioning for Copper Print Gallery

## Date
2024-07-27

## Status
Proposed

## Context
The Copper Print Gallery system needs to manage multiple versions of images (original, thumbnail, medium, large, etc.) while maintaining a clear relationship between these versions. We need to decide how to assign IDs to images and how to handle versioning in a way that is both efficient and easy to manage across different services.

## Decision
We have decided on the following approach for image ID assignment and versioning:

1. Image ID Assignment:
   - The Content Management Service will be responsible for assigning the base image ID.
   - This ID will be a unique identifier (e.g., UUID) generated when a new image upload is initiated.
   - The Content Management Service will pass this ID to the Image Processing Service when requesting processing.

2. Image Versioning:
   - Different versions of the same image will share the same base image ID.
   - Each version will be differentiated by appending a version identifier to the base ID.
   - The structure will be: `{Base Image ID}_{Version Identifier}`
   - Example:
     - Original: `123e4567-e89b-12d3-a456-426614174000_original`
     - Thumbnail: `123e4567-e89b-12d3-a456-426614174000_thumbnail`

## Consequences

### Positive
- Clear relationship between different versions of the same image.
- Unique identification for each image version.
- Simplified management of image metadata in the Content Management Service.
- Consistent ID structure across all services.
- Easier tracking of image processing status and results.

### Negative
- Slightly longer IDs due to the inclusion of version identifiers.
- Need for careful handling of the composite ID structure in all services that interact with images.

### Risks
- Potential for confusion if the versioning scheme is not clearly communicated to all developers.
- Need to ensure that all services parse and handle the composite IDs correctly.

## Implementation Notes
- The Content Management Service should implement a robust ID generation mechanism (e.g., using UUID v4).
- All services that handle images should be updated to work with the new ID structure.
- Documentation should be updated to clearly explain the ID and versioning scheme.
- Consider creating a shared utility for parsing and creating these composite IDs to ensure consistency.

## Related Decisions
- Choice of image processing workflow
- Definition of image version names and properties

## References
- UUID specification: [RFC 4122](https://tools.ietf.org/html/rfc4122)
- System requirements specification: [link to relevant document]
