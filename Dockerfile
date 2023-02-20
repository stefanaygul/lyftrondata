FROM apache/airflow:2.2.0-python3.9

RUN  /bin/bash -o pipefail -o errexit -o nounset -o nolog -c pip3 install openlineage-airflow # buildkit
COPY V1/Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl /Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl
COPY V1/Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl /Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl
RUN  /usr/local/bin/python -m pip install --upgrade pip
RUN  cd / && pip3 install openlineage-airflow plyvel certifi Lyftrondata* pyspark apache-airflow-providers-apache-spark
USER root
RUN apt update && apt install -y nano && apt-get -y install openjdk-11-jre-headless ffmpeg libsm6 libxext6
USER airflow