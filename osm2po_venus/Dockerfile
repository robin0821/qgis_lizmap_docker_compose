FROM ubuntu:18.04
MAINTAINER robin0821@gmail.com

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install default-jre -y
RUN apt-get install wget unzip -y
RUN mkdir osm2po
RUN cd osm2po
RUN wget https://osm2po.de/releases/osm2po-5.2.43.zip
RUN unzip osm2po-5.2.43.zip
ADD https://raw.githubusercontent.com/robin0821/qgis_lizmap_docker_compose/master/osm2po_docker/australia.sh .
ADD https://raw.githubusercontent.com/robin0821/qgis_lizmap_docker_compose/master/osm2po_docker/osm2po.config .
ADD https://raw.githubusercontent.com/robin0821/qgis_lizmap_docker_compose/master/osm2po_docker/start_server.sh .
RUN echo "yes" | sh australia.sh
RUN chmod 777 start_server.sh

EXPOSE 8888
ENTRYPOINT [ "./start_server.sh" ]
