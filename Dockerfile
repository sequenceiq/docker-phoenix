FROM sequenceiq/hadoop-docker:2.5.0
MAINTAINER SequenceIQ

# hbase
RUN curl -s http://xenia.sote.hu/ftp/mirrors/www.apache.org/hbase/hbase-0.98.5/hbase-0.98.5-hadoop2-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hbase-0.98.5-hadoop2 hbase
ENV HBASE_HOME /usr/local/hbase
ENV PATH $PATH:$HBASE_HOME/bin
RUN rm $HBASE_HOME/conf/hbase-site.xml
ADD hbase-site.xml $HBASE_HOME/conf/hbase-site.xml

# zookeeper
RUN curl -s http://xenia.sote.hu/ftp/mirrors/www.apache.org/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./zookeeper-3.4.6 zookeeper
ENV ZOO_HOME /usr/local/zookeeper
ENV PATH $PATH:$ZOO_HOME/bin
RUN mv $ZOO_HOME/conf/zoo_sample.cfg $ZOO_HOME/conf/zoo.cfg
RUN mkdir /tmp/zookeeper

# phoenix
RUN curl -s http://xenia.sote.hu/ftp/mirrors/www.apache.org/phoenix/phoenix-4.1.0/bin/phoenix-4.1.0-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./phoenix-4.1.0-bin phoenix
RUN cp /usr/local/phoenix-4.1.0-bin/hadoop2/phoenix-4.1.0-client-hadoop2.jar $HBASE_HOME/lib/

# bootstrap-phoenix
ADD bootstrap-phoenix.sh /etc/bootstrap-phoenix.sh
RUN chown root:root /etc/bootstrap-phoenix.sh
RUN chmod 700 /etc/bootstrap-phoenix.sh

CMD ["/etc/bootstrap-phoenix.sh", "-bash"]
