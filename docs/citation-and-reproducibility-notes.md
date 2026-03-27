# Citation and Reproducibility Notes

This document provides guidance on how the repository should be interpreted in relation to the article, especially with respect to transparency, reproducibility, and citation.

## Purpose of this repository

This repository was created as a companion resource to the article. Its role is to improve transparency by making available selected artifacts that support the study but could not be fully detailed in the manuscript due to page limitations.

These artifacts include:

- the architectural diagram used as the basis for STRIDE-based threat elicitation;
- the editable source of the architecture diagram;
- the bibliographic search strings;
- the source exports from Scopus and Web of Science;
- the merged and normalized corpus files;
- scripts used in consolidation, enrichment, clustering, and ranking;
- bibliometric analysis outputs and related documentation.

The repository should therefore be read as a reproducibility-oriented supplement, not as a substitute for the article itself.

## Reproducibility scope

The repository supports **partial and practical reproducibility** of the literature-support and artifact-inspection workflow presented in the paper.

More specifically, it enables readers to inspect:

- which architectural view supported the threat-modeling exercise;
- which search dimensions and strings were used to retrieve the bibliographic corpus;
- how the corpus was merged, normalized, enriched, and ranked;
- which intermediate files were produced during that process.

At the same time, some limitations apply.

## Important limitations

### 1. Database dynamics

Scopus and Web of Science are dynamic indexing platforms. As a result, rerunning the same search strings at a different time may produce:

- different numbers of retrieved documents;
- metadata variations;
- changes in indexing coverage.

For this reason, the repository preserves the executed search strings and the exported raw files corresponding to the time at which the searches were actually performed.

### 2. Ranking is decision support, not automatic selection

The enrichment, ranking, and relevance-grouping workflow documented in this repository was used to support corpus screening and prioritization. These steps were not intended to replace qualitative expert judgment.

Final selection decisions depended on scope alignment, methodological usefulness, and relevance to the article's focus on the transmission of electoral results.

### 3. Bibliographic support is not the sole methodological basis

Although the repository documents the bibliographic workflow in detail, the core contribution of the article is not derived exclusively from literature processing.

The main analytical basis of the paper remains:

- the delimitation of the transmission stage as the system-of-interest;
- the architectural decomposition of that stage;
- the identification of assets, flows, and trust boundaries;
- the elicitation and organization of threats using STRIDE.

The literature workflow serves as support for requirements, methodological positioning, and related-work analysis.

### 4. Separate location of the proof of concept

The empirical proof of concept referenced in the article is maintained in a separate repository:

- `https://github.com/reinermaia/poc-stride-electoral/tree/main`

This repository therefore does not aim to centralize every project artifact in one place. Instead, it focuses on architecture, methodology, and article-support documentation, while the POC repository contains the experimental implementation artifacts.

## Citation notes

When referring to the study in academic or technical contexts, the article itself should be treated as the primary scholarly reference.

This repository may be cited as a companion or supplementary artifact repository when the discussion specifically involves:

- architecture artifacts;
- reproducibility materials;
- search strings and bibliographic workflow;
- corpus-processing files;
- supplementary methodological documentation.

In general, the article should remain the main object of citation, while this repository may be referenced as a supporting source of supplementary materials.

## Transparency intent

The purpose of exposing these materials is to:

- improve traceability of methodological choices;
- facilitate inspection of the architectural artifacts;
- allow reviewers and readers to better understand how the bibliographic support corpus was assembled;
- reduce ambiguity regarding the origin of intermediate methodological outputs.

This transparency objective is especially relevant in studies that combine architectural reasoning, security threat modeling, and literature-supported analytical framing.

## Practical reading guidance

Readers may use the repository in the following order:

1. read the article for the main argument and results;
2. inspect `architecture/` for the visual and editable architecture artifacts;
3. inspect `methodology/` for the bibliographic workflow and intermediate outputs;
4. inspect the external POC repository for the empirical validation artifacts.

This order helps preserve the distinction between the paper's narrative contribution and the supporting materials made available for inspection and reproducibility.

## Final note

This repository was organized to support academic transparency and artifact availability. It should be understood as a structured companion to the article, intended to make the supporting materials easier to inspect, interpret, and reference.
