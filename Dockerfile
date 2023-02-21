FROM apache/airflow:2.2.0-python3.9

USER root
RUN apt update && apt install -y nano && apt-get -y install openjdk-11-jre-headless ffmpeg libsm6 libxext6
ARG SPARK_VERSION=3.2.2
ARG HADOOP_VERSION=3.2



ENV SPARK_HOME /usr/local/spark
# Spark submit binaries and jars (Spark binaries must be the same version of spark cluster)
RUN curl -O "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar xfz spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz && \
    mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION /opt/spark && \
    ln -s /opt/spark/bin/* /usr/local/bin/

ENV SPARK_HOME /opt/spark
ENV HADOOP_HOME /usr/local/hadoop

USER airflow

COPY requirements.txt /requirements.txt
RUN  /usr/local/bin/python -m pip3 install --upgrade pip
RUN  cd / && pip3 install -r requirements.txt