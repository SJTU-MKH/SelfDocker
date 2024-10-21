FROM ros:noetic

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

RUN apt install -y wget git unzip cmake libeigen3-dev

RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777
RUN mkdir /bag  
COPY *.zip /bag

ENV DEBIAN_FRONTEND=noninteractive

RUN cd /bag && \
    unzip osqp.zip && \
    cd osqp && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install

RUN cd /bag && \
    unzip osqp-eigen.zip && \
    cd osqp-eigen-0.8.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install 

RUN apt-get install -y ros-noetic-robot-state-publisher* ros-noetic-joint-state-controller* ros-noetic-controller* ros-noetic-velocity-controllers* \
    ros-noetic-effort-controllers ros-noetic-position-controllers ros-noetic-gazebo-ros-control ros-noetic-hector-gazebo ros-noetic-effort-controllers \
    ros-noetic-joint-state-controller ros-noetic-position-controllers ros-noetic-pcl-ros ros-noetic-ompl

RUN apt-get install -y ros-noetic-xacro ros-noetic-rviz
RUN ln -s /opt/ros/noetic/include/ompl-1.6/ompl /opt/ros/noetic/include/ompl

RUN cd / && git clone https://github.com/ZJU-FAST-Lab/uneven_planner.git

RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash; cd /uneven_planner; catkin_make'

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN apt install -y python3-tk ros-noetic-ackermann-msgs