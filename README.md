# Threat Modeling in the Transmission of Results of an Electronic Voting System Using STRIDE

This repository contains the artifacts that support the study on threat modeling for the transmission of results in electronic voting systems, with emphasis on three complementary fronts: **(i)** the architectural model used in the article, **(ii)** the **proof of concept (POC)** for empirical validation of the STRIDE threat catalog, and **(iii)** the **bibliometric and methodological protocol** used to build and prioritize the literature corpus.

The repository was organized to increase **transparency**, **reproducibility**, and **artifact availability** for readers of the article and reviewers interested in inspecting the underlying materials.

## Repository goals

This repository was created to:

- make available the **architectural diagram** used in the article in both high-resolution image format and editable Excalidraw source;
- document the **research methodology**, especially the bibliometric protocol summarized in Section 4 of the article;
- preserve the **search strings**, intermediate datasets, scripts, ranking steps, and generated reports used in the literature analysis pipeline;
- provide access to the **POC artifacts** used to empirically exercise representative STRIDE categories in a transmission-results scenario.

## Suggested repository structure

A practical and publication-friendly structure is the following:

```text
.
├── README.md
├── architecture/
│   ├── README.md
│   ├── figure-01-result-transmission-architecture-highres.jpg
│   ├── figure-01-result-transmission-architecture.excalidraw
│   └── exports/
│       ├── figure-01-result-transmission-architecture.pdf
│       └── figure-01-result-transmission-architecture.png
├── methodology/
│   ├── README.md
│   ├── 01_search_strings/
│   │   ├── scopus/
│   │   │   ├── ScopusExport_2025-11-16_StringGeral.csv
│   │   │   ├── ScopusExport_2025-11-16_StringAmeacasTransmissao.csv
│   │   │   ├── ScopusExport_2025-11-16_StringMetodosModelagemAmeacas.csv
│   │   │   └── ScopusExport_2025-11-16_StringModelagemArquitetura.csv
│   │   └── web_of_science/
│   │       ├── WoS_StringGeral_2025-11-20.txt
│   │       ├── WoS_StringAmeacasTransmissao_2025-11-20.txt
│   │       ├── WoS_StringMetodosModelagemAmeacas_2025-11-20.txt
│   │       └── WoS_StringArquiteturaFluxos_2025-11-20.txt
│   ├── 02_corpus/
│   │   ├── M_Scopus_WoS_merged_2025-11-21.xlsx
│   │   ├── M_Scopus_WoS_merged_2025-11-21_normalized.xlsx
│   │   └── notes/
│   │       └── Passo a passo da metodologia.txt
│   ├── 03_scripts/
│   │   ├── ConsolidacaoBasesWoSScopus.R
│   │   ├── 01_calcula_SSS_TAPS_Ranking.R
│   │   ├── 02_atribui_relevancia.R
│   │   ├── preenche_sjr_fuzzy.py
│   │   └── AnaliseAtribuicaoClusterTematico.txt
│   ├── 04_enrichment_and_ranking/
│   │   ├── scimagojr_2024.csv
│   │   ├── 1_M_Scopus_WoS_merged_2025-11-21.xlsx
│   │   ├── 2_M_Scopus_WoS_2025-11-21_clusterizado.xlsx
│   │   ├── 3_M_Scopus_WoS_2025-11-21_clusterizado_SJR.xlsx
│   │   ├── 4_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy.xlsx
│   │   ├── 5_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked.xlsx
│   │   ├── 6_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked_relevancia.xlsx
│   │   ├── AnaliseAmeacas_ArtigosSelecionados.xlsx
│   │   └── AnaliseAmeacas_ArtigosSelecionados2.xlsx
│   ├── 05_bibliometrix_reports/
│   │   ├── 1_MainInformation.png
│   │   ├── 1_MainInformation.txt
│   │   ├── 2_BiblioAI_lifeCycle.zip
│   │   ├── 2_BiblioAI_lifeCycle.txt
│   │   ├── 3_BiblioAI_threeFieldPlot.png
│   │   ├── 3_BiblioAI_threeFieldPlot.txt
│   │   ├── 4_MostRelevantSources-2025-11-21.png
│   │   ├── 5_MostLocalCitedSources-2025-11-21.png
│   │   ├── 6_BradfordLaws-2025-11-21.png
│   │   ├── 8_SourceDynamics-2025-11-21.png
│   │   ├── 12_AuthorsProductionOverTime-2025-11-21.png
│   │   ├── 17_MostRelevantCountries-2025-11-21.png
│   │   ├── 18_CountryScientificProduction-2025-11-21.png
│   │   ├── 19_MostCitedCountries-2025-11-21.png
│   │   ├── 20_MostGlobalCitedDocuments-2025-11-21.png
│   │   ├── 21_MostLocalCitedDocuments-2025-11-21.png
│   │   └── 22_MostLocalCitedReferences-2025-11-21.png
│   └── 06_protocol_summary/
│       └── methodology_protocol.md
├── poc/
│   ├── README.md
│   └── poc-stride-electoral/
│       ├── src/
│       ├── attacks/
│       ├── tests/
│       ├── data/
│       └── docker-compose.yml
└── docs/
    ├── article-links.md
    └── citation-and-reproducibility-notes.md
```

