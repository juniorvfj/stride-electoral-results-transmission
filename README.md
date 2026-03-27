# Threat Modeling in the Transmission of Results of an Electronic Voting System Using STRIDE

This repository provides the supplementary artifacts associated with the study on STRIDE-based threat modeling for the transmission of results in an electronic voting context. Its purpose is to improve **transparency**, **reproducibility**, and **artifact availability** for readers, reviewers, and researchers interested in the architectural, bibliographic, and methodological foundations of the work.

The repository is organized around two main complementary dimensions:

- the **reference architecture** used as the basis for threat elicitation and architectural reasoning in the paper;
- the **bibliographic and methodological protocol** used to construct, consolidate, enrich, and prioritize the literature corpus that supports the study.

In addition, the repository includes documentation files intended to facilitate citation, reproducibility, and navigation across the available materials.

## Repository scope

This repository was created to:

- make available the architectural diagram used in the article in both **high-resolution image format** and **editable Excalidraw format**;
- document the bibliographic and analytical workflow summarized in the paper;
- preserve the search strings, intermediate datasets, scripts, enrichment steps, rankings, and reports associated with the methodological pipeline;
- provide supporting notes that help readers understand how the supplementary materials relate to the article.

The repository is meant to complement the paper, especially in aspects that could not be described in full due to page limitations.

## Repository structure

```text
.
├── README.md
├── architecture/
│   ├── README.md
│   ├── figure-01-result-transmission-architecture-highres.png
│   └── figure-01-result-transmission-architecture.excalidraw
├── methodology/
│   ├── README.md
│   ├── 01_search_strings/
│   │   ├── 01_search_strings.txt
│   │   ├── scopus/
│   │   └── web_of_science/
│   ├── 02_corpus/
│   ├── 03_scripts/
│   ├── 04_enrichment_and_ranking/
│   └── 05_bibliometrix_reports/
└── docs/
    ├── article-links.md
    └── citation-and-reproducibility-notes.md
````

## Directory overview

### `architecture/`

This directory contains the artifacts related to **Figure 1** of the paper, which represents the reference architecture used in the STRIDE-based analysis of the results-transmission stage.

It includes:

* a **high-resolution image** for detailed inspection of components, flows, and trust boundaries;
* an **editable Excalidraw source file** to improve legibility, transparency, and reuse.

For a detailed explanation of the figure, its architectural scope, and the intended use of the files, see:

* [`architecture/README.md`](architecture/README.md)

### `methodology/`

This directory contains the methodological artifacts related to the construction and analysis of the bibliographic corpus used to support the article.

It includes:

* the exact **search strings** used in the study;
* source-specific exports from **Scopus** and **Web of Science**;
* the merged and normalized corpus;
* scripts for consolidation, clustering, enrichment, ranking, and relevance assignment;
* intermediate and final outputs of the enrichment and ranking workflow;
* reports generated through bibliometric analysis tools.

For a detailed description of the methodology protocol, including search dimensions, export procedure, consolidation, clustering, SJR enrichment, ranking logic, and reproducibility notes, see:

* [`methodology/README.md`](methodology/README.md)

### `docs/`

This directory contains auxiliary documentation intended to support repository use, article linkage, citation, and reproducibility.

Current files include:

* [`docs/article-links.md`](docs/article-links.md)
* [`docs/citation-and-reproducibility-notes.md`](docs/citation-and-reproducibility-notes.md)

These files are meant to serve as lightweight support material for readers who need quick access to article-related references and repository-use notes without navigating the full set of artifacts.

## About the proof of concept (POC)

The proof of concept used to provide an empirical application of the threat catalog is **not stored in this repository**.

To keep the artifacts better organized, the POC was maintained in a **separate dedicated repository**, available at:

* [POC repository](https://github.com/reinermaia/poc-stride-electoral/tree/main)

This separation was intentional. The present repository focuses on the **architecture artifacts**, **bibliographic methodology**, and **supporting documentation** for the article, while the external POC repository concentrates on the implementation and experimental artifacts associated with the evaluation scenario.

## How this repository complements the paper

The article presents the main scientific argument, methodological synthesis, and analytical results. This repository complements that narrative by making available the supporting artifacts that are difficult to fully include in the paper due to page constraints, especially:

* the editable and high-resolution architecture materials;
* the exact search strings and database exports;
* the corpus-processing pipeline;
* the intermediate methodological outputs used during corpus consolidation and prioritization;
* additional documentation related to citation and reproducibility.

In this sense, the repository functions as a companion resource for transparency and inspection rather than as a replacement for the article itself.

## Where to start

Readers interested in specific aspects of the work may begin with:

* [`architecture/README.md`](architecture/README.md) for the architectural figure and its scope;
* [`methodology/README.md`](methodology/README.md) for the methodological protocol and bibliographic workflow;
* [`docs/article-links.md`](docs/article-links.md) and [`docs/citation-and-reproducibility-notes.md`](docs/citation-and-reproducibility-notes.md) for supporting documentation;
* the external [POC repository](https://github.com/reinermaia/poc-stride-electoral/tree/main) for the empirical application artifacts.

## Final note

This repository is part of the study's reproducibility and transparency strategy and was organized by **the authors** of the study and maintained as a companion resource for transparency, reproducibility, and artifact availability. It was organized to make the supplementary materials easier to inspect, reuse academically where appropriate, and reference alongside the article.

```
