FROM nvidia/cudagl:11.2.1-devel-ubuntu18.04


RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    apt-get clean && \
    apt-get -y update  && apt -y install \
    freeglut3-dev clang-format build-essential cmake \
    xorg-dev libglu1-mesa-dev


RUN apt update -y && apt install libusb-dev -y
RUN apt-get install -y lsb-release gnupg


RUN sh -c '. /etc/lsb-release && echo "deb https://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
RUN mkdir ~/.gnupg && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

RUN gpg --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN gpg --export C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 | tee /usr/share/keyrings/ros.gpg > /dev/null

RUN apt install -y curl
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt-get update -y
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
RUN apt-get -y install ros-melodic-desktop-full \
 && echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

RUN apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential -y 
RUN apt install -y python-pip wget

RUN rosdep init & cd /
COPY ros.sh /
RUN chmod +x ros.sh && ./ros.sh
RUN rosdep update

RUN cd / && mkdir -p catkin_ws/src && cd catkin_ws/src && \ 
    git clone https://gitee.com/joosoo/autonomous_exploration_development_environment.git && \
    cd autonomous_exploration_development_environment && \
    git checkout melodic
COPY autonomous_exploration_environments.zip /catkin_ws/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh 
RUN cd /catkin_ws/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh && unzip *.zip && rm -rf *.zip

RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make'
