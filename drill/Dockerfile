FROM eskabetxe:java8
MAINTAINER eskabetxe

ARG ZOOKEEPER

ENV DRILL_VERSION 1.10.0
ENV KUDU_VERSION 1.3.0
ENV DRILL_HOME /opt/apache-drill-$DRILL_VERSION

# download
WORKDIR /opt
RUN wget http://apache.rediris.es/drill/drill-$DRILL_VERSION/apache-drill-$DRILL_VERSION.tar.gz \
    && tar -xzf apache-drill-$DRILL_VERSION.tar.gz

WORKDIR $DRILL_HOME

COPY drill-kudu-storage-$DRILL_VERSION.jar $DRILL_HOME/jars/
COPY kudu-client-$KUDU_VERSION.jar $DRILL_HOME/jars/3rdparty/

EXPOSE 8047 31010 31011 31012 46655

ADD start-drill.sh bin/start-drill.sh
RUN chmod a+x bin/*.sh

RUN sed -i -e 's/nohup \(\$thiscmd .* 2>&1\).*/\1/' $DRILL_HOME/bin/drillbit.sh
RUN  sed -i -e 's/\(\$command .* 2>&1\).*/\1/' $DRILL_HOME/bin/drillbit.sh


VOLUME ["$DRILL_HOME/log"]
CMD bin/start-drill.sh && tail -f log/drillbit.out

