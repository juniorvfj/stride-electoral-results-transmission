# Architecture Artifacts

This directory contains the architectural artifacts associated with **Figure 1** of the paper, which represents the reference architecture used to support the STRIDE-based threat modeling of the **results transmission phase** in an electronic voting context.

## What the figure represents

The figure depicts the logical architecture adopted as the basis for the threat-modeling exercise presented in the article. It shows the main components involved in the transmission pipeline, the relevant communication flows between them, and the interfaces through which files, metadata, credentials, and validation steps are exchanged.

The diagram was used to identify assets, data flows, entry points, dependencies, and trust boundaries that are necessary for systematic threat elicitation under the STRIDE model.

## Architectural scope covered

The architectural scope is intentionally limited to the **results transmission stage**, rather than the entire electronic voting ecosystem. Accordingly, the diagram focuses on the subset of components and interactions required to move result-related artifacts from the generation and submission points to the collection, validation, storage, and processing services involved in this phase.

The figure includes, at a high level:

- user-side and institutional interaction points;
- application and API layers;
- cloud and storage services;
- validation and processing components;
- supporting services for authentication, secrets, metadata, and messaging;
- trust boundaries relevant to the security analysis.

This scoped representation was designed to support a focused security analysis of a critical operational stage, where authenticity, integrity, availability, traceability, and chain of custody are especially important.

## Editable source for legibility and reuse

The editable source file  
`figure-01-result-transmission-architecture-highres.excalidraw`  
is provided to improve **legibility**, **transparency**, and **reuse**.

Because the complete architecture contains multiple components, flows, and annotations, the static figure embedded in the paper may not always offer sufficient readability in the final PDF layout. Making the editable `.excalidraw` source available allows reviewers and readers to:

- zoom in without loss of semantic structure;
- inspect labels, flows, and component names more comfortably;
- verify trust boundaries and architectural relationships in detail;
- adapt or reuse the diagram structure in future academic or technical analyses, subject to repository terms.

## Preferred artifact for detailed inspection

For reviewers and readers who need to inspect the architecture in detail, the preferred artifact is the high-resolution version of the figure:

`figure-01-result-transmission-architecture-highres`

This high-resolution file should be used when the goal is to closely examine:

- components and their roles;
- communication flows and interaction paths;
- storage and processing points;
- authentication and validation steps;
- trust boundaries relevant to threat modeling.

The high-resolution artifact is the recommended reference for visual inspection, while the `.excalidraw` file is the recommended reference for editable access and deeper exploration of the diagram structure.
```

Se quiser, eu também posso te entregar uma versão **mais curta e mais “acadêmica”**, caso você queira um README mais enxuto.
