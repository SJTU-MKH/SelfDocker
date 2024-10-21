FROM osrf/ros:melodic-desktop-full

# 换源
RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

RUN apt install -y cmake libusb-dev python3-tk  libgoogle-glog-dev libgflags-dev libatlas-base-dev && \
    mkdir -p ~/catkin_ws/src && \
    mkdir -p ~/deps

WORKDIR /root/deps
RUN git clone https://ceres-solver.googlesource.com/ceres-solver && \
    cd ceres-solver && \
    mkdir build && cd build && \
    cmake .. && make -j16 && make install && \
    cd ../..

RUN apt install -y libcanberra-gtk-module libcanberra-gtk3-module

WORKDIR /
ENTRYPOINT ["./ros_entrypoint.sh"]
