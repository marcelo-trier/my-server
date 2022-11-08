#!/bin/bash

# start webserver: nginx
nginx

# start ssh connections..
mkdir -p /var/run/sshd;
/usr/sbin/sshd;  # -D


# inicia tunelamento com a internet...
function start_tunnel() {
    sudo -u tunnel ssh -R 80:localhost:8080 localhost.run | tee /opt/myconfig/tunnel-output.txt
    # https://ded0b633f29b5c.lhr.life
};

start_tunnel


