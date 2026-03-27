#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Script: preenche_sjr_fuzzy.py
Autor: Vicente Ferreira Júnior
Data: 22/11/2025

Resumo:
    Este script lê a planilha consolidada do estudo bibliométrico (Scopus + Web of Science),
    preenche a coluna SJR a partir da base SCImago Journal Rank (arquivo CSV) e grava um novo
    arquivo Excel com os valores de SJR atualizados.

    A lógica de preenchimento segue três critérios, nesta ordem:
      1) Correspondência pelo ISSN (prioritário)
      2) Correspondência exata entre o nome da fonte (SO) e o título do periódico no SCImago
      3) Correspondência aproximada (fuzzy) entre SO e o título do periódico, usando similaridade
         de strings (SequenceMatcher) com limiar mínimo de 0.84

    Somente quando algum desses critérios encontra correspondência o SJR é atribuído.
    As demais colunas da planilha são mantidas inalteradas.
"""

import os
from collections import defaultdict
from difflib import SequenceMatcher

import pandas as pd


def carregar_scimago(scimago_path: str) -> pd.DataFrame:
    """
    Lê o arquivo CSV do SCImago, tentando primeiro separador ';' e depois ','.
    Cria a coluna SJR_float como número real.
    """
    try:
        scimago_df = pd.read_csv(scimago_path, sep=";")
    except Exception:
        scimago_df = pd.read_csv(scimago_path, sep=",", engine="python")

    scimago_df = scimago_df.copy()
    # Normaliza SJR como float (ponto decimal)
    scimago_df["SJR_float"] = (
        scimago_df["SJR"]
        .astype(str)
        .str.replace(",", ".", regex=False)
    )
    scimago_df["SJR_float"] = pd.to_numeric(scimago_df["SJR_float"], errors="coerce")

    # Normaliza título
    scimago_df["Title_norm"] = scimago_df["Title"].astype(str).str.upper().str.strip()

    return scimago_df


def montar_mapa_issn_para_sjr(scimago_df: pd.DataFrame) -> dict:
    """
    Cria um dicionário ISSN -> SJR_float.
    Quando há mais de um registro para o mesmo ISSN, mantém o maior SJR.
    """
    issn_to_sjr: dict[str, float] = {}

    for _, row in scimago_df[["Issn", "SJR_float"]].dropna(subset=["Issn"]).iterrows():
        sjr_val = row["SJR_float"]
        issn_raw = str(row["Issn"])
        # Ex.: "15424863, 00079235"
        for part in issn_raw.replace(" ", "").split(","):
            code = part.strip().replace("-", "")
            if not code:
                continue
            if code in issn_to_sjr:
                if sjr_val > issn_to_sjr[code]:
                    issn_to_sjr[code] = sjr_val
            else:
                issn_to_sjr[code] = sjr_val

    return issn_to_sjr


def montar_mapa_titulo_para_sjr(scimago_df: pd.DataFrame) -> dict:
    """
    Cria um dicionário Title_norm -> SJR_float, mantendo o maior SJR por título.
    """
    title_to_sjr: dict[str, float] = {}

    for _, row in scimago_df[["Title_norm", "SJR_float"]].dropna(subset=["Title_norm"]).iterrows():
        sjr_val = row["SJR_float"]
        tkey = row["Title_norm"]
        if tkey in title_to_sjr:
            if sjr_val > title_to_sjr[tkey]:
                title_to_sjr[tkey] = sjr_val
        else:
            title_to_sjr[tkey] = sjr_val

    return title_to_sjr


def aplicar_sjr_exato(
    biblio_df: pd.DataFrame,
    issn_to_sjr: dict,
    title_to_sjr: dict
) -> pd.DataFrame:
    """
    Preenche SJR usando:
      1) ISSN (coluna 'ISSN')
      2) Correspondência exata do título (coluna 'SO' vs Title_norm)
    """

    if "SJR" not in biblio_df.columns:
        biblio_df["SJR"] = pd.NA

    def get_sjr_exact(row):
        # 1) ISSN
        issn_val = row.get("ISSN")
        if isinstance(issn_val, str):
            parts = [p.strip().replace("-", "").replace(" ", "") for p in issn_val.split(";")]
            sjr_candidates = []
            for code in parts:
                if code in issn_to_sjr:
                    sjr_candidates.append(issn_to_sjr[code])
            if sjr_candidates:
                return max(sjr_candidates)

        # 2) Título da fonte (SO)
        so_val = row.get("SO")
        if isinstance(so_val, str):
            so_key = so_val.upper().strip()
            if so_key in title_to_sjr:
                return title_to_sjr[so_key]

        # 3) Se nada encontrou, retorna o que já existir em SJR
        return row.get("SJR")

    biblio_df["SJR"] = biblio_df.apply(get_sjr_exact, axis=1)
    return biblio_df


def montar_grupos_titulos(scimago_df: pd.DataFrame) -> dict:
    """
    Agrupa os títulos do SCImago por prefixo (primeiros 3 caracteres) para acelerar o fuzzy matching.
    Retorna um dicionário: chave -> lista de (titulo_norm, SJR_float).
    """
    groups: dict[str, list[tuple[str, float]]] = defaultdict(list)
    titles = scimago_df["Title_norm"].tolist()
    sjr_vals = scimago_df["SJR_float"].tolist()

    for t, sv in zip(titles, sjr_vals):
        if not isinstance(t, str):
            continue
        key = t[:3]  # primeiros 3 caracteres
        groups[key].append((t, sv))

    return groups


def best_fuzzy_sjr_grouped(
    so_norm: str,
    groups_dict: dict,
    threshold: float = 0.84
) -> float:
    """
    Para um SO_norm, encontra o título do SCImago com maior similaridade dentro do grupo de prefixo.
    Retorna o SJR se similarity >= threshold; caso contrário, NaN.
    """
    if not isinstance(so_norm, str) or not so_norm:
        return float("nan")

    key = so_norm[:3]
    candidates = groups_dict.get(key, [])
    if not candidates:
        # fallback: tenta só a primeira letra
        key1 = so_norm[:1]
        candidates = groups_dict.get(key1, [])
        if not candidates:
            return float("nan")

    best_sim = 0.0
    best_sjr = float("nan")
    for t, sv in candidates:
        if not isinstance(t, str):
            continue
        sim = SequenceMatcher(None, so_norm, t).ratio()
        if sim > best_sim:
            best_sim = sim
            best_sjr = sv

    if best_sim >= threshold:
        return best_sjr
    else:
        return float("nan")


def aplicar_sjr_fuzzy(
    biblio_df: pd.DataFrame,
    scimago_df: pd.DataFrame,
    threshold: float = 0.84
) -> pd.DataFrame:
    """
    Aplica fuzzy matching nos registros que ainda estão sem SJR, usando similaridade entre
    SO_norm e Title_norm, com limiar mínimo 'threshold'.
    """
    # Normaliza SO
    biblio_df["SO_norm"] = biblio_df["SO"].astype(str).str.upper().str.strip()

    # Seleciona apenas os que ainda estão sem SJR
    mask_na_sjr = biblio_df["SJR"].isna()
    so_candidates = biblio_df.loc[mask_na_sjr, "SO_norm"].dropna().unique().tolist()

    # Agrupa títulos do SCImago
    groups = montar_grupos_titulos(scimago_df)

    # Calcula SJR fuzzy para cada SO_norm necessário
    so_to_sjr_fuzzy: dict[str, float] = {}
    for so in so_candidates:
        sjr_val = best_fuzzy_sjr_grouped(so, groups, threshold=threshold)
        so_to_sjr_fuzzy[so] = sjr_val

    # Aplica o resultado na coluna SJR
    def apply_fuzzy(row):
        if pd.isna(row["SJR"]):
            so_norm = row["SO_norm"]
            return so_to_sjr_fuzzy.get(so_norm, row["SJR"])
        return row["SJR"]

    biblio_df["SJR"] = biblio_df.apply(apply_fuzzy, axis=1)

    # Remove coluna auxiliar
    biblio_df.drop(columns=["SO_norm"], inplace=True)

    return biblio_df


def main():
    # ------------------------------------------------------------------
    # CONFIGURAÇÃO DE ARQUIVOS
    # ------------------------------------------------------------------
    # Ajuste o diretório base conforme sua máquina:
    base_dir = r"C:\Users\junio\OneDrive\AAMestrado\ArtigoAnáliseAmeaças\Estudo Bibliométrico - 2025-11-21\Ranking"

    biblio_file = "2_M_Scopus_WoS_merged_2025-11-21_clusterizado.xlsx"
    scimago_file = "scimagojr 2024.csv"
    output_file = "4_M_Scopus_WoS_merged_2025-11-21_clusterizado_SJR_fuzzy.xlsx"

    biblio_path = os.path.join(base_dir, biblio_file)
    scimago_path = os.path.join(base_dir, scimago_file)
    output_path = os.path.join(base_dir, output_file)

    print("Lendo arquivo bibliométrico:", biblio_path)
    biblio_df = pd.read_excel(biblio_path)

    print("Lendo arquivo SCImago:", scimago_path)
    scimago_df = carregar_scimago(scimago_path)

    # ------------------------------------------------------------------
    # APLICA ISSN + TÍTULO EXATO
    # ------------------------------------------------------------------
    print("Montando mapas ISSN -> SJR e Title -> SJR...")
    issn_to_sjr = montar_mapa_issn_para_sjr(scimago_df)
    title_to_sjr = montar_mapa_titulo_para_sjr(scimago_df)

    print("Aplicando correspondência por ISSN e título exato (SO)...")
    biblio_df = aplicar_sjr_exato(biblio_df, issn_to_sjr, title_to_sjr)
    preenchidos_exato = (~biblio_df["SJR"].isna()).sum()
    print(f"Registros com SJR após ISSN + título exato: {preenchidos_exato}")

    # ------------------------------------------------------------------
    # APLICA FUZZY MATCHING
    # ------------------------------------------------------------------
    print("Aplicando fuzzy matching em SO vs Title (limiar = 0.84)...")
    biblio_df = aplicar_sjr_fuzzy(biblio_df, scimago_df, threshold=0.84)
    preenchidos_total = (~biblio_df["SJR"].isna()).sum()
    print(f"Registros com SJR após fuzzy matching: {preenchidos_total}")

    # ------------------------------------------------------------------
    # SALVA RESULTADO
    # ------------------------------------------------------------------
    print("Gravando arquivo de saída:", output_path)
    biblio_df.to_excel(output_path, index=False)
    print("Concluído.")


if __name__ == "__main__":
    main()
