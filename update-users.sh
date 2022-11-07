#!/bin/bash

# caso queira baixar a lista de usuarios a ser criada, descomente as linhas abaixo..
#url='http://marcelo-pereira.neocities.org/list-users.txt'
#wget $url

filename='my-users.db'
myuser='developer'
GROUP="developer"

function create_users_v3() {
  cp -R /root/app /opt/
  cp -R /root/app /etc/skel/

  useradd --create-home --shell /bin/bash ${myuser}
  echo "${myuser}:mypwd@123!" | chpasswd
  usermod -aG sudo ${myuser}

  echo '..creating users..'
  mylist=$(sed 's/#.*//' ${filename}) 
  for str in ${mylist[@]}; do
    IFS=':' read myusr mypwd <<< $str

    useradd --create-home --shell /bin/bash --groups ${GROUP} ${myusr}
    echo $str | chpasswd
    #passwd --expire $myusr
  done
}

# usermod -aG ${GROUP} <username>
# groupadd ${GROUP}
# members ${GROUP}

fuction add_command() {
  dest='/usr/local/bin/'
  mycmd='myport'
  from="/root/${mycmd}.sh"

  cd ${dest}
  cp ${from} ${dest}
  chmod a+x "${mycmd}.sh"
  ln -s ${mycmd}.sh ${mycmd}
}

create_users_v3
add_command