This structure separates the repository into four clear units: **article**, **architecture**, **methodology**, and **POC**.

## Architecture artifacts

The directory `architecture/` should store the material associated with **Figure 1** of the paper.

### Recommended contents

- `figure-01-result-transmission-architecture-highres.jpg`: high-resolution version of the figure used in the article;
- `figure-01-result-transmission-architecture.excalidraw`: original editable Excalidraw file;
- `exports/`: optional exports in PNG/PDF for direct reuse in manuscripts, presentations, and review packages.

### Recommended `architecture/README.md`

This subdirectory should explain:

- what the figure represents;
- which architectural scope it covers;
- that the editable `.excalidraw` source is provided to improve legibility and reuse;
- that the high-resolution file is the preferred artifact for reviewers and readers who need to inspect components, flows, and trust boundaries in detail.

A concise example:

> This folder contains the architectural diagram used in the paper to represent the reference scenario for electoral result transmission. The high-resolution image improves readability in relation to the figure embedded in the article, while the `.excalidraw` source allows inspection, editing, and export into additional formats.

## Methodology overview

Section 4 of the article describes the study as **applied**, **exploratory**, and **descriptive**, with a predominantly **qualitative** approach supported by **quantitative bibliometric techniques** for corpus analysis and prioritization. The study is based on bibliographic and documentary research over public scientific and technical sources. fileciteturn4file0

The bibliographic corpus was built from **Scopus** and **Web of Science**, using search strategies that combined terms related to **threats**, **electronic voting**, **result transmission**, and **threat modeling methods** such as STRIDE, DREAD, and attack trees. The searches covered the **2020–2025** period. fileciteturn4file0

The exported records were consolidated in **R** using **bibliometrix/Biblioshiny**, with harmonization of metadata, normalization of names, duplicate removal, and exclusion of incomplete records. The resulting corpus comprised **681 documents**, **396 sources**, and an average document age of **2.21 years**. fileciteturn4file0

The corpus was then classified into thematic clusters: **threat modeling**, **electronic voting / e-voting**, **network security**, **blockchain**, **risk assessment**, and **not identified**. The largest cluster was **threat modeling** with **446 documents**. fileciteturn4file4

To enrich the corpus, the workflow incorporated **SCImago Journal Rank (SJR)** data, using direct ISSN matching whenever possible and **fuzzy string matching** with a threshold of **0.84** when exact matches were not available. fileciteturn4file4

Finally, the repository preserves the ranking workflow based on the composite indicators **SSS** and **TAPS**, which were used to rank papers inside each thematic cluster and assign the relevance groups **Excellent**, **Relevant**, **Good**, and **Low**. fileciteturn4file2turn4file4

## Mapping the methodology folders

Based on the current project files, the methodology can be documented as follows.

### `01_search_strings/`
Stores the original search formulations and exported query artifacts for each database.

**Purpose:** make the retrieval stage auditable and reproducible.

Typical contents:
- Scopus search exports in CSV;
- Web of Science search strings in TXT;
- notes describing the purpose of each query family, such as general search, threat-transmission search, threat-modeling methods, and architecture/flow-oriented search.

### `02_corpus/`
Stores the merged and normalized working corpus.

