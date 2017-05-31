FROM eskabetxe:java8
MAINTAINER eskabetxe


WORKDIR /opt

ENV FLINK_VERSION=1.2.1 \
	SCALA_VERSION=2.11 \
	HADOOP_VERSION=27 
ENV	FLINK_DIRECTORY=/opt/flink-$FLINK_VERSION


RUN wget -O $FLINK_DIRECTORY.tgz -q "http://apache.rediris.es/flink/flink-$FLINK_VERSION/flink-$FLINK_VERSION-bin-hadoop$HADOOP_VERSION-scala_$SCALA_VERSION.tgz"  \
    && tar -xzf "$FLINK_DIRECTORY.tgz" 

ENV PATH $PATH:$FLINK_DIRECTORY/bin

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

RUN chown root:root /opt -R


EXPOSE 8081 6123
ENTRYPOINT ["/docker-entrypoint.sh"]
