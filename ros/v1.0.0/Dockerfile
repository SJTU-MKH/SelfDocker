FROM ros:foxy-noetic-go2

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

RUN apt install -y git unzip

RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777
RUN cd / && mkdir -p catkin_wc/src && cd catkin_wc/src && \ 
    git clone https://github.com/HongbiaoZ/autonomous_exploration_development_environment.git -b noetic-rgbd-camera && \
    cd autonomous_exploration_development_environment

COPY autonomous_exploration_environments.zip /catkin_wc/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh 
RUN cd /catkin_wc/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh && unzip *.zip && rm -rf *.zip

RUN apt install -y cmake libusb-dev python3-tk
RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash; cd /catkin_wc; catkin_make'

RUN cd / && git clone https://github.com/Livox-SDK/livox_ros_driver2.git ws_livox/src/livox_ros_driver2
RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash; cd /ws_livox/src/livox_ros_driver2; ./build.sh ROS1'

ENTRYPOINT ["./ros_entrypoint.sh"]