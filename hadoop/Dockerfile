FROM eskabetxe:java
MAINTAINER eskabetxe

# prepare
RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y  \
		wget openssh-server openssh-client \
	&& rm -rf /var/lib/apt/lists/* \
    && apt-get autoclean


# hadoop
WORKDIR /opt
RUN wget http://apache.rediris.es/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz \
    && tar -xzf /opt/hadoop-2.7.3.tar.gz \
    && mv hadoop-2.7.3 hadoop \
    && rm hadoop-2.7.3.tar.gz



RUN echo 'export PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin' >> ~/.bashrc 
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/' >> /opt/hadoop/etc/hadoop/hadoop-env.sh
RUN echo 'export HADOOP_PREFIX=/opt/hadoop' >> /opt/hadoop/etc/hadoop/hadoop-env.sh

# pseudo distributed
ADD core-site.xml /opt/hadoop/etc/hadoop/core-site.xml
ADD hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml
ADD mapred-site.xml /opt/hadoop/etc/hadoop/mapred-site.xml
ADD yarn-site.xml /opt/hadoop/etc/hadoop/yarn-site.xml


#RUN addgroup hadoop \
#    && adduser --ingroup hadoop hadoop \
#    && chown -R hadoop:hadoop /opt/hadoop
#USER hadoop

# SSH keygen Passwordless
RUN ssh-keygen -t rsa -P "" -f "/root/.ssh/id_rsa" \
 && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
 && chmod 644 /root/.ssh/authorized_keys

# disable ssh strict host key check
#RUN sed -i '/StrictHostKeyChecking/s/#//g' /etc/ssh/ssh_config \
#&& sed -i '/StrictHostKeyChecking/s/ask/no/g' /etc/ssh/ssh_config

# workingaround docker.io build error
RUN ls -la /opt/hadoop/etc/hadoop/*-env.sh
RUN chmod +x /opt/hadoop/etc/hadoop/*-env.sh
RUN ls -la /opt/hadoop/etc/hadoop/*-env.sh


RUN /opt/hadoop/bin/hdfs namenode -format

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
CMD ["/etc/bootstrap.sh", "-d"]

RUN echo done
# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000
# Mapred ports
EXPOSE 10020 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 2122