FROM apache/airflow:2.2.0-python3.9

RUN  /bin/bash -o pipefail -o errexit -o nounset -o nolog -c pip3 install openlineage-airflow # buildkit
COPY V1/Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl /Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl
COPY V1/Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl /Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl
RUN  /usr/local/bin/python -m pip install --upgrade pip
RUN  cd / && pip3 install openlineage-airflow plyvel certifi Lyftrondata*
USER root
RUN apt update && apt install -y nano
#RUN  sed -i 's/is not/\=\!/g' /home/airflow/.local/lib/python3.9/site-packages/azure/cosmos/session.py
#RUN  sed -i 's/is/\=\=/g' /home/airflow/.local/lib/python3.9/site-packages/azure/storage/common/_connection.py