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


locationfname='mylocations.txt'
part1='nginx--part1.txt'
nginxconfig='nginx--myconfig.com'

# sed -e "s/\${myuser}/marcelo/" -e "s/\${myport}/5004/" mytemplate
function generate_location() {
  mylist=$(members ${GROUP})
  myoffset=$(cat /etc/myoffset.conf)

  cat $part1 > $nginxconfig;

  # touch $locationfname
  for usr in ${mylist[@]}; do
      myid=$(id -u ${usr})
      myport=$(( $myid + $myoffset ))
      # echo "user --> ${usr} - id: ${myid} -- port: ${myport}"
      sed -e "s/\${_myuser_}/${usr}/" -e "s/\${_myport_}/${myport}/" ./mytemplate >> $nginxconfig
  done

  echo "}" >> $nginxconfig;
}


# usermod -aG ${GROUP} <username>
# groupadd ${GROUP}
# members ${GROUP}

# service nginx restart

create_users_v3
generate_location
