Apache Phoenix on Docker
==============
[![DockerPulls](https://img.shields.io/docker/pulls/sequenceiq/phoenix.svg)](https://registry.hub.docker.com/u/sequenceiq/phoenix/)
[![DockerStars](https://img.shields.io/docker/stars/sequenceiq/phoenix.svg)](https://registry.hub.docker.com/u/sequenceiq/phoenix/)

A Docker image to quick start [Apache Phoenix](http://phoenix.apache.org/) on [Apache HBase](https://hbase.apache.org/)
to provide an SQL interface.

Apache Phoenix is a SQL skin over HBase delivered as a client-embedded JDBC driver targeting low latency queries over HBase data. Apache Phoenix takes your SQL query, compiles it into a series of HBase scans, and orchestrates the running of those scans to produce regular JDBC result sets. The table metadata is stored in an HBase table and versioned, such that snapshot queries over prior versions will automatically use the correct schema. Direct use of the HBase API, along with coprocessors and custom filters, results in performance on the order of milliseconds for small queries, or seconds for tens of millions of rows.

###Versions
Apache Hadoop - 2.7.0  
Apache HBase - 0.98.x, 1.0.x, 1.1.x
Apache Phoenix - 4.4.0+

###Launch
`docker run -it sequenceiq/phoenix` -> to normal launch

`docker run -it -p 8765:8765 sequenceiq/phoenix` -> if you want to use the queryserver

`queryserver.py` -> to launch the Phoenix Avatica queryserver to handle REST requests over wire protocol

or `queryserver.py start` -> to launch in the background

###Alternative launch
`docker run -it sequenceiq/phoenix /etc/bootstrap-phoenix.sh -sqlline` -> to launch directly the sqlline for phoenix
