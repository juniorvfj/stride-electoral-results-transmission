###############################################################
# Script: 01_calcula_SSS_TAPS_Ranking.R
# Objetivo:
#   - Ler a planilha final consolidada pelo Bibliometrix
#   - Calcular:
#       * PublicationAge (idade da publicação)
#       * SSS (Scientific Significance Score)
#       * TAPS (Time-Adjusted Publication Score)
#       * Ranking (ranking final por ClusterTematico)
#   - Gravar o resultado em um novo arquivo .xlsx
#
# Base de entrada:
#   "4_M_Scopus_WoS_merged_2025-11-21_clusterizado_SJR_fuzzy.xlsx"
#
# Autor: Vicente Ferreira Júnior
# Data: 22/11/2025
###############################################################

# Pacotes necessários
library(readxl)
library(writexl)
library(dplyr)
library(stringr)

## ------------------------------------------------------------------
## 1) Parâmetros gerais
## ------------------------------------------------------------------

# Diretório de trabalho (ajuste se necessário)
setwd("C:/Users/junio/OneDrive/AAMestrado/ArtigoAnáliseAmeaças/Estudo Bibliométrico - 2025-11-21/Ranking")

# Arquivo de entrada e saída
input_file  <- "4_M_Scopus_WoS_merged_2025-11-21_clusterizado_SJR_fuzzy.xlsx"
output_file <- "5_M_Scopus_WoS_2025-11-21_clusterizado_SJR_fuzzy_ranked.xlsx"

# Ano corrente utilizado para os cálculos (CY)
current_year <- 2025
# Se quiser usar o ano do sistema, basta trocar por:
# current_year <- as.numeric(format(Sys.Date(), "%Y"))

## ------------------------------------------------------------------
## 2) Leitura da base
## ------------------------------------------------------------------

dados <- read_xlsx(input_file)

# Checagens básicas de colunas esperadas
cols_necessarias <- c("PY", "SJR", "ClusterTematico")
faltando <- setdiff(cols_necessarias, names(dados))
if (length(faltando) > 0) {
  stop(paste("As seguintes colunas obrigatórias não foram encontradas na planilha:",
             paste(faltando, collapse = ", ")))
}

# Identificar a coluna de citações:
# tenta achar TC, NC ou Citations (ajuste se necessário)
cand_cit <- intersect(c("TC", "NC", "Citations"), names(dados))
if (length(cand_cit) == 0) {
  stop("Nenhuma coluna de citações (TC/NC/Citations) foi encontrada. Ajuste o script.")
}
cit_col <- cand_cit[1]  # usa a primeira encontrada

# Cria uma coluna NC (número de citações) padronizada a partir da coluna escolhida
dados <- dados %>%
  mutate(
    NC = as.numeric(.data[[cit_col]])
  )

## ------------------------------------------------------------------
## 3) Cálculo de PublicationAge
##     PublicationAge = max( CurrentYear - PY , 0 )
## ------------------------------------------------------------------

dados <- dados %>%
  mutate(
    PY = as.numeric(PY),
    PublicationAge = pmax(current_year - PY, 0)
  )

## ------------------------------------------------------------------
## 4) Cálculo de SF (número de casas decimais de SJR)
##     SF = número de dígitos após a vírgula/ponto do SJR
## ------------------------------------------------------------------

calc_SF <- function(x) {
  if (is.na(x)) return(NA_integer_)
  s <- gsub(",", ".", as.character(x))  # garante ponto como separador
  if (!grepl("\\.", s)) return(0L)
  dec <- sub("^[^.]*\\.", "", s)
  nchar(dec)
}

dados <- dados %>%
  mutate(
    SJR = as.numeric(SJR),
    SF  = vapply(SJR, calc_SF, integer(1))
  )

## ------------------------------------------------------------------
## 5) Cálculo do SSS
##     Fórmula (do artigo):
##     SSS = (SJR × 10^(SF − 1) + NC) / (1 + (CY − PY))
## ------------------------------------------------------------------

dados <- dados %>%
  mutate(
    SSS = dplyr::if_else(
      is.na(SJR) | is.na(NC),
      NA_real_,
      (SJR * (10^(SF - 1)) + NC) / (1 + PublicationAge)
    )
  )

## ------------------------------------------------------------------
## 6) Cálculo do TAPS
##     Fórmula (do artigo):
##     TAPS = (IF + Citations) / (1 + (CurrentYear − PublicationYear))
##     Aqui assumimos IF = SJR e Citations = NC.
## ------------------------------------------------------------------

dados <- dados %>%
  mutate(
    TAPS = dplyr::if_else(
      is.na(SJR) | is.na(NC),
      NA_real_,
      (SJR + NC) / (1 + PublicationAge)
    )
  )

## ------------------------------------------------------------------
## 7) Cálculo do Ranking por ClusterTematico
##     - Ordena dentro de cada ClusterTematico por:
##         1) SSS (descendente)
##         2) TAPS (descendente)
##     - Atribui Ranking = 1, 2, 3, ... por cluster
## ------------------------------------------------------------------

dados <- dados %>%
  group_by(ClusterTematico) %>%
  arrange(desc(SSS), desc(TAPS), .by_group = TRUE) %>%
  mutate(
    Ranking = row_number()
  ) %>%
  ungroup()

## ------------------------------------------------------------------
## 8) Gravar arquivo de saída
## ------------------------------------------------------------------

write_xlsx(dados, output_file)

cat("Arquivo de saída gravado em:\n", output_file, "\n")
