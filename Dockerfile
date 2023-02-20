FROM apache/airflow:2.2.0-python3.9

USER root
RUN apt update && apt install -y nano && apt-get -y install openjdk-11-jre-headless ffmpeg libsm6 libxext6
ARG SPARK_VERSION=3.2.2
ARG HADOOP_VERSION=3.2
## SPARK files and variables

ENV SPARK_HOME /usr/local/spark
# Spark submit binaries and jars (Spark binaries must be the same version of spark cluster)
RUN curl -O "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar xfz spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION /opt/spark && \
    ln -s /opt/spark/bin/* /usr/local/bin/

ENV SPARK_HOME /opt/spark
ENV HADOOP_HOME /usr/local/hadoop

EXPOSE 4040

USER airflow

COPY V1/Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl /Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl
COPY V1/Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl /Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl
COPY requirements.txt /requirements.txt
RUN  /usr/local/bin/python -m pip install --upgrade pip
RUN  cd / && pip3 install -r requirements.txt && pip3 install openlineage-airflow plyvel certifi Lyftrondata*