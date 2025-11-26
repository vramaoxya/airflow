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

