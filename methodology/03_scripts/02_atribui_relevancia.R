###############################################################
# Script: 02_atribui_relevancia.R
# Objetivo:
#   - Ler a planilha ranqueada por ClusterTematico
#   - Atribuir o grupo de relevância:
#       Excelente, Relevante, Bom, Baixa
#   - com base no Ranking (SSS + TAPS) dentro de cada cluster
#
# Base de entrada:
#   "5_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked.xlsx"
#
# Autor: Vicente Ferreira Júnior
# Data: 22/11/2025
###############################################################

library(readxl)
library(writexl)
library(dplyr)

## ------------------------------------------------------------------
## 1) Diretório de trabalho e arquivos
## ------------------------------------------------------------------

setwd("C:/Users/junio/OneDrive/AAMestrado/ArtigoAnáliseAmeaças/Estudo Bibliométrico - 2025-11-21/Ranking")

input_file  <- "5_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked.xlsx"
output_file <- "6_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked_relevancia.xlsx"

## ------------------------------------------------------------------
## 2) Leitura da base
## ------------------------------------------------------------------

dados <- read_xlsx(input_file)

cols_necessarias <- c("ClusterTematico", "Ranking")
faltando <- setdiff(cols_necessarias, names(dados))
if (length(faltando) > 0) {
  stop(paste("As seguintes colunas obrigatórias não foram encontradas na planilha:",
             paste(faltando, collapse = ", ")))
}

# Garante que a coluna Relevancia exista
if (!"Relevancia" %in% names(dados)) {
  dados$Relevancia <- NA_character_
}

## ------------------------------------------------------------------
## 3) Atribuição dos grupos de relevância por ClusterTematico
##
## Critério (por cluster):
##   perc_rank = Ranking / n_cluster
##
##   - perc_rank <= 0.20       -> "Excelente"
##   - 0.20 < perc_rank <= 0.50 -> "Relevante"
##   - 0.50 < perc_rank <= 0.80 -> "Bom"
##   - perc_rank  > 0.80        -> "Baixa"
## ------------------------------------------------------------------

dados <- dados %>%
  group_by(ClusterTematico) %>%
  mutate(
    n_cluster = n(),
    perc_rank = Ranking / n_cluster,
    Relevancia = dplyr::case_when(
      perc_rank <= 0.20 ~ "Excelente",
      perc_rank <= 0.50 ~ "Relevante",
      perc_rank <= 0.80 ~ "Bom",
      TRUE              ~ "Baixa"
    )
  ) %>%
  ungroup() %>%
  select(-n_cluster, -perc_rank)

## ------------------------------------------------------------------
## 4) Gravar arquivo de saída
## ------------------------------------------------------------------

write_xlsx(dados, output_file)

cat("Arquivo de saída gravado em:\n", output_file, "\n")
