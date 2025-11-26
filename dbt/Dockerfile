FROM python:3.12-slim
#FROM python:latest

USER root
# Installer dépendances système
# RUN apt-get update && apt-get install -y gcc git && apt-get clean
#RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
# Empêcher les warnings de dépôt Debian "trixie/testing"
RUN apt-get update --allow-releaseinfo-change && \
    apt-get install -y --no-install-recommends gcc git && \
    rm -rf /var/lib/apt/lists/*

# Installer dbt-core + dbt-bigquery (dernière version publiée)
#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir "dbt-core=1.5.0" "dbt-bigquery"

RUN pip install --no-cache-dir \
    dbt-core==1.5.0 \
    dbt-bigquery

WORKDIR /usr/app/dbt

CMD ["bash"]
