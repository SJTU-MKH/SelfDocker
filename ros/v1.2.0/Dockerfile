FROM markhui/ros:v1.1.0

RUN cd ~/ && git clone https://github.com/unitreerobotics/unitree_sdk2.git &&\
    cd unitree_sdk2 && chmod +x install.sh &&\
    ./install.sh &&\
    mkdir build && cd build &&\
    cmake .. && make -j8

RUN cd /catkin_ws/ros1_dev/src && \
    git clone https://github.com/SJTU-MKH/go2_ros1_ws.git

RUN zsh -c "source /opt/ros/noetic/setup.zsh; cd /catkin_ws/ros1_dev; catkin_make --pkg go2_ros1_ws"

ENTRYPOINT ["./ros_entrypoint.sh"]
