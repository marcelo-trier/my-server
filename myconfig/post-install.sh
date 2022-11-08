#!/bin/bash

function manage_simlinks {
    ln -s /opt/myconfig/nginx--myconf.conf /etc/nginx/sites-enabled/myconf.conf;
    ln -s /opt/myconfig/mylocations.conf /etc/nginx/mylocations.conf;
    unlink /etc/nginx/sites-enabled/default;
};

function add_services {
    sudo -u tunnel mkdir -p /home/tunnel/.ssh 
    sudo -u tunnel touch /home/tunnel/.ssh/known_hosts
    sudo -u tunnel ssh-keyscan localhost.run >> /home/tunnel/.ssh/known_hosts
    sudo -u tunnel ssh-keygen -t ed25519 -N '' -f /home/tunnel/.ssh/id_ed25519;
};

function clear_tmpdata {
    apt-get autoclean && apt clean;
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;
};

manage_simlinks;
add_services;
# clear_tmpdata;
