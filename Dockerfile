
FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y 
RUN apt-get install -y wget curl openssh-server openssh-client gzip nano
RUN apt-get install -y net-tools iputils-ping zlib1g-dev libzip-dev 
RUN apt-get install -y procps python3 pip less nginx sudo members
# iputils-ping iputils-tracepath 


RUN pip install setuptools
RUN pip install requests oauthlib pyOpenSSL 
RUN pip install flask flask-cors mysql-connector-python


COPY ./myconfig /opt/myconfig
WORKDIR /opt/myconfig

EXPOSE 22 
EXPOSE 8080

RUN printenv;
RUN chmod u+x *.sh
RUN ./update-users.sh
RUN ./post-install.sh

CMD ["/opt/myconfig/mystart.sh"];


# docker build -f ubuntu.Dockerfile -t my-ubuntu .
# docker run -d -p 2222:22 my-ubuntu
# docker run -d -p 5000-5020:5000-5020 -p 2222:22 my-ubuntu
