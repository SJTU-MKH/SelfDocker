FROM osrf/ros:noetic-desktop-full

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

### ompl
RUN apt install ros-noetic-ompl -y

RUN apt install curl git -y
### protobuf 无法curl下载，所以先download到本地再COPY
# RUN curl https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protobuf-cpp-3.13.0.tar.gz 
COPY protobuf-cpp-3.13.0.tar.gz protobuf-cpp-3.13.0.tar.gz
RUN tar -xf protobuf-cpp-3.13.0.tar.gz && rm -rf protobuf-cpp-3.13.0.tar.gz && \
    cd /protobuf-3.13.0/ && ./configure && \
    make -j16 && \
    make check && make install && cd .. && rm -rf protobuf-cpp-3.13.0* &&\
    ldconfig 

RUN apt-get install python3-wstool python3-catkin-tools ros-noetic-cmake-modules protobuf-compiler autoconf

## 根据自己电脑的设置改git，提前设置pigchali 无gui版
RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777
## 编译依赖
RUN apt install libtool ros-noetic-grid-map ros-noetic-catkin -y
RUN mkdir -p /smug_ws/src && \
    cd /smug_ws && \
    catkin init && cd src && \
    git clone https://github.com/leggedrobotics/smug_planner.git && \
    cd smug_planner && \
    git clone https://github.com/leggedrobotics/voxblox.git -b fix/namespace_gflags && \
    wstool init . ./voxblox/voxblox_https.rosinstall && \
    wstool update

RUN cd /smug_ws/src && \
    catkin config \
      --extend /opt/ros/$ROS_DISTRO && \
    catkin build smug_planner_ros
RUN sed -i '/exec "$@"/i \
            source "/smug_ws/devel/setup.bash"' /ros_entrypoint.sh

RUN apt install -y zsh autojump  \
    && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && rm -rf ~/.zshrc
COPY .zshrc /root/.zshrc
RUN chsh -s /usr/bin/zsh

CMD ["zsh"]

ENTRYPOINT ["./ros_entrypoint.sh"]