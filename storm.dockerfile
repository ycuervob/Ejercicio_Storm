# Use the official Ubuntu base image
FROM ubuntu:latest

# Update the package lists
RUN apt-get update

# Install curl
RUN apt-get install -y curl

# Install python
RUN apt-get install -y python3

# Install git
RUN apt-get install -y git

RUN apt install nano -y

# Set the working directory
WORKDIR /app

# Install Java 8
RUN apt-get install -y openjdk-11-jdk
RUN export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Install Java 11
#COPY jdk-11.0.22_linux-x64_bin.deb .
#RUN dpkg -i jdk-11.0.22_linux-x64_bin.deb
#RUN export JAVA_HOME=/usr/lib/jvm/jdk-11-oracle-x64

RUN curl -O https://dlcdn.apache.org/zookeeper/zookeeper-3.8.4/apache-zookeeper-3.8.4-bin.tar.gz
RUN tar -zxf apache-zookeeper-3.8.4-bin.tar.gz
RUN cd apache-zookeeper-3.8.4-bin && mkdir data
RUN echo "tickTime=2000" > apache-zookeeper-3.8.4-bin/conf/zoo.cfg
RUN echo "dataDir=/app/apache-zookeeper-3.8.4-bin/data" >> apache-zookeeper-3.8.4-bin/conf/zoo.cfg
RUN echo "clientPort=2181" >> apache-zookeeper-3.8.4-bin/conf/zoo.cfg
RUN echo "initLimit=5" >> apache-zookeeper-3.8.4-bin/conf/zoo.cfg
RUN echo "syncLimit=2" >> apache-zookeeper-3.8.4-bin/conf/zoo.cfg
Run echo "admin.serverPort=8081" >> apache-zookeeper-3.8.4-bin/conf/zoo.cfg

# Instalar apache storm 
RUN curl -O https://dlcdn.apache.org/storm/apache-storm-2.6.2/apache-storm-2.6.2.tar.gz
RUN tar -zxf apache-storm-2.6.2.tar.gz
RUN cd apache-storm-2.6.2 && mkdir data
RUN echo "storm.zookeeper.servers:" > apache-storm-2.6.2/conf/storm.yaml
RUN echo "  - \"localhost\"" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "storm.local.dir: \"/app/apache-storm-2.6.2/data\"" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "nimbus.host: \"localhost\"" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "supervisor.slots.ports:" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "  - 6700" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "  - 6701" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "  - 6702" >> apache-storm-2.6.2/conf/storm.yaml
RUN echo "  - 6703" >> apache-storm-2.6.2/conf/storm.yaml

# Clone the repository
RUN git clone https://github.com/DavidHernandez2001/example-apache-storm.git

Copy start.sh /app/start.sh

EXPOSE 2181 6700 6701 6702 6703 8080 6627

# Run the command on container startup
CMD ["/bin/sh", "-c" ,"/app/start.sh"]

