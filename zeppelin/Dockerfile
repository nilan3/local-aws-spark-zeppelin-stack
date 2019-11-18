FROM nilan3/spark-base:2.4.4

ENV ZEPPELIN_VERSION=0.8.2
ENV SPARK_WORKER_WEBUI_PORT 8082
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"
ENV SPARK_APP_NAME zeppelin

RUN wget http://apache.mirror.anlx.net/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz -O /tmp/zeppelin.tgz \
  && mkdir /zeppelin \
  && tar zxf /tmp/zeppelin.tgz -C /zeppelin --strip-components 1 \
  && rm -rf /tmp/*

COPY zeppelin-site.xml /zeppelin/conf/zeppelin-site.xml

ENV PATH=/zeppelin/bin:$PATH

EXPOSE 7000

CMD ["zeppelin.sh"]
