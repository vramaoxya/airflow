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

