FROM eskabetxe:java-jre-8
MAINTAINER eskabetxe

# prepare
RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y  \
		wget openssh-server vim \
	&& rm -rf /var/lib/apt/lists/*


ENV ZOOKEEPER_VERSION 3.4.9
ENV ZOOKEEPER_HOME /opt/zookeeper-$ZOOKEEPER_VERSION

# download
WORKDIR /opt
RUN wget http://apache.rediris.es/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz \
    && tar -xzf $ZOOKEEPER_HOME.tar.gz

WORKDIR $ZOOKEEPER_HOME
RUN mv conf/zoo_sample.cfg conf/zoo.cfg
RUN sed -i "s|/tmp/zookeeper|$ZOOKEEPER_HOME/data|g" conf/zoo.cfg; mkdir data

ADD start-zookeeper.sh /usr/bin/start-zk.sh
RUN chmod a+x /usr/bin/start-zk.sh
EXPOSE 2181 2888 3888

VOLUME ["$ZOOKEEPER_HOME/conf", "$ZOOKEEPER_HOME/data"]

#CMD /usr/sbin/sshd && bash /usr/bin/start-zk.sh

CMD ["/usr/bin/start-zk.sh", "-d"]