**Purpose:** preserve the input and cleaned dataset used before thematic classification and ranking.

Typical contents:
- merged spreadsheets;
- normalized spreadsheets;
- short methodological notes such as `Passo a passo da metodologia.txt`.

### `03_scripts/`
Stores the scripts used for consolidation, enrichment, scoring, and annotation.

**Purpose:** document the computational pipeline.

Typical contents:
- R scripts for consolidation and ranking;
- Python script for fuzzy SJR completion;
- notes on thematic cluster assignment.

### `04_enrichment_and_ranking/`
Stores the staged outputs of SJR enrichment, fuzzy matching, ranking generation, relevance labeling, and selected-paper analysis.

**Purpose:** preserve the full ranking lineage instead of only the final file.

### `05_bibliometrix_reports/`
Stores figures, text exports, and compressed outputs generated by Biblioshiny/Bibliometrix.

**Purpose:** preserve the descriptive and relational bibliometric evidence cited in the study.

### `06_protocol_summary/`
Stores a concise protocol document, ideally in Markdown, summarizing the retrieval, screening, consolidation, clustering, enrichment, and ranking steps.

**Purpose:** provide a reviewer-friendly summary without forcing the reader to inspect all raw files.

## Suggested `methodology/README.md`

The `methodology/README.md` file can summarize the workflow in six steps:

1. **Search design**: build database-specific strings for Scopus and Web of Science, covering threats, e-voting, result transmission, and threat modeling methods. fileciteturn4file0
2. **Record export**: export Scopus in CSV and Web of Science in Plain Text, preserving title, abstract, keywords, year, source, citations, DOI, and ISSN whenever available. fileciteturn4file0
3. **Corpus consolidation**: merge and normalize records in R with bibliometrix, remove duplicates, and discard incomplete entries. fileciteturn4file0
4. **Thematic clustering**: assign each document to one thematic cluster based on bibliometrix outputs and inspection of title, abstract, and keywords. fileciteturn4file4
5. **Journal-quality enrichment**: attach SJR values using ISSN matching, source-title comparison, and fuzzy matching when needed. fileciteturn4file4
6. **Prioritization and selection**: compute SSS and TAPS, generate cluster-wise rankings, and assign relevance groups to guide deeper qualitative reading. fileciteturn4file2turn4file4

## POC linkage

The POC repository documents an empirical validation pipeline for representative STRIDE scenarios in the result-transmission context. The POC simulates a transmission pipeline including a result generator, transmission client, API gateway, integrity-validation service, MinIO-based storage, Redis queue, and chained-hash audit log, across three trust boundaries. fileciteturn4file10turn4file14

The POC repository structure described in the evaluation document contains:

```text
poc-stride-electoral/
  src/               # System components
  attacks/           # Attack scripts by scenario
  tests/             # Latency tests
  data/              # JSON results and markdown documentation
  docker-compose.yml # Containerized infrastructure
```

This structure can be preserved inside `poc/poc-stride-electoral/` or kept as an independent repository linked from this umbrella repository. fileciteturn4file8turn4file12

## Minimal citation note for the article

If this repository is cited in the paper, a short note such as the following is sufficient:

> Supplementary materials for architecture readability, bibliometric methodology transparency, and empirical POC artifacts are publicly available in this repository.

## Recommended next files to create

To make the repository immediately usable, the next files worth adding are:

- `architecture/README.md`
- `methodology/README.md`
- `methodology/06_protocol_summary/methodology_protocol.md`
- `poc/README.md`
- `docs/citation-and-reproducibility-notes.md`

## Suggested `methodology_protocol.md` outline

```text
# Methodology Protocol

## Objective
## Databases
## Time span
## Search dimensions
## Search strings
## Export procedure
## Consolidation and deduplication
## Thematic clustering
## SJR enrichment
## SSS and TAPS ranking
## Relevance groups
## Files and scripts
## Reproducibility notes
```

## Final note

This repository is not only a storage location for supplementary files. It is part of the study's **reproducibility strategy**. The architectural files improve figure readability, the methodology folders document how the literature corpus was built and prioritized, and the POC artifacts provide a concrete bridge between the STRIDE catalog proposed in the article and its empirical exercise in a reference transmission scenario.
