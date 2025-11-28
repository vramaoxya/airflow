# **🚀 Overview**

This project provides a modern containerized Analytics Engineering (AE) environment using:
Apache Airflow 3.1 (Scheduler, Webserver, DAG Processor)
dbt Core (CLI inside a dedicated container)
dbt Docs Server (served by NGINX)
PostgreSQL 18 (Airflow Metadata DB)
Docker Compose for orchestration
Airbyte Cloud for EL ingestion (triggered from Airflow)
This setup is designed for Data Engineering / Analytics Engineering teams who want a fully local, reproducible, cloud-ready orchestration platform.


# 🌐Data Stack version

- OS : Ubuntu 25.10
- Docker : 29.0.2, build 8108357
- Docker Compose : v2.40.3
- Python : 3.12.12
- git : 2.39.5
- PostgreSQL : 18.1
- dbt-core : 
  - installed : 1.5.0
  - plugins :
    - bigquery: 1.5.9
- AirByte : AirByte Cloud
- Apache Airflow : 3.1.3

- Providers info
- - apache-airflow-providers-airbyte          | 5.2.5 
- - apache-airflow-providers-amazon           | 9.16.0
- - apache-airflow-providers-celery           | 3.13.0
- - apache-airflow-providers-cncf-kubernetes  | 10.9.0
- - apache-airflow-providers-common-compat    | 1.8.0 
- - apache-airflow-providers-common-io        | 1.6.4 
- - apache-airflow-providers-common-messaging | 2.0.0 
- - apache-airflow-providers-common-sql       | 1.28.2
- - apache-airflow-providers-docker           | 4.4.4 
- - apache-airflow-providers-elasticsearch    | 6.3.4 
- - apache-airflow-providers-fab              | 3.0.1 
- - apache-airflow-providers-ftp              | 3.13.2
- - apache-airflow-providers-git              | 0.0.9 
- - apache-airflow-providers-google           | 18.1.0
- - apache-airflow-providers-grpc             | 3.8.2 
- - apache-airflow-providers-hashicorp        | 4.3.3 
- - apache-airflow-providers-http             | 5.4.0 
- - apache-airflow-providers-microsoft-azure  | 12.8.0
- - apache-airflow-providers-mysql            | 6.3.4 
- - apache-airflow-providers-odbc             | 4.10.2
- - apache-airflow-providers-openlineage      | 2.7.3 
- - apache-airflow-providers-postgres         | 6.4.0 
- - apache-airflow-providers-redis            | 4.3.2 
- - apache-airflow-providers-sendgrid         | 4.1.4 
- - apache-airflow-providers-sftp             | 5.4.1 
- - apache-airflow-providers-slack            | 9.4.0 
- - apache-airflow-providers-smtp             | 2.3.1 
- - apache-airflow-providers-snowflake        | 6.6.0 
- - apache-airflow-providers-ssh              | 4.1.5 
- - apache-airflow-providers-standard         | 1.9.1 


# **🧱 Docker Architecture**

Below is the high-level architecture of the system.

                      ┌──────────────────────────┐
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
         │                                                           │
         │  ┌──────────────────────────────┐    ┌──────────────────┐ │
         │  │ Airflow Scheduler            │    │ Airflow Webserver│ │
         │  │ - Runs tasks                 │    │ - UI on :8080    │ │
         │  │ - Reads DAGs                 │    │ - Serves logs    │ │
         │  └──────────────┬───────────────┘    └──────────────────┘ │
         │                 │                                         │
         │  ┌──────────────▼──────────────┐                          │
         │  │ Airflow DAG Processor       │                          │
         │  │ - Parses DAGs               │                          │
         │  │ - Validates Python code     │                          │
         │  └─────────────────────────────┘                          │
         │                                                           │
         │  ┌──────────────────────────────┐    ┌──────────────────┐ │
         │  │ dbt-core                     │    │ dbt-docs-server  │ │
         │  │ - dbt deps/run/build/tests   │    │ - Serves dbt docs│ │
         │  └──────────────────────────────┘    └──────────────────┘ │
         │                                                           │
         │  ┌──────────────────────────────┐                         │
         │  │ PostgreSQL                   │                         │
         │  │ - Airflow metadata database  │                         │
         │  └──────────────────────────────┘                         │
         └───────────────────────────────────────────────────────────┘



