FROM eskabetxe:java8
MAINTAINER eskabetxe

# Install required packages
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
	   python \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoclean

WORKDIR /opt

ENV DISTRO_NAME=apache-storm-1.1.0

RUN wget -q "http://apache.rediris.es/storm/$DISTRO_NAME/$DISTRO_NAME.tar.gz" \
    && tar -xzf "$DISTRO_NAME.tar.gz" 

ENV STORM_DATA_DIR=/opt/storm/data \
    STORM_LOG_DIR=/opt/storm/logs

RUN mkdir -p "$STORM_DATA_DIR" "$STORM_LOG_DIR" 

WORKDIR $DISTRO_NAME

ENV PATH $PATH:/opt/$DISTRO_NAME/bin

#RUN chmod a+x */*
RUN chown root:root /opt -R

COPY storm.yaml  /opt/$DISTRO_NAME/conf/

COPY docker-entrypoint.sh  /
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
