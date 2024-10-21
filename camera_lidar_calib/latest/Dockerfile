FROM markhui/ros:foxy-noetic-go2-amd-base

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

RUN git clone https://github.com/Livox-SDK/Livox-SDK.git && \
    cd Livox-SDK && \
    cd build && cmake .. && \
    make -j16 && make install && \
    cd ../..

RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git && \
    cd Livox-SDK2 && \
    mkdir build && cd build && cmake .. && \
    make -j16 && make install && \
    cd ../../.. && rm -rf deps

# pcl-tools 用于可视化pcd点云，gdb用于vscode调试ROS c++代码
RUN apt install -y libcanberra-gtk-module libcanberra-gtk3-module && \
    apt install -y pcl-tools gdb
# WORKDIR /root/catkin_ws/src

# RUN git clone https://github.com/Livox-SDK/livox_camera_lidar_calibration.git && \
#     git clone git clone https://github.com/Livox-SDK/livox_ros_driver.git

# RUN sed -i 's/set(CMAKE_CXX_FLAGS "-std=c++11")/set(CMAKE_CXX_FLAGS "-std=c++14")/' livox_camera_lidar_calibration/CMakeLists.txt && \
#     RUN sed -i 's/ceres::LocalParameterization \* q_parameterization = new ceres::EigenQuaternionParameterization()/ceres::Manifold \*q_parameterization = new ceres::EigenQuaternionManifold()/' livox_camera_lidar_calibration/src/cam_lid_external1.cpp && \
#     RUN sed -i 's/ceres::LocalParameterization \* q_parameterization = new ceres::EigenQuaternionParameterization()/ceres::Manifold \*q_parameterization = new ceres::EigenQuaternionManifold()/' livox_camera_lidar_calibration/src/cam_lid_external2.cpp
WORKDIR /
ENTRYPOINT ["./ros_entrypoint.sh"]
