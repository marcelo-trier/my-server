#!/bin/bash

# caso queira baixar a lista de usuarios a ser criada, descomente as linhas abaixo..
#url='http://marcelo-pereira.neocities.org/list-users.txt'
#wget $url

filename='my-users.db'
myuser='developer'
GROUP="developer"

echo -e "\nMYPORT_OFFSET=4000\n" > /etc/environment
source /etc/environment
printenv;

myoffset=$MYPORT_OFFSET

function create_admin {
  cp -R ./app /etc/skel/;

  useradd --create-home --shell /bin/bash ${myuser};
  echo "${myuser}:mypwd@123!" | chpasswd;
  usermod -aG sudo ${myuser};
};

function create_users {
  echo "testing myoffset ==> ${myoffset}"
  mylist=$(sed 's/#.*//' ${filename});
  for str in ${mylist[@]}; do
    IFS=':' read myusr mypwd <<< $str

    useradd --create-home --shell /bin/bash --groups ${GROUP} ${myusr}
    echo $str | chpasswd
    #passwd --expire $myusr
  done;

  useradd --create-home --shell /bin/bash tunnel;


};

locationfname='mylocations.conf';
template='mytemplate';
function generate_location {
  mylist=$(members ${GROUP})

  for usr in ${mylist[@]}; do
      myid=$(id -u ${usr})
      myport=$(($myid + $myoffset))
      sed -e "s/\${_myuser_}/${usr}/" -e "s/\${_myport_}/${myport}/" $template >> $locationfname
  done;
};

# usermod -aG ${GROUP} <username>
# groupadd ${GROUP}
# members ${GROUP}

create_admin;
create_users;
generate_location;
