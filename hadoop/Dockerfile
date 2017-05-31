FROM eskabetxe:java8
MAINTAINER eskabetxe

# prepare
RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y  \
		wget openssh-server openssh-client \
	&& rm -rf /var/lib/apt/lists/* \
    && apt-get autoclean


ENV HADOOP_VERSION 2.8.0
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

# hadoop
WORKDIR /opt
RUN wget http://apache.rediris.es/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && tar -xzf /opt/hadoop-$HADOOP_VERSION.tar.gz

RUN echo 'export PATH=$PATH:'$HADOOP_HOME'/bin:/opt/hadoop/sbin' >> ~/.bashrc
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/' >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo 'export HADOOP_PREFIX='$HADOOP_HOME >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh


# pseudo distributed
ADD core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
ADD yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml

RUN sed -i -e 's/HOST/'"${HADOOP_NAMENODE-localhost}"'/' $HADOOP_HOME/etc/hadoop/core-site.xml
RUN sed -i -e 's/VERSION/'"$HADOOP_VERSION"'/' $HADOOP_HOME/etc/hadoop/core-site.xml

#RUN addgroup hadoop \
#    && adduser --ingroup hadoop hadoop \
#    && chown -R hadoop:hadoop $HADOOP_HOME
#USER hadoop

RUN chown root:root $HADOOP_HOME -R

# SSH keygen Passwordless
RUN ssh-keygen -t rsa -P "" -f "/root/.ssh/id_rsa" \
 && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
 && chmod 644 /root/.ssh/authorized_keys

# disable ssh strict host key check
RUN sed -i '/StrictHostKeyChecking/s/#//g' /etc/ssh/ssh_config \
 && sed -i '/StrictHostKeyChecking/s/ask/no/g' /etc/ssh/ssh_config

# workingaround docker.io build error
RUN ls -la $HADOOP_HOME/etc/hadoop/*-env.sh
RUN chmod +x $HADOOP_HOME/etc/hadoop/*-env.sh
RUN ls -la $HADOOP_HOME/etc/hadoop/*-env.sh

RUN $HADOOP_HOME/bin/hdfs namenode -format -Y

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
CMD ["/etc/bootstrap.sh", "-d"]

WORKDIR $HADOOP_HOME

RUN echo done
# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122
