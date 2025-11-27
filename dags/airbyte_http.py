from airflow import DAG
#from airflow.providers.http.operators.http import SimpleHttpOperator
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
