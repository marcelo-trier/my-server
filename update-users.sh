#!/bin/bash

# caso queira baixar a lista de usuarios a ser criada, descomente as linhas abaixo..
#url='http://marcelo-pereira.neocities.org/list-users.txt'
#wget $url

filename='list-users.txt'

function create_users_v3() {
  cp -R /root/app /opt/
  cp -R /root/app /etc/skel/

  echo '..creating users..'
  mylist=$(sed 's/#.*//' ${filename}) 
  for str in ${mylist[@]}; do
    IFS=':' read myusr mypwd <<< $str

    useradd --create-home --shell /bin/bash ${myusr}
    echo $str | chpasswd
    #passwd --expire $myusr
  done
}

create_users_v3

