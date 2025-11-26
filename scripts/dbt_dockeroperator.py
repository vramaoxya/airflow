from airflow.providers.docker.operators.docker import DockerOperator

class DbtDockerOperator(DockerOperator):
    def __init__(self, command="run", project_dir="/usr/app", **kwargs):
        super().__init__(
            image="projet1-dbt-core",
            command=f"dbt {command} --project-dir {project_dir}",
            auto_remove=True,
            mount_tmp_dir=False,
            docker_url="unix://var/run/docker.sock",
            network_mode="bridge",
            **kwargs
        )

