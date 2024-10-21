#! /usr/bin/env bash

L_USER=${USER}

if [ ${#} -ne 0 ]; then
  echo -e "\nUsage: \033[1;31mbash ${0}\033[0m\n" ; exit 1
fi

function for_kinetic() {
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/kinetic\/rosdistro/g' /opt/ros/kinetic/rosdistro/rosdep/sources.list.d/20-default.list
  cp /opt/ros/kinetic/rosdistro/rosdep/sources.list.d/20-default.list /etc/ros/rosdep/sources.list.d/
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/kinetic\/rosdistro/g' /usr/lib/python2.7/dist-packages/rosdep2/sources_list.py
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/kinetic\/rosdistro/g' /usr/lib/python2.7/dist-packages/rosdistro/__init__.py
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/kinetic\/rosdistro/g' /usr/lib/python2.7/dist-packages/rosdep2/rep3.py
  sed -i "s/https:\/\/raw.githubusercontent.com\/ros\/rosdistro/file:\/\/\/opt\/ros\/kinetic\/rosdistro/g" /usr/lib/python2.7/dist-packages/rosdep2/gbpdistro_support.py
  sed -i "s/master\/releases\/fuerte.yaml/releases\/fuerte.yaml/g" /usr/lib/python2.7/dist-packages/rosdep2/gbpdistro_support.py
}

function for_melodic() {
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/melodic\/rosdistro/g' /opt/ros/melodic/rosdistro/rosdep/sources.list.d/20-default.list
  cp /opt/ros/melodic/rosdistro/rosdep/sources.list.d/20-default.list /etc/ros/rosdep/sources.list.d/
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/melodic\/rosdistro/g' /usr/lib/python2.7/dist-packages/rosdep2/sources_list.py
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/melodic\/rosdistro/g' /usr/lib/python2.7/dist-packages/rosdistro/__init__.py
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/melodic\/rosdistro/g' /usr/lib/python2.7/dist-packages/rosdep2/rep3.py
  sed -i "s/https:\/\/raw.githubusercontent.com\/ros\/rosdistro/file:\/\/\/opt\/ros\/melodic\/rosdistro/g" /usr/lib/python2.7/dist-packages/rosdep2/gbpdistro_support.py
  sed -i "s/master\/releases\/fuerte.yaml/releases\/fuerte.yaml/g" /usr/lib/python2.7/dist-packages/rosdep2/gbpdistro_support.py
}

function for_noetic() {
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/noetic\/rosdistro/g' /opt/ros/noetic/rosdistro/rosdep/sources.list.d/20-default.list
  cp /opt/ros/noetic/rosdistro/rosdep/sources.list.d/20-default.list /etc/ros/rosdep/sources.list.d/
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/noetic\/rosdistro/g' /usr/lib/python3/dist-packages/rosdep2/sources_list.py
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/noetic\/rosdistro/g' /usr/lib/python3/dist-packages/rosdistro/__init__.py
  sed -i 's/https:\/\/raw.githubusercontent.com\/ros\/rosdistro\/master/file:\/\/\/opt\/ros\/noetic\/rosdistro/g' /usr/lib/python3/dist-packages/rosdep2/rep3.py
  sed -i "s/https:\/\/raw.githubusercontent.com\/ros\/rosdistro/file:\/\/\/opt\/ros\/noetic\/rosdistro/g" /usr/lib/python3/dist-packages/rosdep2/gbpdistro_support.py
  sed -i "s/master\/releases\/fuerte.yaml/releases\/fuerte.yaml/g" /usr/lib/python3/dist-packages/rosdep2/gbpdistro_support.py
}

if [ -d "/etc/ros/rosdep/sources.list.d" ] ; then
  echo -e "exist /etc/ros/rosdep/sources.list.d !" 
else
  mkdir "/etc/ros/rosdep/sources.list.d" -p
fi

if [ -d "/opt/ros/kinetic" ] ; then
  echo -e "\n\033[1;32m>>> ROS:kinetic + PYTHON:python2.7 <<<\033[0m\n"
  if [ -d "/opt/ros/kinetic/rosdistro" ] ; then rm -rf /opt/ros/kinetic/rosdistro ; fi
  git clone https://gitee.com/ohhuo/rosdistro.git /opt/ros/kinetic/rosdistro
  if [ ${?} -ne 0 ]; then  
    echo -e "\033[0;33m\nWORNING: git clone from gitee failed !\033[1m" ; 
    git clone https://github.com/ros/rosdistro.git /opt/ros/kinetic/rosdistro ; 
    if [ ${?} -ne 0 ]; then  echo -e "\033[0;31m\nERROR: git clone from github and gitee failed !\033[1m" ; exit 1 ; fi
  fi
  for_kinetic
elif [ -d "/opt/ros/melodic" ] ; then
  echo -e "\n\033[1;32m>>> ROS:melodic + PYTHON:python2.7 <<<\033[0m\n"
  if [ -d "/opt/ros/melodic/rosdistro" ] ; then rm -rf /opt/ros/melodic/rosdistro ; fi
  git clone https://gitee.com/ohhuo/rosdistro.git /opt/ros/melodic/rosdistro
  if [ ${?} -ne 0 ]; then  
    echo -e "\033[0;33m\nWORNING: git clone from gitee failed !\033[1m" ; 
    git clone https://github.com/ros/rosdistro.git /opt/ros/melodic/rosdistro ; 
    if [ ${?} -ne 0 ]; then  echo -e "\033[0;31m\nERROR: git clone from github and gitee failed !\033[1m" ; exit 1 ; fi
  fi
  for_melodic
elif [ -d "/opt/ros/noetic" ] ; then
  echo -e "\n\033[1;32m>>> ROS:noetic + PYTHON:python3 <<<\033[0m\n"
  if [ -d "/opt/ros/noetic/rosdistro" ] ; then rm -rf /opt/ros/noetic/rosdistro ; fi
  git clone https://gitee.com/ohhuo/rosdistro.git /opt/ros/noetic/rosdistro
  if [ ${?} -ne 0 ]; then  
    echo -e "\033[0;33m\nWORNING: git clone from gitee failed !\033[1m" ; 
    git clone https://github.com/ros/rosdistro.git /opt/ros/noetic/rosdistro ; 
    if [ ${?} -ne 0 ]; then  echo -e "\033[0;31m\nERROR: git clone from github and gitee failed !\033[1m" ; exit 1 ; fi
  fi
  for_noetic
else
  echo -e "\n\033[1;31mERROR: ROS does not exist !\033[0m\n" ; exit 1
fi

rosdep init
rosdep update

if [ ${?} -eq 0 ]; then 
  echo -e "\n\033[1;32m>>> Successfully execute [rosdep init] & [rosdep update] <<< \033[0m\n~by streamwill" ; exit 0
else 
  echo -e "\033[0;31m\nFailed to execute [rosdep init] & [rosdep update] !\033[1m" ; exit 1
fi