FROM apache/airflow:2.2.0-python3.9


ARG SPARK_VERSION=3.2.2
ARG HADOOP_VERSION=3.2
RUN  /bin/bash -o pipefail -o errexit -o nounset -o nolog -c pip3 install openlineage-airflow # buildkit
COPY V1/Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl /Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl
COPY V1/Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl /Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl
RUN  /usr/local/bin/python -m pip install --upgrade pip
RUN  cd / && pip3 install openlineage-airflow plyvel certifi Lyftrondata* pyspark
USER root
RUN apt update && apt install -y nano && apt-get -y install openjdk-11-jre-headless ffmpeg libsm6 libxext6 curl mlocate git scala
## SPARK files and variables

ENV SPARK_HOME /usr/local/spark

# Spark submit binaries and jars (Spark binaries must be the same version of spark cluster)
RUN cd "/tmp"
RUN curl -O "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
RUN tar -xvzf "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
RUN mkdir -p "${SPARK_HOME}/bin"
RUN mkdir -p "${SPARK_HOME}/assembly/target/scala-2.12/jars"
RUN cp -a "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}/bin/." "${SPARK_HOME}/bin/"
RUN cp -a "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}/jars/." "${SPARK_HOME}/assembly/target/scala-2.12/jars/"
RUN rm "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

# Create SPARK_HOME env var
RUN export SPARK_HOME
ENV PATH $PATH:/usr/local/spark/bin

USER airflow
