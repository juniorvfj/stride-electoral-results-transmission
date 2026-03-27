############################################################
# Script para consolidar bases Scopus e WoS + corrigir CR
# Autor: Vicente Júnior :)
# Data: 2025-11-21
############################################################

# 1) Carregar / instalar pacotes necessários ------------------------------
pkgs <- c("bibliometrix", "dplyr", "stringr", "writexl")

for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p)
  }
}

library(bibliometrix)
library(dplyr)
library(stringr)
library(writexl)

# 2) Definir diretório de trabalho ----------------------------------------
# Use barras normais (/) para evitar problema com \ em Windows
setwd("C:/Users/junio/OneDrive/AAMestrado/ArtigoAnáliseAmeaças/Estudo Bibliométrico - 2025-11-21")

# 3) Listar arquivos de entrada -------------------------------------------

# Arquivos Scopus (CSV)
scopus_files <- c(
  "ScopusExport_2025-11-16_StringGeral.csv",
  "ScopusExport_2025-11-16_StringAmeacasTransmissao.csv",
  "ScopusExport_2025-11-16_StringMetodosModelagemAmeacas.csv",
  "ScopusExport_2025-11-16_StringModelagemArquitetura.csv"
)

# Arquivos Web of Science (TXT)
wos_files <- c(
  "WoS_StringAmeacasTransmissao_2025-11-20.txt",
  "WoS_StringArquiteturaFluxos_2025-11-20.txt",
  "WoS_StringGeral_2025-11-20.txt",
  "WoS_StringMetodosModelagemAmeacas_2025-11-20.txt"
)

# 4) Ler e converter bases Scopus -----------------------------------------

message("Lendo e convertendo arquivos Scopus...")

scopus_list <- lapply(scopus_files, function(f) {
  if (!file.exists(f)) {
    stop(paste("Arquivo não encontrado (Scopus):", f))
  }
  convert2df(file = f,
             dbsource = "scopus",
             format = "csv")
})

# 5) Ler e converter bases WoS --------------------------------------------

message("Lendo e convertendo arquivos Web of Science...")

wos_list <- lapply(wos_files, function(f) {
  if (!file.exists(f)) {
    stop(paste("Arquivo não encontrado (WoS):", f))
  }
  convert2df(file = f,
             dbsource = "isi",
             format = "plaintext")
})

# 6) Consolidar todas as bases em um único objeto M -----------------------

message("Unindo todas as bases (Scopus + WoS)...")

# Junta listas Scopus e WoS
dblist_all <- c(scopus_list, wos_list)

# mergeDbSources aceita uma lista de data.frames
M_all <- do.call(mergeDbSources, c(dblist_all, list(remove.duplicated = TRUE)))

message(paste("Total de registros após o merge:", nrow(M_all)))

# 7) Corrigir coluna CR usando CR_RAW -------------------------------------
# O problema relatado: CR está com "NA" (texto) ou vazia,
# enquanto CR_RAW contém as referências corretas.

if (!"CR" %in% names(M_all)) {
  stop("A coluna 'CR' não foi encontrada no objeto M_all.")
}

if (!"CR_RAW" %in% names(M_all)) {
  warning("A coluna 'CR_RAW' não foi encontrada em M_all. Não será possível atualizar CR a partir de CR_RAW.")
} else {
  message("Atualizando coluna CR com base em CR_RAW...")

  # Garante que as colunas sejam character
  M_all$CR     <- as.character(M_all$CR)
  M_all$CR_RAW <- as.character(M_all$CR_RAW)

  # Critério:
  # - Se CR é NA, vazio ou "NA" (como texto), e CR_RAW tem algo válido,
  #   então substitui CR por CR_RAW.
  # - Caso contrário, mantém CR original.
  M_all <- M_all %>%
    mutate(
      CR = case_when(
        # Se CR já tem conteúdo válido, mantém
        !is.na(CR) &
          str_trim(CR) != "" &
          str_to_upper(str_trim(CR)) != "NA" ~ CR,

        # Se CR está vazia/NA, mas CR_RAW tem conteúdo:
        !is.na(CR_RAW) &
          str_trim(CR_RAW) != "" &
          str_to_upper(str_trim(CR_RAW)) != "NA" ~ CR_RAW,

        # Caso contrário, fica o que já estava em CR
        TRUE ~ CR
      )
    )
}

# 8) Exportar resultado para Excel ----------------------------------------

output_excel <- "M_Scopus_WoS_merged_2025-11-21.xlsx"

message(paste("Gravando arquivo Excel:", output_excel))

write_xlsx(M_all, path = output_excel)

# (Opcional) salvar também em .RData, se quiser usar no bibliometrix depois:
# save(M_all, file = "M_Scopus_WoS_merged_2025-11-21.RData")

message("Finalizado com sucesso!")
