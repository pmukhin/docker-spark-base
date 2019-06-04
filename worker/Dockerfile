FROM mukhin/spark-base:2.4.3-hadoop2.7

MAINTAINER Pavel Mukhin <pauri.lentonen@gmail.com>

HEALTHCHECK CMD curl -f http://localhost:8081/ || exit 1

COPY worker.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

EXPOSE 8081

CMD ["/bin/bash", "/worker.sh"]
