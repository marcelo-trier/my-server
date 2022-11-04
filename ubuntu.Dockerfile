
# https://github.com/beneiltis/docker/blob/main/Dockerfile
# https://www.golinuxcloud.com/run-sshd-as-non-root-user-without-sudo/
# https://github.com/rastasheep/ubuntu-sshd/blob/master/Dockerfile.template

FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get upgrade -y 
RUN apt-get install -y wget openssh-server 
RUN apt-get install -y net-tools nano gzip iputils-ping procps curl python3 pip less

# openssh-server net-tools nano apt-utils zlib1g-dev libzip-dev unzip zip 
# iputils-ping iputils-tracepath procps curl wget 
# nginx

RUN mkdir /var/run/sshd

WORKDIR /root
COPY . .
RUN chmod +x ./*.sh
RUN mv pip.conf /etc/
RUN pip install --upgrade pip
RUN pip install -r requirements-pip.txt

RUN ./update-users.sh

RUN apt-get clean && apt autoclean 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 
EXPOSE 5000-5020

CMD ["/usr/sbin/sshd", "-D"]


# docker build -f ubuntu.Dockerfile -t my-ubuntu .
# docker run -d -p 2222:22 my-ubuntu
# docker run -d -p 5000-5020:5000-5020 -p 2222:22 my-ubuntu
