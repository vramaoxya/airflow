🚀 Overview

This project provides a modern containerized Analytics Engineering (AE) environment using:

Apache Airflow 3.1 (Scheduler, Webserver, DAG Processor)

dbt Core (CLI inside a dedicated container)

dbt Docs Server (served by NGINX)

PostgreSQL 15 (Airflow Metadata DB)

Docker Compose for orchestration

Airbyte Cloud for EL ingestion (triggered from Airflow)

This setup is designed for Data Engineering / Analytics Engineering teams who want a fully local, reproducible, cloud-ready orchestration platform.

🧱 Architecture

Below is the high-level architecture of the system.

                      ┌─────────────────────────┐
                      │      Airbyte Cloud       │
                      │  (Sources → Destinations)│
                      └──────────────┬───────────┘
                                     │ API v2
                                     ▼
                           ┌───────────────────┐
                           │   Airflow DAGs    │
                           │ trigger + monitor │
                           └──────────┬────────┘
                                      │
         ┌────────────────────────────┴──────────────────────────────┐
         │                    Docker Compose Stack                   │
         │                                                          │
         │  ┌──────────────────────────────┐    ┌─────────────────┐ │
         │  │ Airflow Scheduler            │    │ Airflow Webserver│ │
         │  │ - Runs tasks                 │    │ - UI on :8080    │ │
         │  │ - Reads DAGs                 │    │ - Serves logs    │ │
         │  └──────────────┬───────────────┘    └─────────────────┘ │
         │                  │                                          │
         │  ┌──────────────▼──────────────┐                           │
         │  │ Airflow DAG Processor       │                           │
         │  │ - Parses DAGs               │                           │
         │  │ - Validates Python code     │                           │
         │  └─────────────────────────────┘                           │
         │                                                              │
         │  ┌──────────────────────────────┐    ┌──────────────────┐   │
         │  │ dbt-core                     │    │ dbt-docs-server  │   │
         │  │ - dbt deps/run/build/tests   │    │ - Serves dbt docs│   │
         │  └──────────────────────────────┘    └──────────────────┘   │
         │                                                              │
         │  ┌──────────────────────────────┐                           │
         │  │ PostgreSQL                   │                           │
         │  │ - Airflow metadata database  │                           │
         │  └──────────────────────────────┘                           │
         └──────────────────────────────────────────────────────────────┘


🌐 URLs (Local Environment)
Component	URL
Airflow Web UI	http://localhost:8080

dbt Docs Server	http://localhost:8081
🧩 Containers Overview
🔵 Airflow Scheduler

Executes DAG tasks

Triggers dbt jobs, Airbyte syncs, Python tasks

Communicates with Airflow Metadata DB (Postgres)

Talks to Docker via the docker.sock mount

🔵 Airflow Webserver

Hosts Airflow UI (http://localhost:8080)

Displays DAGs, logs, task history

Reads logs via the scheduler/log processor

🔵 Airflow DAG Processor

Parses all DAGs in /opt/airflow/dags

Ensures DAGs are valid Python code

Detects import errors

🟣 dbt-core

CLI for dbt commands:

dbt deps

dbt debug

dbt build

dbt test

The project is mounted inside the container

🟣 dbt-docs-server

Serves the dbt docs website

Static hosting via NGINX on port 8081

🟢 PostgreSQL

Stores Airflow metadata:

DAG Runs

Task Instances

Variables / Connections

Logs metadata

📂 Airflow DAGs Included
DAG Name	File	Description
simple_python_dag	mon_dag1.py	Basic PythonOperator example printing logs
etl_pipeline	test1_dag.py	Example ETL flow (customize for your needs)
dbt_pipeline	dbt_steps.py	Runs dbt deps + dbt build + dbt test
airbyte_ad_clicks_sync	airbyte_test.py	Triggers Airbyte Cloud sync via API v2

Each DAG is placed in:

/mnt/data/projet1/dags


And mounted in the containers at:

/opt/airflow/dags

⚙️ Key Steps to Start the Project
1. Clone the repository
git clone https://github.com/vramaoxya/airflow.git
cd airflow

2. Build containers (fresh)
docker compose build --no-cache

3. Start the entire stack
docker compose up -d

4. Verify everything is running
docker compose ps

5. Open Airflow UI
http://localhost:8080

🛠️ Essential Docker Commands Cheat Sheet
💠 Configuration & Inspect
docker compose config

💠 Stop all containers
docker compose down

💠 Build containers without cache
docker compose build --no-cache

💠 Start containers detached
docker compose up -d

💠 Show all logs (follow mode)
docker compose logs -f

💠 Show logs per service
docker compose logs -f airflow-scheduler
docker compose logs -f airflow-dag-processor
docker compose logs -f airflow-webserver


Tail mode:

docker compose logs airflow-webserver --tail 50
docker compose logs airflow-scheduler --tail 50
docker compose logs airflow-dag-processor --tail 50

💠 Airflow DB migrations
docker compose run airflow-webserver airflow db migrate

💠 Enter containers (shell)
docker compose exec airflow-webserver bash
docker compose exec airflow-scheduler bash

💠 dbt Core commands
docker compose exec dbt-core dbt deps
docker compose exec dbt-core dbt debug
docker exec -it dbt-core dbt debug

💠 Test DAG execution manually
docker compose exec airflow-scheduler airflow dags test simple_python_dag 2025-11-24
docker compose exec airflow-scheduler airflow dags test trigger_airbyte_sync

💠 DAG diagnostics
docker compose exec airflow-scheduler airflow dags list
docker compose exec airflow-scheduler airflow dags list-import-errors
docker compose exec airflow-scheduler airflow dags delete dbt_pipeline

🔄 Data Sources & Targets (High-Level)
Sources (via Airbyte Cloud)

Typical ingestion sources:

Google Ads

Facebook Ads

HubSpot

Google Analytics

MySQL, PostgreSQL, SQL Server

File sources (S3, GCS, Azure Blob)

Your example:

ad_clicks → Data Warehouse

Targets (via dbt)

Data Warehouse (BigQuery, Snowflake, Redshift, Postgres)

Transformation models: staging, intermediate, marts

Documentation & lineage (via dbt Docs)

🎯 What This Stack Enables

✔ Modern ELT pipelines
✔ Fully orchestrated via Airflow
✔ dbt transformations automated
✔ Airbyte Cloud ingestion triggered from Airflow
✔ Automatic generation & hosting of dbt documentation
✔ Development → production reproducibility thanks to Docker

🏁 Conclusion

This environment gives your Data / Analytics Engineering team a modern, modular, cloud-ready orchestration stack using industry standards:

Airflow for orchestration

dbt for transformation

Airbyte Cloud for ingestion

Docker for reproducibility

If you want, I can also add:

Automatic tests

CI/CD GitHub Actions

A production-ready architecture

A Makefile (build/start/test)
