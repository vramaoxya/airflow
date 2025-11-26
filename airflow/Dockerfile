FROM apache/airflow:latest

USER root
RUN apt-get update && \
    apt-get install -y vim && \
    rm -rf /var/lib/apt/lists/*

USER airflow 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

