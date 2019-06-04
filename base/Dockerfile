FROM bde2020/hadoop-base:2.0.0-hadoop2.7.4-java8

MAINTAINER Pavel Mukhin <pauri.lentonen@gmail.com>

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

RUN apt-get update \
      && apt-get install -y wget \
      && wget https://www-eu.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz \
      && apt-get --purge remove -y wget \
      && tar -xvzf spark-2.4.3-bin-hadoop2.7.tgz \
      && mv spark-2.4.3-bin-hadoop2.7 spark \
      && rm spark-2.4.3-bin-hadoop2.7.tgz \
      && cd /

ENV SPARK_HOME /spark/

COPY hive-site.xml /spark/conf/

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
