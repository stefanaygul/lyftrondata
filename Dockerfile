FROM apache/airflow:2.2.0-python3.9

RUN  /usr/local/bin/python -m pip install --upgrade pip
COPY V1/Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl /Lyftrondata_Airflow_SDK_Linux_py3.9-0.0.1-py3-none-any.whl
COPY V1/Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl /Lyftrondata_Gorgias_Linux_3.9-0.0.1-py3-none-any.whl
RUN pip3 install openlineage-airflow plyvel certifi Lyftrondata*