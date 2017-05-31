FROM eskabetxe:java8
MAINTAINER eskabetxe

# prepare
RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y  \
		supervisor docker.io net-tools \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get autoclean

ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.10.2.0
ENV KAFKA_HOME /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION

# download
WORKDIR /opt
RUN wget http://apache.rediris.es/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz \
    && tar -xzf $KAFKA_HOME.tgz

ENV PATH ${PATH}:${KAFKA_HOME}/bin

ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
ADD create-topics.sh /usr/bin/create-topics.sh
RUN chmod a+x /usr/bin/start-kafka.sh \
    && chmod a+x /usr/bin/broker-list.sh \
    && chmod a+x /usr/bin/create-topics.sh

VOLUME ["/kafka"]

CMD ["start-kafka.sh"]
