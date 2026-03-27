# Methodology Protocol

This directory documents the bibliographic and analytical workflow used to support the literature-grounding stage of the article on STRIDE-based threat modeling for the transmission of results in electronic voting systems. The protocol was designed to provide a transparent, auditable, and reproducible path from database search to the construction of a curated corpus used to inform requirements, architectural reasoning, and the discussion of related work.

## Objective

The objective of this protocol is to describe how the bibliographic corpus was assembled, consolidated, enriched, ranked, and screened in order to support the article's analytical foundation. The review was not intended as a standalone systematic literature review in the strict PRISMA sense, but as a structured and reproducible bibliographic support process focused on identifying studies related to electronic voting security, threat modeling, architectural security analysis, and adjacent critical-infrastructure domains.

The resulting corpus was used to strengthen the rationale for recurring security requirements, methodological positioning, and the identification of gaps in the literature, while the main threat elicitation process remained grounded in the architectural analysis of the transmission stage.

## Databases

The searches were conducted in the following multidisciplinary bibliographic databases:

- **Scopus**
- **Web of Science**

These sources were selected because they provide broad coverage of peer-reviewed literature in computing, information security, software engineering, and related interdisciplinary areas, while also allowing export of metadata suitable for subsequent consolidation and analysis.

## Time span

The searches were executed in November 2025, with exports dated as follows:

- **Scopus:** 2025-11-16
- **Web of Science:** 2025-11-20

The corpus therefore reflects the state of the indexed literature available in those databases as of the respective export dates. The protocol prioritizes reproducibility of the executed searches rather than continuous updating.

## Search dimensions

The search strategy was organized into complementary dimensions in order to balance recall and specificity. Instead of relying on a single broad query, the process separated the search space into thematic perspectives that correspond to the conceptual structure of the article.

The dimensions were:

1. **General search**  
   A broader query intended to capture literature on electronic voting, security, transmission, and related system concerns.

2. **Transmission threats**  
   A more focused query targeting threats, attacks, vulnerabilities, and security issues specifically associated with the transmission of electoral results or related artifacts.

3. **Threat-modeling methods**  
   A query aimed at studies involving threat modeling, security analysis methods, structured elicitation approaches, and similar methodological contributions.

4. **Architecture and flows**  
   A query intended to identify studies that address system architecture, data flows, distributed components, or infrastructure-level analyses relevant to the transmission context.

This decomposition allowed the corpus to capture both domain-specific studies and transferable methodological references from adjacent areas.

## Search strings

The search strings used in the protocol are preserved in the `01_search_strings/` directory, organized by source database.

### Scopus
Files under:

- `01_search_strings/scopus/`

These files correspond to the exported result sets generated from the different thematic search dimensions.

### Web of Science
Files under:

- `01_search_strings/web_of_science/`

These files preserve the search expressions and/or exported records associated with the Web of Science queries for the same dimensions.

The naming convention indicates both the thematic focus and the export date, enabling traceability between query logic and downstream corpus-processing steps.

## Export procedure

Search results were exported separately from each database and kept in their original source-specific formats before consolidation.

For **Scopus**, exports were saved as `.csv` files.  
For **Web of Science**, exports were saved as `.txt` files.

The exports were intentionally preserved as raw source artifacts so that the consolidation process could be reproduced from the same input data. Source separation also makes it possible to inspect any differences in metadata completeness, indexing conventions, or field naming between the databases.

## Consolidation and deduplication

After retrieval, the records from Scopus and Web of Science were merged into a single working corpus. This stage is documented in:

- `02_corpus/M_Scopus_WoS_merged_2025-11-21.xlsx`
- `02_corpus/M_Scopus_WoS_merged_2025-11-21_normalized.xlsx`

The consolidation process involved:

- combining records from both databases;
- normalizing metadata fields where necessary;
- identifying and removing duplicate entries;
- preparing the dataset for later enrichment and ranking steps.

The normalized corpus constitutes the baseline dataset from which subsequent thematic clustering, enrichment, and selection procedures were performed.

Additional process notes are preserved in:

- `02_corpus/notes/Passo a passo da metodologia.txt`

## Thematic clustering

After consolidation, the corpus was analyzed to identify thematic affinities among the retrieved studies. This stage was intended to support structured screening and to make the large set of records more interpretable for manual and semi-automated relevance assessment.

The clustering step is reflected in files such as:

- `04_enrichment_and_ranking/2_M_Scopus_WoS_2025-11-21_clusterizado.xlsx`

