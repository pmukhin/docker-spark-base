FROM alpine:3.8

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SCALA_VERSION=2.11.11 \
    SCALA_HOME=/usr/share/scala

ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /

COPY ivy2-cache.tar /

RUN apk add --no-cache curl busybox-extras bash openjdk8-jre python3 py-pip nss \
      && chmod +x *.sh \
      && echo "dowloading spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" \
      && wget "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
      && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
      && cd /
      
RUN apk add --no-cache --virtual=.build-dependencies coreutils wget ca-certificates \
      && apk add --no-cache bash curl jq \
      && cd "/tmp" \
      && wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" \
      && tar xzf "scala-${SCALA_VERSION}.tgz" \
      && mkdir "${SCALA_HOME}" \
      && rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat \
      && mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" \
      && ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" \
      && apk del .build-dependencies \
      && rm -rf "/tmp/"*
 
RUN mkdir -p "/usr/local/sbt"
RUN  apk update && apk add ca-certificates wget tar \
      && wget -qO - --no-check-certificate "https://piccolo.link/sbt-1.2.8.tgz" \
                                    | tar xz -C /usr/local/sbt --strip-components=1 \
      && touch "$HOME/.profile" \
      && echo 'export PATH="/usr/local/sbt/bin:$PATH"' >> "$HOME/.profile" \      
      && source "$HOME/.profile" \                            
      && sbt sbtVersion 

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh \
      && chmod +x /execute-step.sh && chmod +x /finish-step.sh

RUN touch /ver.txt && echo "ok" >> /ver.txt

RUN tar -C "$HOME/.ivy2" -zxvf /ivy2-cache.tar

RUN mkdir -p /tmp/spark-events

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1
