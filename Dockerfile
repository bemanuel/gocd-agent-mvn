FROM gocd/gocd-agent 

MAINTAINER Bruno Emanuel <bemanuel@agespisa.com.br>

ENV MVN_VER=apache-maven-3.3.9
ENV MVN_FILE=${MVN_VER}-bin.tar.gz
ENV MVN_URL=http://mirror.nbtelecom.com.br/apache/maven/maven-3/3.3.9/binaries/${MVN_FILE} \
    DEBIAN_FRONTEND="noninteractive

COPY spotify /tmp/spotify

RUN apt-get update && \
    apt-get -y install wget openjdk-7-jdk && \
    apt-get clean && \
    echo "Instalação do Maven em /usr/local/mvn" && \
    wget -t0 -c -P /tmp/ ${MVN_URL} && \
    rm -rf /var/run/cache/apt/* && \
    tar xf /tmp/${MVN_FILE} -C /usr/local/ && \   
    mv /usr/local/${MVN_VER} /usr/local/mvn && \
    rm /tmp/${MVN_FILE} && \
    echo "Preparação do Repository do Componente Docker - MVN" && \
    mkdir -p ~go/.m2/repository/com ~/.m2/repository/com && \
    cp -r /tmp/spotify ~/.m2/repository/com/. && \
    cp -r /tmp/spotify ~go/.m2/repository/com/.

#    git clone https://github.com/spotify/docker-maven-plugin.git && \
#    cd docker-maven-plugin/ && \
#    /usr/local/apache-maven-3.3.9/bin/mvn install

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#CMD ["/sbin/my_init"]