and was supported by the analytical note:

- `03_scripts/AnaliseAtribuicaoClusterTematico.txt`

The thematic grouping helped distinguish, for example, studies centered on electronic voting, threat modeling methods, security architecture, risk analysis, and adjacent infrastructure-security contexts. This organization was used to improve the consistency of corpus interpretation and to support later relevance grouping.

## SJR enrichment

To complement the thematic analysis, the corpus was enriched with journal- and venue-related impact information derived from the SCImago Journal Rank dataset.

Relevant files include:

- `04_enrichment_and_ranking/scimagojr_2024.csv`
- `04_enrichment_and_ranking/3_M_Scopus_WoS_2025-11-21_clusterizado_SJR.xlsx`
- `04_enrichment_and_ranking/4_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy.xlsx`

This enrichment stage associated corpus entries with SJR-related information where possible, including cases that required approximate or fuzzy matching due to metadata inconsistencies. The purpose of this step was not to exclude studies solely on venue metrics, but to provide an additional signal for later ranking and prioritization.

## SSS and TAPS ranking

After enrichment, the corpus underwent a ranking stage designed to combine multiple signals into a prioritization-oriented ordering of records.

The ranking process is reflected in:

- `04_enrichment_and_ranking/5_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked.xlsx`
- `04_enrichment_and_ranking/6_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked_relevancia.xlsx`

and was supported by scripts such as:

- `03_scripts/01_calcula_SSS_TAPS_Ranking.R`

Within this workflow, **SSS** and **TAPS** were used as internal ranking constructs to help prioritize records for closer examination. In practical terms, this stage combines metadata-based and thematic signals in order to identify which records are most likely to provide strong conceptual or methodological support for the article.

The ranking process was used as a decision-support mechanism, not as a substitute for expert judgment.

## Relevance groups

Following ranking, the corpus was organized into relevance groups in order to support screening and final article selection. This stage is associated with:

- `03_scripts/02_atribui_relevancia.R`
- `04_enrichment_and_ranking/6_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked_relevancia.xlsx`

The relevance groups were designed to separate:

- highly aligned studies directly related to the article's scope;
- methodologically useful studies from adjacent domains;
- lower-priority or peripheral records.

This grouping supported the final identification of the most relevant studies for detailed reading and citation. The outputs of that filtering and closer examination are reflected in:

- `04_enrichment_and_ranking/AnaliseAmeacas_ArtigosSelecionados.xlsx`
- `04_enrichment_and_ranking/AnaliseAmeacas_ArtigosSelecionados2.xlsx`

## Files and scripts

The directory structure reflects the main stages of the workflow:

### `01_search_strings/`
Contains the raw search exports and search-related artifacts, separated by source database.

### `02_corpus/`
Contains the merged and normalized corpus files, as well as supporting notes about the methodological sequence.

### `03_scripts/`
Contains the scripts and analytical notes used in the consolidation, ranking, enrichment, and interpretation workflow, including:

- `ConsolidacaoBasesWoSScopus.R`
- `01_calcula_SSS_TAPS_Ranking.R`
- `02_atribui_relevancia.R`
- `preenche_sjr_fuzzy.py`
- `AnaliseAtribuicaoClusterTematico.txt`

### `04_enrichment_and_ranking/`
Contains intermediate and final outputs of clustering, SJR enrichment, fuzzy matching, ranking, and relevance assignment.

## Reproducibility notes

This subdirectory is intended to provide transparency and partial reproducibility for the bibliographic support protocol used in the article.

Some important notes apply:

1. **Database results may change over time**  
   Because Scopus and Web of Science are dynamic databases, rerunning the searches at a later date may yield a different number of records or slightly different metadata.

2. **The workflow preserves source artifacts and intermediate outputs**  
   The inclusion of raw exports, merged files, enriched files, ranked files, and scripts is intended to make the analytical path auditable rather than opaque.

3. **Ranking supports, but does not replace, expert review**  
   The final analytical use of the corpus depended on qualitative judgment regarding scope alignment, methodological relevance, and contribution to the article.

4. **The protocol supports the article but is not its sole methodological basis**  
   The literature workflow provides bibliographic grounding, while the core threat analysis presented in the paper is based primarily on the architectural decomposition of the result-transmission stage and its examination through the STRIDE model.

5. **Companion role in relation to the paper**  
   This repository complements the paper by providing methodological details that could not be fully expanded in the article due to page limits, especially regarding search structure, consolidation workflow, intermediate processing, and ranking artifacts.
