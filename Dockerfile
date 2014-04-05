FROM sequenceiq/hadoop-docker
MAINTAINER SequenceIQ

# hbase
RUN curl -s http://xenia.sote.hu/ftp/mirrors/www.apache.org/hbase/hbase-0.98.0/hbase-0.98.0-hadoop2-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s hbase-0.98.0-hadoop2 hbase
ENV HBASE_HOME /usr/local/hbase
ENV PATH $PATH:$HBASE_HOME/bin
ADD hbase-site.xml $HBASE_HOME/conf/hbase-site.xml

# zookeeper
RUN curl -s http://xenia.sote.hu/ftp/mirrors/www.apache.org/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s zookeeper-3.4.6 zookeeper
ENV ZOO_HOME /usr/local/zookeeper
ENV PATH $PATH:$ZOO_HOME/bin
RUN mv $ZOO_HOME/conf/zoo_sample.cfg $ZOO_HOME/conf/zoo.cfg
RUN mkdir /tmp/zookeeper

# phoenix
RUN curl -s http://xenia.sote.hu/ftp/mirrors/www.apache.org/incubator/phoenix/phoenix-3.0.0-incubating/bin/phoenix-3.0.0-incubating.tar.gz | tar -zx -C /usr/local
RUN cp /usr/local/phoenix-3.0.0-incubating/common/phoenix-core-3.0.0-incubating.jar $HBASE_HOME/lib/

# bootstrap-phoenix
ADD bootstrap-phoenix.sh /etc/bootstrap-phoenix.sh
RUN chown root:root /etc/bootstrap-phoenix.sh
RUN chmod 700 /etc/bootstrap-phoenix.sh

CMD ["/etc/bootstrap-phoenix.sh", "-bash"]
