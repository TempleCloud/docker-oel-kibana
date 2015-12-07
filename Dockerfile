FROM oraclelinux:7.2

MAINTAINER Timothy Langford

<<<<<<< 9e085055c6c97428ea60080068c02af84b41381d
RUN yum -y update
RUN yum -y install wget

# Install Oracle Java
RUN wget --no-cookies \
         --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jre-8u65-linux-x64.rpm"
RUN yum -y localinstall jre-8u65-linux-x64.rpm
RUN rm -f jre-8u65-linux-x64.rpm
ENV JAVA_HOME=/usr/java/jre1.8.0_65
=======
# RUN yum -y update
RUN yum -y install tar
>>>>>>> Initial checkin. Basic Kibana OEL Dockerfile.

# Install Elasticsearch
ENV KIBANA_HOME=/opt/kibana
RUN mkdir -p $KIBANA_HOME
ADD https://download.elastic.co/kibana/kibana/kibana-4.3.0-linux-x64.tar.gz .
RUN tar zxf kibana-4.3.0-linux-x64.tar.gz
RUN mv kibana-4.3.0-linux-x64 kibana
RUN mv kibana /opt
RUN rm kibana-4.3.0-linux-x64.tar.gz

# Create Kibana config
COPY kibana/config/ $KIBANA_HOME/config

# Configure an kibana user
RUN groupadd -g 1005 kibana
RUN useradd -u 1005 -g 1005 kibana

# Mount Elasticsearch '/data' volume
RUN chown -R kibana $KIBANA_HOME
# VOLUME ["/data"]

# Mount Kibana certs
# VOLUME ["/$KIBANA_HOME/config/certs"]

EXPOSE 5601

# Run Kibana as user 'kibana'
USER kibana
CMD ["/opt/kibana/bin/kibana"]
# CMD ["/bin/bash"]
