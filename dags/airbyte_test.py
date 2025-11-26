from airflow import DAG
#from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from datetime import datetime

AIRBYTE_CONNECTION_ID = "cb471416-688b-4fae-bf3a-b672ff983458"

with DAG(
    dag_id="airbyte_ad_clicks_sync",
    start_date=datetime(2025, 11, 25),
    schedule="@daily",
    catchup=False,
    tags=["airbyte", "sync"]
) as dag:

    trigger_sync = AirbyteTriggerSyncOperator(
        task_id="trigger_airbyte_sync",
        airbyte_conn_id="airbyte_cnx",  # connexion Airflow -> Airbyte
        connection_id=AIRBYTE_CONNECTION_ID,
        asynchronous=True,
    )

trigger_sync
