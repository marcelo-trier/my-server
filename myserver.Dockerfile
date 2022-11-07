
# https://github.com/beneiltis/docker/blob/main/Dockerfile
# https://www.golinuxcloud.com/run-sshd-as-non-root-user-without-sudo/
# https://github.com/rastasheep/ubuntu-sshd/blob/master/Dockerfile.template

FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y 
RUN apt-get install -y wget curl openssh-server gzip nano
RUN apt-get install -y procps python3 pip less nginx sudo members
RUN apt-get install -y net-tools iputils-ping zlib1g-dev libzip-dev 
# iputils-ping iputils-tracepath 

RUN mkdir /var/run/sshd

WORKDIR /root
COPY . .
RUN chmod +x ./*.sh

RUN mv *.conf /etc/
RUN unlink /etc/nginx/sites-enabled/default
RUN mv nginx--myconfig.com /etc/nginx/sites-enabled/

RUN pip install --upgrade pip
RUN pip install -r requirements-pip.txt

RUN ./update-users.sh

#RUN apt-get clean && apt autoclean 
#RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 
EXPOSE 5000-5020


RUN service nginx start

CMD ["/usr/sbin/sshd", "-D"]


# docker build -f ubuntu.Dockerfile -t my-ubuntu .
# docker run -d -p 2222:22 my-ubuntu
# docker run -d -p 5000-5020:5000-5020 -p 2222:22 my-ubuntu

# ssh srv.us -R 1:localhost:5000
# ssh marcelo-trier@srv.us -R 1:localhost:5000
# ssh marcelo-trier@srv.us -R 1:localhost:*


# .ssh/config
# Host tunnel-srv-us
#     GatewayPorts yes
#     Tunnel yes
#     PermitRemoteOpen any
#     Hostname srv.us
#     User marcelo-trier
#     #RemoteForward 22 localhost:22
#     #RemoteForward localhost:5000
#     RemoteForward 5001 localhost:5001
#     RemoteForward 5002 localhost:5002
#     RemoteForward 5003 localhost:5003
#     RemoteForward 5004 localhost:5004
#     RemoteForward 5005 localhost:5005
#     RemoteForward 5006 localhost:5006

# comando ssh:
# ssh tunnel-srv-us
# ssh -f -N tunnel-srv-us

