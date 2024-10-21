FROM ros:foxy-noetic-go2

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

RUN apt install -y git unzip cmake libusb-dev python3-tk

RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777
RUN rm -rf /catkin_ws/* /build && mkdir -p catkin_ws/ros1_dev/src && mkdir -p catkin_ws/ros2_dev/src

RUN apt install -y ros-noetic-realsense2-description ros-noetic-realsense2-camera && \
    mkdir -p /etc/udev/rules.d/ && \
    wget https://raw.githubusercontent.com/IntelRealSense/librealsense/master/config/99-realsense-libusb.rules -O /etc/udev/rules.d/99-realsense-libusb.rules
    
RUN cd /catkin_ws/ros2_dev/src && git clone https://github.com/SJTU-MKH/go2_ros2_ws.git && \
    cd /catkin_ws/ros1_dev/src && git clone https://github.com/HongbiaoZ/autonomous_exploration_development_environment.git --recursive -b noetic-rgbd-camera && \
    git clone https://github.com/Livox-SDK/livox_ros_driver2.git --recursive && \
    git clone https://github.com/hku-mars/FAST_LIO.git --recursive && \
    git clone https://github.com/Livox-SDK/livox_ros_driver.git && \
    cd /catkin_ws && \
    git clone https://github.com/Livox-SDK/Livox-SDK2.git

RUN cd /catkin_ws/Livox-SDK2/ && \
    mkdir build && cd build && \
    cmake .. && make -j16 && make install && \
    rm -rf /catkin_ws/Livox-SDK2/

RUN cd /catkin_ws/ros1_dev/src/autonomous_exploration_development_environment 
COPY autonomous_exploration_environments.zip /catkin_ws/ros1_dev/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh 
RUN cd /catkin_ws/ros1_dev/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh && unzip *.zip && rm -rf *.zip

RUN zsh -c 'source /opt/ros/noetic/setup.zsh; cd /catkin_ws/ros1_dev/src/livox_ros_driver2; ./build.sh ROS1'

RUN zsh -c 'source /unitree_ros2/unitree_ros2_setup.sh; cd /catkin_ws/ros2_dev; colcon build'

ENTRYPOINT ["./ros_entrypoint.sh"]