# 🌐URLs (Local Environment)

Component	URL : 
- Airflow Web UI	http://localhost:8080
![Airflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_dags_home.png)

- dbt Docs Server	http://localhost:8081
![dbt docs server](https://github.com/vramaoxya/airflow/blob/main/images/dbt_docs.png)

# **🧩 Containers Overview**

## 🔵 Airflow Scheduler

Executes DAG tasks : 
- Triggers dbt jobs
- Airbyte syncs
- Python tasks
  
Communicates with Airflow Metadata DB (Postgres)
Talks to Docker via the docker.sock mount

## 🔵 Airflow Webserver

Hosts Airflow UI (http://localhost:8080)
Displays DAGs, logs, task history
Reads logs via the scheduler/log processor

## 🔵 Airflow DAG Processor

Parses all DAGs in /opt/airflow/dags
Ensures DAGs are valid Python code
Detects import errors

## 🟣 dbt-core

CLI for dbt commands:
- dbt deps
- dbt seed
- dbt debug
- dbt build
- dbt run
- dbt test
- dbt docs generate

The project is mounted inside the container

## 🟣 dbt-docs-server

Serves the dbt docs website
Static hosting via NGINX on port 8081

## 🟢 PostgreSQL

Stores Airflow metadata:
- DAG Runs
- Task Instances
- Variables / Connections
- Logs metadata

## 📂 Airflow DAGs Included

DAG Name File Description : 

- *airbyte_http.py*	(dag : airbyte_http_sync) --> Test the connexion with Airbyte
- *dbt_steps.py* (dag : dbt_pipeline) --> Run dbt deps, dbttest, dbt run, dbt docs generate
- *mon_dag1.py*	(dag : simple_python_dag) --> Basic PythonOperator example printing logs
- *test1_dag.py* (dag : etl_pipeline) -->  Example ETL flow 
- *chaine_airbyte.py* (dag : full_pipeline) : --> Complete chain ingestion : airbyte cloud + dbt seed + dbt run + dbt test + dbt docs generate

And mounted in the containers at:
- /opt/airflow/dags

## 📂 Airflow DAGs scripts

airbyte_http.py
```python
from airflow import DAG
from airflow.providers.http.operators.http import HttpOperator
from datetime import datetime
import json

AIRBYTE_CONNECTION_ID = "cb471416-688b-4fae-bf3a-b672ff983458"

with DAG(
    dag_id="airbyte_http_sync",
    start_date=datetime(2025, 11, 26),
    schedule="@daily",
    catchup=False
) as dag:

    trigger_sync = HttpOperator(
        task_id="trigger_airbyte_sync",
        http_conn_id="airbyte_cnx",
        #endpoint="/v2/jobs",
        method="POST",
        headers={"Content-Type": "application/json"},
        data=json.dumps({
            "jobType": "sync",
            "connectionId": AIRBYTE_CONNECTION_ID
        }),
        log_response=True,
    )

trigger_sync
```


![Workflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_graph_airbyte_http_sync.png)


dbt_steps.py 
```python
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Définir les arguments globaux du DAG
default_args = {
    'start_date': datetime(2025, 11, 17),
    'retries': 1
}

# Déclaration du DAG
with DAG(
    dag_id="dbt_pipeline",
    default_args=default_args,
    schedule="@daily",
    catchup=False,
    tags=["dbt", "pipeline"]
) as dag:
    # Etape 0 : test le PATH
    dbt_path = BashOperator(
        task_id="dbt_path",
        bash_command="echo $PATH "
    )
    # Étape 1 : téléchargement des dépendances dbt
    dbt_deps = BashOperator(
        task_id="dbt_deps",
        bash_command="docker exec -it dbt-core dbt deps "
    )
    # Étape 2 : exécution des modèles dbt
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="docker exec -it dbt-core dbt run "
    )
    # Étape 3 : exécution des tests de qualité
    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="docker exec -it dbt-core dbt test "
    )
    # Étape 4 : génération de la documentation statique
    dbt_docs = BashOperator(
        task_id="dbt_docs",
        bash_command="docker exec -it dbt-core dbt docs generate "
    )
    # Définition de la chaîne de dépendances
    dbt_path >> dbt_deps >> dbt_run >> dbt_test >> dbt_docs
```


![Workflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_graph_dbt_pipeline.png)


mon_dag1.py
````python
from airflow import DAG
#from airflow.operators.empty.EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.operators.empty import EmptyOperator
from datetime import datetime

def print_hello():
    print("Hello from Airflow!")

with DAG(
    dag_id='simple_python_dag',
    schedule='@daily',
    start_date=datetime(2025, 11, 24),
    catchup=False,
) as dag:

    start = EmptyOperator(task_id='start')
    python_task = PythonOperator(
        task_id='python_task',
        python_callable=print_hello
    )
    end = EmptyOperator(task_id='end')

    start >> python_task >> end

```


![Workflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_graph_simple_python_dag.png)


test1_dag.py
```python
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime


def extract():
    print("Extracting data...")

def transform():
    print("Transforming data...")

def load():
    print("Loading data...")

def normalize():
    print("Normalizing data...")

def clean():
    print("Cleaning data...")

dag = DAG(
    'etl_pipeline',
    schedule='@daily',
    start_date=datetime(2025, 11, 16),
    catchup=False
)

extract_task = PythonOperator(task_id='extract', python_callable=extract, dag=dag)
transform_task = PythonOperator(task_id='transform', python_callable=transform, dag=dag)
load_task = PythonOperator(task_id='load', python_callable=load, dag=dag)
normalize_task = PythonOperator(task_id='normalize', python_callable=normalize, dag=dag)
clean_task = PythonOperator(task_id='clean', python_callable=clean, dag=dag)

extract_task >> [transform_task, normalize_task]
transform_task >> load_task
normalize_task >> clean_task >> load_task
```


![Workflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_graph_etl_pipeline.png)


chaine_airbyte.py
````python
from airflow import DAG
from airflow.operators.bash import BashOperator
#from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.providers.http.operators.http import HttpOperator
from datetime import datetime
import json

AIRBYTE_CONNECTION_ID = "cb471416-688b-4fae-bf3a-b672ff983458"

# Définir les arguments globaux du DAG
default_args = {
    'start_date': datetime(2025, 11, 17),
    'retries': 1
}

# Déclaration du DAG
with DAG(
    dag_id="full_pipeline",
    default_args=default_args,
    schedule="@daily",
    catchup=False,
    tags=["dbt", "airbyte", "pipeline"]
) as dag:
    # Etape 0 : test le PATH & import de fichier csv dans BigQuery avec dbt
    dbt_path = BashOperator(
        task_id="dbt_path",
        bash_command="echo $PATH "
    )
    # Étape 1 : chgargement données dans BigQuery avec Airbyte et dbt seed
    dbt_seed = BashOperator(
        task_id="dbt_seed",
        bash_command="docker exec -it dbt-core dbt seed "
    )
    airbyte_sync = HttpOperator(
        task_id="trigger_airbyte_sync",
        http_conn_id="airbyte_cnx",
        method="POST",
        headers={"Content-Type": "application/json"},
        data=json.dumps({
            "jobType": "sync",
            "connectionId": AIRBYTE_CONNECTION_ID
        }),
        log_response=True,
    )
    # Étape 2 : téléchargement des dépendances dbt
    dbt_deps = BashOperator(
        task_id="dbt_deps",
        bash_command="docker exec -it dbt-core dbt deps "
    )
    # Étape 3 : exécution des modèles dbt
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="docker exec -it dbt-core dbt run "
    )
    # Étape 4 : exécution des tests de qualité
    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="docker exec -it dbt-core dbt test "
    )
    # Étape 5 : génération de la documentation statique
    dbt_docs = BashOperator(
        task_id="dbt_docs",
        bash_command="docker exec -it dbt-core dbt docs generate "
    )
    # Définition de la chaîne de dépendances
    dbt_path >> [dbt_seed,airbyte_sync] >> dbt_deps >> dbt_run >> dbt_test >> dbt_docs
```


![Workflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_graph_full_pipeline.png)


# ⚙️ Key Steps to Start the Project

## 1. Clone the repository

git clone https://github.com/vramaoxya/airflow.git
cd airflow

## 2. Build containers (fresh)

docker compose build --no-cache

## 3. Start the entire stack

docker compose up -d

## 4. Verify everything is running

docker compose ps

## 5. Open Airflow UI

http://localhost:8080

![Workflow](https://github.com/vramaoxya/airflow/blob/main/images/airflow_dags_home.png)

# 🛠️ Essential Docker Commands Cheat Sheet

### 💠 Configuration & Inspect
docker compose config

### 💠 Stop all containers
docker compose down

### 💠 Build containers without cache
docker compose build --no-cache

### 💠 Start containers detached
docker compose up -d

### 💠 Show all logs (follow mode)
docker compose logs -f

### 💠 Show logs per service
- docker compose logs -f airflow-scheduler
- docker compose logs -f airflow-dag-processor
- docker compose logs -f airflow-webserver


### Tail mode example

- docker compose logs airflow-webserver --tail 50
- docker compose logs airflow-scheduler --tail 50
- docker compose logs airflow-dag-processor --tail 50

### 💠 Airflow DB migrations
- docker compose run airflow-webserver airflow db migrate

### 💠 Enter containers (shell)
- docker compose exec airflow-webserver bash
- docker compose exec airflow-scheduler bash

### 💠 dbt Core commands
- docker compose exec dbt-core dbt deps
- docker compose exec dbt-core dbt debug
- docker exec -it dbt-core dbt debug

### 💠 Test DAG execution manually
- docker compose exec airflow-scheduler airflow dags test simple_python_dag 2025-11-24
- docker compose exec airflow-scheduler airflow dags test trigger_airbyte_sync 2025-11-24

### 💠 DAG diagnostics
- docker compose exec airflow-scheduler airflow dags list
- docker compose exec airflow-scheduler airflow dags list-import-errors
- docker compose exec airflow-scheduler airflow dags delete <dag>

# 🔄 Data Sources & Targets (High-Level)

## Sources (via Airbyte Cloud)

![Airbyte](https://github.com/vramaoxya/airflow/blob/main/images/dbt_docs.png)

### Typical ingestion sources:

CSV Files

Example:
ad_clicks → Data Warehouse
![Airbyte](https://github.com/vramaoxya/airflow/blob/main/images/airbyte_connexion.png)


### Targets (via dbt)

- Data Warehouse : BigQuery 
- Transformation models: staging, intermediate, marts
- Documentation & lineage (via dbt Docs)
- ![alt text](https://github.com/vramaoxya/localbike "dbt localbike")

## 🎯 What This Stack Enables

- ✔ Modern ELT pipelines
- ✔ Fully orchestrated via Airflow
- ✔ dbt transformations automated
- ✔ Airbyte Cloud ingestion triggered from Airflow
- ✔ Automatic generation & hosting of dbt documentation
- ✔ Development → production reproducibility thanks to Docker

# 🏁 Conclusion

This environment gives your Data / Analytics Engineering team a modern, modular, cloud-ready orchestration stack using industry standards:

- Airflow for orchestration
- dbt for transformation
- Airbyte Cloud for ingestion
- Docker for reproducibility
- CI/CD GitHub for repository
- A production-ready architecture
