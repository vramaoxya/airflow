FROM apache/airflow:latest

USER root

# Créer le groupe docker avec le même GID que sur le HOST (1000)
RUN groupadd -g 990 docker || true

# Ajouter airflow dans le groupe docker
RUN usermod -aG docker airflow

# Installer Docker Engine client (docker CLI)
#RUN apt-get update && \
#    apt-get install -y docker.io && \
#    apt-get clean

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin vim && \
    apt-get clean

# Installer Docker Compose (v2)
RUN curl -SL https://github.com/docker/compose/releases/download/v2.28.5/docker-compose-$(uname -s)-$(uname -m) \
    -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


# Installer Docker Compose (v2)
#RUN curl -SL https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-linux-x86_64 \
#    -o /usr/local/bin/docker-compose && \
#    chmod +x /usr/local/bin/docker-compose


USER airflow 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
