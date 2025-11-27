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
